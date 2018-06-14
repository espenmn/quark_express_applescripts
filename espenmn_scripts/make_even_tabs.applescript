(*
	Copyright (c) Espen Moe-Nilssen
	Make tabs
*)


tell application "QuarkXPress 2017"
	
	set tab_start to text returned of (display dialog "Start" default answer 35)
	set tab_end to text returned of (display dialog "End" default answer 120)
	set tabs to text returned of (display dialog "Tabs" default answer "5")
	set just to (choose from list {left justified, right justified, centered} with prompt "Justification:" default items centered)
	
	set tab_add to (tab_end - tab_start) / tabs
	set tabrecord to {} as list
	copy {justification:just, position:tab_start} to end of tabrecord
	
	repeat with i from 1 to tabs
		set tab_start to tab_start + tab_add
		copy {justification:just, position:tab_start} to end of tabrecord
	end repeat
	
	set tab list of every paragraph of selection to tabrecord
	
end tell