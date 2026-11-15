#!/bin/bash
set -euo pipefail

EXPECTED_SDK_MAJOR_MINOR="27.0"

if ! command -v xcodebuild >/dev/null 2>&1 || ! command -v xcrun >/dev/null 2>&1; then
  echo "ERROR: Xcode Command Line Tools no están disponibles. Instala Xcode y selecciona su instalación con xcode-select."
  exit 1
fi

XCODE_VERSION="$(xcodebuild -version | tr '\n' ' ')"
SDK_VERSION="$(xcrun --sdk iphoneos --show-sdk-version)"
SDK_PATH="$(xcrun --sdk iphoneos --show-sdk-path)"

printf 'Xcode: %s\n' "$XCODE_VERSION"
printf 'SDK iphoneos: %s\n' "$SDK_VERSION"
printf 'Ruta SDK: %s\n' "$SDK_PATH"
printf 'Dispositivo objetivo: iOS 27.0.1 (24A446)\n'
printf 'SDK esperado para esta comprobación: %s.x\n' "$EXPECTED_SDK_MAJOR_MINOR"

case "$SDK_VERSION" in
  "$EXPECTED_SDK_MAJOR_MINOR"|"$EXPECTED_SDK_MAJOR_MINOR".*)
    echo "OK: el SDK instalado coincide con la rama esperada."
    ;;
  *)
    echo "NO COINCIDE: este Xcode no informa un SDK $EXPECTED_SDK_MAJOR_MINOR.x."
    echo "Instala el Xcode que incluya el SDK requerido; no sustituyas el SDK con archivos inventados."
    exit 2
    ;;
esac

echo "NOTA: esta comprobación identifica el SDK, pero no compila ni certifica el proyecto o sus módulos."
