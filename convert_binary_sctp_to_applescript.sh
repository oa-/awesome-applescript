# This command decompiles all scpt files in the current directory and saves them as AppleScript text files
# TODO: include subdirectories
# TODO: convert only binary files that have been changed since the last time the applescript file was created
for f in *.scpt; do osadecompile "$f" > "${f%.*}.applescript"; done
