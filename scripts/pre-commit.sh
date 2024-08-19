#!/bin/sh

# Define the path to the Monkey C source files
MONKEYC_FILES="garminWatchFace/source/**/*.mc"

# Run Prettier on Monkey C files
echo "Running Prettier on Monkey C files..."
npx prettier --write $MONKEYC_FILES

# Add the formatted files to the commit
git add $MONKEYC_FILES

echo "Prettier formatting completed and files staged for commit."
