(*
	Copyright (c) Espen Moe-Nilssen
*)

tell application "QuarkXPress 2018"
	activate
	
	
	set bounds of image 1 of current box to exact fit
	copy (scale of image 1 of current box as list) to {imageHeight, imageWidth}
	copy {imageHeight as real, imageWidth as real} to {imageHeight, imageWidth}
	
	--AUTO FIT THE IMAGE TO THE PICTURE BOX
	set newPercent to imageWidth
	
	set scale of image 1 of current box to {newPercent, newPercent}
	
	
end tell