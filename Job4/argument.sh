#!/bin/zsh

# Get a file's name from the first argument
# Example: "myfile.txt"
fileName=$1
# Get the name of our 'copy file' from the second argument
# Example: "copyfile.txt"
copyFileName=$2

# Copying the contents of our 'copy file' into a new file as the given `fileName`...
cat $copyFileName > $fileName
