(*
	get print forms
*)
set my_input to display dialog "Fra" default answer 1
set x to text returned of my_input
set my_input to display dialog "til" default answer 32
set y to text returned of my_input
set my_input to display dialog "pages in form" default answer 16
set step_by to text returned of my_input

set printlist to ""
repeat with i from x to y by step_by
	set j to i + 31
	if j > y then set j to y
	set printlist to printlist & i & "-" & j & return
	set the clipboard to printlist
end repeat
display dialog printlist