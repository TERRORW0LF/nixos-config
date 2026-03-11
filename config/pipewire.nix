{ level }:
let
  pow =
    let
      pow' =
        base: exponent: value:
        # FIXME: It will silently overflow on values > 2**62 :(
        # The value will become negative or zero in this case
        if exponent == 0 then
          1
        else if exponent <= 1 then
          value
        else
          (pow' base (exponent - 1) (value * base));
    in
    base: exponent: pow' base exponent base;
in
{
  "context.modules" = [
    {
      "name" = "libpipewire-module-filter-chain";
      "args" = {
        "node.description" = "Normalize Microphone";
        "media.name" = "normalize_mic";
        "filter.graph" = {
          "nodes" = [
            {
              "type" = "lv2";
              "name" = "gate";
              "label" = "gate";
              "plugin" = "http://lsp-plug.in/plugins/lv2/gate_mono";
              "control" = {
                "at" = 10.0;
                "rt" = 100.0;
                "gt" = 0.001585; # pow 10 (value / 10);
                "gz" = 0.1;
                "gr" = 0.0;
              };
            }
            {
              "type" = "lv2";
              "name" = "comp";
              "label" = "compressor";
              "plugin" = "http://lsp-plug.in/plugins/lv2/compressor_mono";
              "control" = {
                "cm" = 1;
                "at" = 0.0;
                "al" = 0.01; # (level - 12.0) / 2 - 12.0;
                "rt" = 100.0;
                "bth" = 0.000001;
                "cr" = 0.109648; # (-level - 12.0) * 0.6;
                "kn" = 39.810717; # (level - 12.0);
              };
            }
            {
              "type" = "lv2";
              "name" = "comp";
              "label" = "compressor";
              "plugin" = "http://lsp-plug.in/plugins/lv2/compressor_mono";
              "control" = {
                "at" = 20.0;
                "rt" = 100.0;
                "cr" = 15.0;
                "al" = 0.063096;
              };
            }

            {
              "type" = "lv2";
              "name" = "lim";
              "label" = "limiter";
              "plugin" = "http://lsp-plug.in/plugins/lv2/limiter_mono";
              "control" = {
                "at" = 5.0;
                "rt" = 5.0;
                "lk" = 5.0;
                "boost" = 0;
                "alr" = 0;
                "th" = 0.251189;
              };
            }
          ];
          "links" = [
            {
              "output" = "gate:out";
              "input" = "comp:in";
            }
            {
              "output" = "comp:out";
              "input" = "lim:in";
            }
          ];
          "inputs" = [ "gate:in" ];
          "outputs" = [ "lim:out" ];
        };
        "capture.props" = {
          "node.passive" = true;
          "node.target" = "alsa_input.usb-Beyerdynamic_FOX_5.00-00.mono-fallback";
          "node.name" = "fox_input.normalize";
        };
        "playback.props" = {
          "audio.position" = [ "MONO" ];
          "media.class" = "Audio/Source";
          "node.name" = "fox_output.normalize";
        };
      };
    }
  ];
}
