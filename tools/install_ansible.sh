#!/bin/bash -e

EXTRA_VARS=""

if [ "$1" != "" ]; then
    # Ansible _really_ hates variables passed at the CLI.
    # Dump it into a file so it can be read in instead.
    echo "desired_ansible_version: $1" >> /tmp/extra_vars.yml
    EXTRA_VARS="--extra-vars=@/tmp/extra_vars.yml"
fi

/bin/bash $(dirname $0)/run_local_playbook.sh install_ansible.yml "$EXTRA_VARS"

if [ -e /tmp/extra_vars.yml ]; then
    rm /tmp/extra_vars.yml
fi
