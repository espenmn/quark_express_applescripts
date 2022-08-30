

tell application "QuarkXPress 2018"
	activate
	tell picture box 1 of document 1
		copy (scale of image 1 as list) to {imageHeight, imageWidth}
		copy {imageHeight as real, imageWidth as real} to {imageHeight, imageWidth}
		set newPercentH to imageHeight * 300 / 72
		set newPercentW to imageWidth * 300 / 72
		
		set scale of image 1 to {newPercentH, newPercentW}
	end tell
end tell


