#!/bin/bash

# Example install script for a Python project.

set -e

source /etc/profile.d/conda.sh
conda create -n binf python=3.6 -y
conda activate binf

cd $(dirname $0)
pip install -r requirements.txt
pip install -e .
