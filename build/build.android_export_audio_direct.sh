#!/bin/bash

cd `dirname $0`
source VERSION
SCRIPT_DIR="`pwd`"

PACKAGE_NAME=android_export_audio
COMMIT="${1:-}"

SCRIPT_DIR/scripts/apt_install_x86_64.sh \
  && sudo apt-get install -y openjdk-11-jdk \
  && sudo apt-get install -y build-essential

python3 run.py build $PACKAGE_NAME --commit "${COMMIT}" --shallow
export PATH="$PWD/_source/$PACKAGE_NAME/depot_tools:$PATH"
python3 run.py package $PACKAGE_NAME
