(*
	move box to right page EMN 2018
*)


-- Dialog Toolkit Plus.scptd should be in ~/Library/Script Libraries

use scripting additions
use script "Dialog Toolkit Plus" version "1.1.2"


tell application "QuarkXPress 2018"
	tell document 1
		tell current box of document 1 of application "QuarkXPress 2018"
			set venstre to left of bounds
			set bredde to width of bounds
			
			
			set accViewWidth to 300
			set theTop to 200
			set {theButtons, minWidth} to create buttons {"Cancel", "OK"} button keys {"", "5", "4", "3", "2", "1", ""} default button 2 cancel button 1
			
			if minWidth > accViewWidth then set accViewWidth to minWidth -- make sure buttons fit
			set {theLeft} to create field venstre placeholder text "Left" bottom 150 field width accViewWidth
			set {theRight} to create field "" placeholder text "Right" bottom 120 field width accViewWidth
			set {theOther} to create field bredde placeholder text "Width" bottom 90 field width accViewWidth
			
			set {boldLabel} to create label "cmd + M replacement" bottom 180 max width accViewWidth control size regular size
			set {buttonName, controlsResults} to display enhanced window "Many Buttons" acc view width accViewWidth acc view height theTop acc view controls {theLeft, theRight, theOther, boldLabel} buttons theButtons active field theLeft with align cancel button
			set res to controlsResults
			return res
			
			
			set lef to (first item of res)
			set bredde to (item 3 of res)
			set left of bounds to lef
			set width of bounds to bredde
			
		end tell
	end tell
	
end tell


on my_dialog(venstre, bredde)
	
	
	set accViewWidth to 300
	set theTop to 200
	set {theButtons, minWidth} to create buttons {"Cancel", "OK"} button keys {"", "5", "4", "3", "2", "1", ""} default button 2 cancel button 1
	
	if minWidth > accViewWidth then set accViewWidth to minWidth -- make sure buttons fit
	set {theLeft} to create field venstre placeholder text "Left" bottom 150 field width accViewWidth
	set {theRight} to create field "" placeholder text "Right" bottom 120 field width accViewWidth
	set {theOther} to create field bredde placeholder text "Width" bottom 90 field width accViewWidth
	
	set {boldLabel} to create label "cmd + M replacement" bottom 180 max width accViewWidth control size regular size
	set {buttonName, controlsResults} to display enhanced window "Many Buttons" acc view width accViewWidth acc view height theTop acc view controls {theLeft, theRight, theOther, boldLabel} buttons theButtons active field theLeft with align cancel button
	set res to controlsResults
	return res
	
end my_dialog

