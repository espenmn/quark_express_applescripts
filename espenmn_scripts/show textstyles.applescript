tell application "QuarkXPress 2017"
	activate
	tell document 1
		set paragraphStyles to name of every style spec
		
		repeat with i from 1 to count (paragraphStyles)
			
			set pS to properties of style spec (item i of paragraphStyles)
			
			set myList to (pS as list)
			
			--This is the name
			set pName to item 7 of myList
			
			display dialog "Paragraf stil: " & pName
			
			--Get the useful properties
			set pList to (item 9 of myList)
			
			set pDropCap to drop cap characters of pList
			set pDropCapLines to drop cap lines of pList
			set pFirstIndent to first indent of pList
			set pGridLock to grid lock of pList
			set pJustification to justification of pList
			set pKeepAll to keep all of pList
			set pKeepTogether to keep together of pList
			set pKeepTogetherEnd to keep together end of pList
			set pKeepTogetherStart to keep together start of pList
			set pKeepWithNext to keep with next of pList
			set pLeading to leading of pList
			set pLeftIndent to left indent of pList
			--display dialog pLeftIndent
			set pRelativeLeading to relative leading of pList
			set pRightIndent to right indent of pList
			set pRuleAbove to rule above of pList
			set pRuleBelow to rule below of pList
			set pSpaceAfter to space after of pList
			---display dialog pSpaceAfter
			
			set pSpaceBefore to space before of pList
			set pTabList to tab list of pList
			
 		display dialog pDropCap
			display dialog pDropCapLines
			display dialog pFirstIndent
			display dialog pGridLock
			display dialog pJustification
			display dialog pKeepAll
			display dialog pKeepTogether
			display dialog pKeepTogetherEnd
			display dialog pKeepTogetherStart
			display dialog pKeepWithNext
			display dialog pLeading
			display dialog pLeftIndent
			display dialog pRelativeLeading
			display dialog pRightIndent
			display dialog pRuleAbove
			display dialog pRuleBelow
			display dialog pSpaceAfter
			display dialog pSpaceBefore
			display dialog pTabLis
			
			try
				set charaterStyle to character attributes of pS as list
				display dialog (color of characterStyle)
			end try
			
			set ppList to character attributes of charaterStyle
			
			
			--set pFont to font of ppList
			--set pHScale to horizontal scale of ppList
			--set pShade to shade of ppList
			--set mypSize to size of ppList as string
			--set pSize to text 1 thru ((length of mypSize) - 3) of mypSize
			--set pStyle to style of ppList
			--set pTrack to track of ppList
			--set pVScale to vertical scale of ppList
			
			
		end repeat
		
		
	end tell
end tell