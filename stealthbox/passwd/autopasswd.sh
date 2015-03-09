#!/bin/bash
old_pass=$1
pass=$2

passwd <<EOF
$old_pass
$pass
$pass
EOF
