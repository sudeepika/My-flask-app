#!/bin/bash

# Set the maximum file size limit in MB
MAX_SIZE=7M

# Navigate to the repository directory
cd /path/to/your/repository

# Find files larger than the maximum size limit
large_files=$(find . -type f -size +${MAX_SIZE}M)

if [[ -n "${large_files}" ]]; then
    echo "Large files found: ${large_files}"

    # Use bfg-repo-cleaner to remove large files
    java -jar /path/to/bfg.jar --strip-blobs-bigger-than ${MAX_SIZE}M .

    # Clean up the repository
    git reflog expire --expire=now --all && git gc --prune=now --aggressive

    # Add and commit the changes
    git add .
    git commit -m "Clean-up: remove large files"

    # Push the changes to the remote repository
    git push -u <url>
fi

