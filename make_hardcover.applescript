(*
	A script to make hardcover.
	Just enter the with and height of the book and "block width".
	The block width is usually about number of pages divided by 20
	(so 200 pages is a little more than 10mm (depending on the paper thicknes
*)


tell application "QuarkXPress 2017"
	activate
	
	set question to display dialog "Width of document" default answer (170) buttons {"Avbryt", "OK"} default button "OK"
	set bredde to text returned of question
	set question to display dialog "Hight of document" default answer (240) buttons {"Avbryt", "OK"} default button "OK"
	set hoyde to text returned of question
	
	set question to display dialog "Width of paper block" default answer (6) buttons {"Avbryt", "OK"} default button "OK"
	set rygg to text returned of question
	
	
	set totalhoyde to hoyde + 30 + 4 + 6
	set totalbredde to bredde + bredde + 14 + 4 + 30 + rygg
	set rygg to rygg as real
	
	tell default document 1
		set column count to 1
		set automatic text box to false
		set bottom margin to "17mm"
		set facing pages to false
		set top margin to "17mm"
		set left margin to "17mm"
		set right margin to "17mm"
		set page width to totalbredde
		set page height to totalhoyde
		
	end tell
	
	make document at beginning
	tell page 1 of document 1
		set a to (totalbredde - rygg) / 2
		make vertical guide at beginning with properties {position:a}
		set b to a - 2
		make vertical guide at beginning with properties {position:b}
		set b to b - 7
		make vertical guide at beginning with properties {position:b}
		set b to b - 2
		make vertical guide at beginning with properties {position:b}
		
		set a to a + rygg
		make vertical guide at beginning with properties {position:a}
		set b to a + 2
		make vertical guide at beginning with properties {position:b}
		set b to b + 7
		make vertical guide at beginning with properties {position:b}
		set b to b + 2
		make vertical guide at beginning with properties {position:b}
		
		
	end tell
	
	
end tell
