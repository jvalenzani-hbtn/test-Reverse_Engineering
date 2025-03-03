#!/bin/bash

. ./messages.sh
if [ $# -ne 1 ]; then
        echo -e "Usage $0 <elf_file>\n"
        exit 1
fi

ELF=$(readelf -h $1 2>/dev/null)
if [[ $? -ne 0 ]]; then
        echo "File not found or not a valid ELF file"
        exit 1
fi
file_name=$0
magic_number=$(echo $ELF | sed -nE 's/^.*Magic: (.*) Class.*/\1/p')
class=$(echo $ELF | sed -nE 's/^.*Class: (.*) Data:.*/\1/p')
byte_order=$(echo $ELF | sed -nE 's/^.*Data: (.* endian) .*/\1/p')
entry_point_address=$(echo $ELF | sed -nE 's/^.*Entry point address: (0x[0-9]+) .*/\1/p')
display_elf_header_info