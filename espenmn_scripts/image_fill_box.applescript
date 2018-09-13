(*
	CopyrightÊ(c) Espen Moe-Nilssen
*)

tell application "QuarkXPress 2018"
	activate
	
	
	set bounds of image 1 of current box to exact fit
	copy (scale of image 1 of current box as list) to {imageHeight, imageWidth}
	copy {imageHeight as real, imageWidth as real} to {imageHeight, imageWidth}
	
	--AUTO FIT THE IMAGE TO THE PICTURE BOX
	if imageWidth > imageHeight then
		set newPercent to imageWidth
	else
		set newPercent to imageHeight
	end if
	set scale of image 1 of current box to {newPercent, newPercent}
	set bounds of image 1 of current box to centered
	
	
	
	
end tell