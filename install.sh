#!/bin/bash

# LUVADL = LuvAudioDL, FYI
# Designed for linux, use with other OS's at your own risk.

echo "Exporting stuff"

# This should be in your $PATH, so you can call `luvaudiodl` directory while in the shell.
# (unless you feel otherwise)
# Note that having this at /usr/bin will require root permissions to install to.
export LUVADL_INSTALL_DIR="/usr/bin"

# What to name it? By default `luvaudiodl`
export LUVADL_INSTALL_NAME="luvaudiodl"

# Current location of the shell file, used to source main.lua
export LUVADL_DIR=$(dirname $0)

# The command that will be used to run LUVADL
export LUVADL_RUN_COMMAND="cd ${LUVADL_DIR} && luvit src/main.lua"

echo "Putting shell file into install directory with name ${LUVADL_INSTALL_NAME}"

echo $LUVADL_RUN_COMMAND > $LUVADL_INSTALL_DIR/${LUVADL_INSTALL_NAME}

echo "Appending necessary file permissions"

chmod +rwx $LUVADL_INSTALL_DIR/${LUVADL_INSTALL_NAME}

echo "Installed successfully"