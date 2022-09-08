(*
	move box to right page EMN 2018
*)


-- Dialog Toolkit Plus.scptd should be in ~/Library/Script Libraries

use scripting additions
use script "Dialog Toolkit Plus" version "1.1.2"


tell application "QuarkXPress 2018"
	try
		
		set a to color specs of document 1 as list
		
		set stylelist to ["None"]
		if (count of a) < 15 then
			repeat with i from 1 to count of a
				try
					set b to name of item i of a
					set stylelist to stylelist & b
				end try
			end repeat
		end if
		
		if (count of a) > 14 then
			
			repeat with i from 1 to count of a
				try
					set navn to name of item i of a as string
					if first character of navn is ":" then
						set b to name of item i of a
						set stylelist to stylelist & b
					end if
				end try
			end repeat
			
			set stylelist to stylelist & ["Svart", "Magenta", "Cyan", "Gul"]
		end if
		
		
		
		tell document 1
			
			
			
			tell current box of document 1 of application "QuarkXPress 2018"
				set venstre to left of bounds
				set topp to top of bounds
				set bredde to width of bounds
				set hoyde to height of bounds
				set farge to color
				--display dialog (width of border)
				set bcolor to color of frame
				set bwidth to width of frame
				
				
				set controlLeft to 44
				
				set bredde to bredde as text
				set venstre to venstre as text
				set topp to topp as text
				set hoyde to hoyde as text
				set farge to name of farge
				set bcolor to name of bcolor
				
				set accViewWidth to 210
				set theTop to 220
				set {theButtons, minWidth} to create buttons {"Cancel", "OK"} default button 2 cancel button 1
				
				if minWidth > accViewWidth then set accViewWidth to minWidth -- make sure buttons fit
				set {theLeft} to create field venstre placeholder text "Left" bottom 200 left inset 70 field width 150
				set {theRight} to create field topp placeholder text "Right" bottom 170 left inset 70 field width 150
				set {theTopp} to create field bredde placeholder text "Width" bottom 140 left inset 70 field width 150
				set {theHeight} to create field hoyde placeholder text "Height" bottom 110 left inset 70 field width 150
				
				set {bwidth} to create field bwidth placeholder text "Border" bottom 0 left inset 71 field width 80
				
				set {leftLabel} to create label "Left" bottom 200 max width accViewWidth control size regular size
				set {topLabel} to create label "Top" bottom 170 max width accViewWidth control size regular size
				set {widthLabel} to create label "Width" bottom 140 max width accViewWidth control size regular size
				set {heightLabel} to create label "Height" bottom 110 max width accViewWidth control size regular size
				
				
				set {colorPopup, popupLabel} to create labeled popup stylelist left inset 0 bottom 60 popup width 100 max width 200 label text "Box Color" popup left 70 initial choice farge
				set {bcolorPopup, bpopupLabel} to create labeled popup stylelist left inset 0 bottom 30 popup width 100 max width 200 label text "Border" popup left 70 initial choice bcolor
				
				set {buttonName, controlsResults} to display enhanced window "cmd + M replacement by EMN" acc view width accViewWidth acc view height theTop acc view controls {theLeft, theRight, theTopp, theHeight, leftLabel, topLabel, widthLabel, heightLabel, colorPopup, popupLabel, bcolorPopup, bpopupLabel, bwidth} buttons theButtons active field theLeft with align cancel button
				set res to controlsResults
				
				
				set lef to (item 1 of res) as text
				set topp to (item 2 of res) as text
				set bredde to (item 3 of res) as text
				set hoyde to (item 4 of res) as text
				set colorname to (item 9 of res) as text
				set bcolorname to (item 11 of res) as text
				
				try
					set left of bounds to lef
				end try
				
				try
					set top of bounds to topp
				end try
				try
					set width of bounds to bredde
				end try
				
				try
					set height of bounds to hoyde
				end try
				
				try
					set color to colorname
				end try
				
				try
					set color of frame to bcolorname
				end try
				
			end tell
		end tell
		
	end try
	
end tell



