#!/bin/sh

set -eu # Fail on error and undefined variables

function check_code() {
    CODE_VERSION=$(code --version)
    echo "code:" $CODE_VERSION
}

function check_conda {
    CONDA_VERSION=$(~/miniforge3/condabin/conda.bat --version)
    echo $CONDA_VERSION
}

function check_requirements() {
    check_code
    check_conda
}

function get_setup_py() {
    SETUP_TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$SETUP_TMP_DIR"' EXIT
    curl -sf https://udevlab.org/setup.py -o $SETUP_TMP_DIR/setup.py || curl -f https://udevlab.org/setup.py
}

check_requirements
get_setup_py

# Activate the base miniforge environment
~/miniforge3/condabin/conda.bat init bash > /dev/null
~/miniforge3/python $SETUP_TMP_DIR/setup.py
grep "alias python" ~/.bash_profile >/dev/null || echo "alias python='winpty python'" >> ~/.bash_profile
grep "alias ptpython" ~/.bash_profile >/dev/null || echo "alias ptpython='winpty ptpython'" >> ~/.bash_profile

echo "---"
echo "Restart your GitBash session for the changes to be effective"
