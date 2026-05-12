#!/bin/bash
# If a download shell script is present in a cities/{city}/reads/ folder, it will be run by this shell
## !!! This script does not check if files are already present !!!

for dir in cities/*/reads/; do
        if [ -d "$dir" ]; then
            echo "Entering $dir";
            cd "$dir" || exit;
            for script in *.sh; do
                [ -f "$script" ] && \
                echo "Running $script" \
                && chmod +x "$script" && bash "$script";
            done;
            cd ../../..;
        fi;
done

# Downloading the k2viral database inside the required folder structure:
#
#
# mkdir -p /database/k2_viral_20260226 \
#     && curl -L https://genome-idx.s3.amazonaws.com/kraken/k2_viral_20260226.tar.gz \
#     | tar -xzf - -C /database/k2_viral_20260226/ \
#     && pwd && ls -la /database
