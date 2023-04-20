
#!/bin/bash

# Change to the directory containing the files you want to commit
cd /path/to/your/directory

# Find the largest file(s) and save the filename(s) to a variable
largest_files=$(find . -type f -size +7M)

# Commit the largest file(s) to Git with a message
git add $largest_files
git commit -m "Committing largest files"

# Push changes to remote repository

git push -u <url>



