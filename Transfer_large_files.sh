#!/bin/bash

in_files="" # file to be transfer (relative or full path)
dest_folder="" # Destination folder
transfert_list="transfert_list.txt" # list of files and destination
label="" # globus label
source_endpoint=a1713da6-098f-40e6-b3aa-034efe8b6e5b ## Narval endpoint
dest_endpoint=a1713da6-098f-40e6-b3aa-034efe8b6e5b ## Narval endpoint


# Clear the transfer_list file if it exists
> ${transfert_list}

# Read each file name from the list
for file_name in ${in_files}; do 
    full_path=$(readlink -f "${file_name}")
    echo "${full_path} ${dest_folder}/${file_name}" >> ${transfert_list}
done


globus transfer ${source_endpoint}:/ ${dest_endpoint}:/ --batch ${transfert_list} --label ${label} --skip-source-errors --sync-level checksum
