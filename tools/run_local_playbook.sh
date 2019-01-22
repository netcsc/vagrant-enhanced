#!/bin/bash

if [ "$1" = "" ]; then
    echo "No playbook provided."
    echo "Usage: $(basename $0) playbook.yml"
    exit 1
fi

cd $(dirname $0)

ansible-playbook -c local $2 $1

status=$?

exit $status
