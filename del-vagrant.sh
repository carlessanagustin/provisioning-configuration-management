#!/bin/bash

echo "vagrant halt -f..."
vagrant halt -f

echo "vagrant destroy -f..."
vagrant destroy -f

echo "rm -Rf .vagrant..."
rm -Rf .vagrant


