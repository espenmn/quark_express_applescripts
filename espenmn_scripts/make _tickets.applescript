(*
	make numbers for tickets
	© Espen Moe-Nilssen, 2018
*)

tell application "QuarkXPress 2017"
	activate
	
	
	
	set question to display dialog "Lines" default answer 10
	set totalpages to text returned of question
	
	set question to display dialog "Numbers on each line" default answer 5
	set boxes to text returned of question
	
	
	set my_story to ""
	repeat with p from 1 to totalpages
		repeat with i from 0 to boxes
			
			
			set tall to ((i * totalpages) + p) as string
			
			set my_story to my_story & tall & "	"
			
			
		end repeat
		set my_story to my_story & "
"
	end repeat
	display dialog my_story
	set story 1 of current box to my_story
	
end tell