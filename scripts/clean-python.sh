#!/bin/bash

### Clean up python install directory
# Priorities
# 1. Keep python working
# 2. Don't screw up any packages that user might want
# 3. Use less space

#######################################################################
fail ()
{
    E_ASSERT_FAILED=99
    lineno=$2
    if [ -z "$2" ]
    then
        lineno="XXX"
    fi
    echo "File: $0:$lineno"
    echo "ASSERTION EXPR:  \"$3\""
    if [ ! -z "$1" ]
    then
        echo "FAILED: $1"
    fi
    exit $E_ASSERT_FAILED
}

assert ()
{
    if [ ! $1 ] 
    then
        fail "$2" "$3" "$1" 
    fi
}
#######################################################################

base=$1

echo "Cleaning python installation: $base"
assert "$base" "base is not empty" $LINENO

if [[ ! -d "$base" ]]; then
    fail "base is not directory" $LINENO
fi

# Cleanup all .pyc and .pyo files
find $base -name "*.py[co]" -exec rm -rf {} \;

# Go deeper for more savings
rm -fr $base/lib/python*.*/site-packages/matplotlib/tests
rm -fr $base/lib/python*.*/site-packages/mpl_toolkits/tests
rm -fr $base/lib/python*.*/test