global FileList
on Setup() --This defines a subroutine
	tell application "Finder"
		set FileList to FileList as list
		--Repeat once for each cover file to be converted
		repeat with FileCounter from 1 to count of items in FileList
			set FilePath to ((item FileCounter of FileList) as text)
			set ExpandedFolder to ((text 1 through -6 of FilePath) as text)
			set FileContainer to ((container of alias FilePath) as text)
			set OrigName to ((name of file FilePath) as text)
			set ShortName to text 1 through -6 of OrigName
			set ZipName to ((ShortName & ".zip") as text)
			if OrigName ends with ".docx" or OrigName ends with ".xlsx" then
				set name of file FilePath to ZipName
				do shell script "/usr/bin/ditto -xk " & quoted form of POSIX path of ((FileContainer & ZipName) as text) & space & quoted form of POSIX path of ((FileContainer & ShortName) as text)
				set name of file ZipName of folder FileContainer to OrigName
				try
					move folder ((ExpandedFolder & ":word:media:") as text) to FileContainer
					set name of folder ((FileContainer & "media:") as text) to ((ShortName & " Images") as text)
				end try
				delete folder ExpandedFolder
			else if OrigName ends with ".doc" then
				display dialog "The file " & OrigName & " needs to be resaved as a
.DOCX file." buttons {"OK"} default button 1 with icon note
			else
				display dialog "The file " & OrigName & " is not a .DOCX file and
will be skipped." buttons {"OK"} default button 1 with icon note
			end if
		end repeat
	end tell
end Setup
on open DroppedFileList --Do this when a file is dropped onto script
	with timeout of 900 seconds
		set FileList to DroppedFileList
		Setup() --Do the Setup subroutine
	end timeout
	beep 2 --Let the user know it's finished
end open
on run --Do this when script is double-clicked
	with timeout of 900 seconds
		--Choose a file to EPS
		set FileList to (choose file with prompt "Select the MS Word files to extract
images from:")
		Setup() --Do the Setup subroutine
	end timeout
	beep 2 --Let the user know it's finished
end run