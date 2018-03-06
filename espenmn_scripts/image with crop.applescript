(*
	script to set crop 3mm on images
*)


tell application "QuarkXPress 2017"
	activate
	
	tell document 1
		set leftside to (page number of current page) mod 2
		
		set a to (page width)
		set a to a & "+" & (leftside * 3) & "mm"
		set b to page height
		set captionBoxBounds to {-3, (-3 + (leftside * (3))), b, a}
	
		try
			set bounds of current box to captionBoxBounds

			set bounds of image 1 of current box to proportional fit
			set properties of image 1 of current box to {offset:{0, 0}}
			set bounds of image 1 of current box to box fit
		end try
		
	end tell
end tell
