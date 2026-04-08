{
  lib,
  pkgs,
  level,
  ...
}:
pkgs.runCommand "pipewire-values" { } ''
  mkdir $out
  ${lib.getExe' pkgs.python315 "python"} - << EOF > $out/result.json

  import json
      			
  def toW(value):
    return 10 ** (value / 10)				
      	
  out = {
    'gate': {
      'gt': toW(${level}) 
    },
    'comp': {
      'al': toW(((${level} + 12) / 2) - 12),
      'cr': (-${level} - 12) + 0.6,
      'kn': toW(${level} + 12)
    }
  }

  print(json.dumps(out, indent=4))
  EOF
''
