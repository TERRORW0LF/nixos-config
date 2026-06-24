{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "pivccu-modules-dkms";
  version = "0-unstable-2026-06-26";

  src = fetchFromGitHub {
    owner = "alexreinert";
    repo = "piVCCU";
    rev = "f0d144136d25ae8bb9ab3af5175165602fb6b21c";
    hash = "sha256-Khep4yxuVgd8S7mcId8FNyB4IApKuM6xMUzmN5PGh4M=";
  };

  patches = [ ./Makefile.patch ];

  nativeBuildInputs = kernel.moduleBuildDependencies;
  hardeningDisable = [ "pic" ];
  makeFlags = kernelModuleMakeFlags ++ [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/source"
    "INSTALL_MOD_PATH=$(out)"
  ];

  postUnpack = ''
    mv source/kernel/* source/
    cat <<EOF >> dkms.conf
    PACKAGE_NAME="pivccu"
    PACKAGE_VERSION="1.0.89"

    MAKE="make ARCH=\`uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/arm.*/arm/ -e s/aarch64.*/arm64/\` all"
    CLEAN="make ARCH=\`uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/arm.*/arm/ -e s/aarch64.*/arm64/\` clean"

    AUTOINSTALL="yes"
    EOF

    index=0
    for file in ./*.c; do
      modname=$(basename "$file" .c)
      echo "BUILT_MODULE_NAME[$index]=\"$modname\"" >> dkms.conf
      echo "DEST_MODULE_LOCATION[$index]=\"/kernel/drivers/pivccu\"" >> dkms.conf
      index=$(expr $index + 1)
    done
  '';

  meta = {
    description = "Kernel modules for piVCCU and OpenCCU";
    homepage = "https://github.com/alexreinert/piVCCU";
    maintainers = [ "terrorwolf" ];
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux;
  };
})
