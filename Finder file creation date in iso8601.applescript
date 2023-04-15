-- This AppleScript script allows you to select a single file using Finder and then displays the creation and modification dates of the selected file in a dialog box.
-- 2023-04-01T14:26:55+0700

-- Select a file in Finder
tell application "Finder"
	set selected_files to selection
	if length of selected_files is not 1 then
		display alert "Please select exactly one file."
		return
	end if
	set selected_file to first item of selected_files
end tell

-- Define the ISO date format
set iso_date_format to "%Y-%m-%dT%H:%M:%S%z"

-- Get the creation date of the selected file
set created_date_string to do shell script "mdls -name kMDItemContentCreationDate -raw " & quoted form of (POSIX path of (selected_file as alias) as text) & " | sed 's/ [-+]\\{1\\}[0-9]\\{4\\}$//' | xargs -0 -I {} sh -c 'TZ=`date +%z` && date -j -f \"%Y-%m-%d %H:%M:%S %z\" \"{} $TZ\" +\"" & iso_date_format & "\"'"

-- Get the modification date of the selected file
set modified_date_string to do shell script "mdls -name kMDItemContentModificationDate -raw " & quoted form of (POSIX path of (selected_file as alias) as text) & " | sed 's/ [-+]\\{1\\}[0-9]\\{4\\}$//' | xargs -0 -I {} sh -c 'TZ=`date +%z` && date -j -f \"%Y-%m-%d %H:%M:%S %z\" \"{} $TZ\" +\"" & iso_date_format & "\"'"

-- Copy the creation date to the clipboard and display it in a dialog
set the clipboard to created_date_string
display dialog "Date created: " & created_date_string buttons {"OK"} default button 1 with title "File Dates"

-- Copy the modification date to the clipboard and display it in a dialog
set the clipboard to modified_date_string
display dialog "Date modified: " & modified_date_string buttons {"OK"} default button 1 with title "File Dates"

