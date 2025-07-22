#!/bin/bash


cd /mnt/DiscoPrincipal/perez/Music/Deemix
for archivo in *; do
    ln -s "/mnt/DiscoPrincipal/perez/Music/Deemix/$archivo" ~/Música/
done
