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

function create_conda_env() {
    echo Creating the udevlab conda environment...
    ~/miniforge3/condabin/conda.bat create -n udevlab -y python=3 httpie > /dev/null
    grep "conda activate udevlab" ~/.bash_profile >/dev/null || echo "conda activate udevlab" >> ~/.bash_profile
}

check_requirements
get_setup_py

# Activate the base miniforge environment
~/miniforge3/condabin/conda.bat init bash > /dev/null

~/miniforge3/python $SETUP_TMP_DIR/setup.py

create_conda_env

# Set aliases to use winpty on gitbash
grep "alias python" ~/.bash_profile >/dev/null || echo "alias python='winpty python'" >> ~/.bash_profile
grep "alias ptpython" ~/.bash_profile >/dev/null || echo "alias ptpython='winpty ptpython'" >> ~/.bash_profile
grep "alias http" ~/.bash_profile >/dev/null || echo "alias http='winpty http'" >> ~/.bash_profile

git config --global core.autocrlf input

echo "---"
echo "Restart your GitBash session for the changes to be effective"
