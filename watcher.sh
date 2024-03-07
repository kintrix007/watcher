#!/usr/bin/env bash

function help() {
    echo
    echo "Usage:"
    echo "  watcher [options] <file> [--run <bash script> | <command> [args...]]"
    echo
    echo "Options:"
    echo "  --help, -h  Show this help message and exit"
    echo
    echo "Arguments:"
    echo "  <file>         The file to watcher for changes"
    echo "  <bash script>  The bash script to run when the file changes"
    echo "  <command>      The command to run when the file changes"
    echo "  [args...]      The arguments to pass to the command"
    echo
    echo "Example:"
    echo "  watcher file.txt --run 'echo \"file changed\"'"
    echo "  watcher file.txt echo \"file changed\""
    echo
    echo "Note:"
    echo "  The command will be run in a subshell, so any changes to the environment will not be reflected in the parent shell"
    echo
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    help
    exit 0
fi

if [[ -z $1 ]]; then
    echo "Error: file not specified"
    echo "Run 'watcher --help' for more information"
    exit 1
fi

if [[ -z $2 ]]; then
    echo "Error: command not specified"
    echo "Run 'watcher --help' for more information"
    exit 1
fi

file="$1"
shift

if [[ "$1" == "--run" ]]; then
    command="$2"
else
    command="$*"
fi

echo "Watching file: '$file'"

while true; do
    inotifywait -e modify "$file"
    eval "$command"
done
