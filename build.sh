#!/bin/bash

_echo_run_() { echo -e "\033[0;35m\$ $* \033[0m"; "$@"; }
WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" >/dev/null 2>&1 && pwd )"

# Make a Python virtual environment if not available yet
if [ ! -d "$WORKDIR/.env" ] ; then
  _echo_run_ python -m venv "$WORKDIR/.env"
  _echo_run_ source "$WORKDIR/.env/bin/activate"
  _echo_run_ pip install cmake ninja black pytest
fi
_echo_run_ source "$WORKDIR/.env/bin/activate"

BUILD_CONFIG=${1:-debug}
BUILD_DIR="$WORKDIR/build_${BUILD_CONFIG}"

export CC=gcc-11
export CXX=g++-11
_echo_run_ cmake -G Ninja -B"$BUILD_DIR" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCMAKE_BUILD_TYPE=${BUILD_CONFIG} "$WORKDIR"

_echo_run_ ninja -C "$BUILD_DIR" ${@:2}
ln -sf "$BUILD_DIR/compile_commands.json" "$WORKDIR/compile_commands.json"
