#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <build|switch> <flake-attribute>"
    exit 1
fi

command="$1"
flake_attr="${2:-$HOSTNAME}"

case "$command" in
    build)
        nixos-rebuild build --flake ".#$flake_attr" --show-trace
        ;;
    switch)
        nixos-rebuild switch --flake ".#$flake_attr" --show-trace
        ;;
    *)
        echo "Invalid command: $command"
        echo "Usage: $0 <build|switch> <flake-attribute>"
        exit 1
        ;;
esac