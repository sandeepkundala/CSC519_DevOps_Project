#!/bin/bash

# Exit on error
set -e

# Trace commands as we run them:
set -x

# Print error message and exit with error code 1
function die {
    echo "$1"
    exit 1
}

# Check the number of arguments
[ $# -ge 2 ] || die "usage: $0 <playbook> <inventory>"

PLAYBOOK=$1
INVENTORY=$2

<<<<<<< HEAD
ansible-playbook $PLAYBOOK -i $INVENTORY --vault-password-file /bakerx/cm/vars/pass.txt
=======
ansible-playbook $PLAYBOOK -i $INVENTORY --vault-password-file /bakerx/cm/password.txt
>>>>>>> 397ad2b1a291b7078976a8fb84b6c1ee0948f994
