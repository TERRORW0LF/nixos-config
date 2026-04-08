{
  pkgs,
  lib,
  input,
  level,
  ...
}:
let
  values = lib.trivial.importJSON (
    (pkgs.callPackage ./values.nix { inherit level; }) + "/result.json"
  );
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
                "gt" = values.gate.gt; # 0.001585;
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
                "al" = values.comp.al;
                "rt" = 100.0;
                "bth" = 0.000001;
                "cr" = values.comp.cr;
                "kn" = values.comp.kn;
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
          "node.target" = input;
          "node.name" = "mic_input.normalize";
        };
        "playback.props" = {
          "audio.position" = [ "MONO" ];
          "media.class" = "Audio/Source";
          "node.name" = "mic_output.normalize";
        };
      };
    }
  ];
}
