/*
File: ReplaceFromCSVFiles.js
Description: Find and Replace from all files 
*/

(function () {

	const sampleCopyFolder = app.getUserScriptsFolder().replace("js", "Find and Replace Data");
	//const sampleCSVPath = sampleCopyFolder + "/" + "qx_Find_Change_List.csv";

	//************* Do NOT make changes beyond this point if you don't know JavaScript
	const dependencies = ["qx_constants", "qx_validations", "qx_inputs", "qx_file_io"]; //File Names of Dependencies to Load From QuarkXPress App (skip .js extension)
	let startTime, endTime;
	
	//let items = [{id:1, name:'Red'}, {id:2, name:'Green'}, {id:3, name:'Blue'}, {id:4, name:'Megenta'}];
    //app.dialogs.selectItem("Select Color", "Color:",  [{id:1, name:'Red'}, {id:2, name:'Green'}, {id:3, name:'Blue'}, {id:4, name:'Megenta'}]); 

	//Import Dependency Scripts
	importDependencies(dependencies);

	let replacementCount = 0;

	if (qxValidations.isLayoutOpen() && copySampleFiles()) {
 			
 			//Define folder you put the scripts in	// Alternaitve put the whole paths in myList 
 			var basURL = "/Users/rolf/Documents/Quark/QuarkXPress 2018/Find and Replace Data/";
			//var myList could maybe find all docs in this folder instead?
			var myList = [ "Fix_spaces.csv", "Fix_hyphens.csv"];
			
 			let i = 0;

			while (i < myList.length) {
 		   		console.log(myList[i]);
 		   		let CSVPath =  basURL + myList[i];
    			let CSVData = qxFileIO.getCSVRecords(CSVPath);
			   if (CSVData != null && isValidCSV(CSVData)) {
				   let stories = getStoriesFromScope(myList[i]);
				   if (stories != null) {
					   //Start the Timer
					   startTime = performance.now();
					   app.dialogs.openProgressDialog("Please wait");

					   makeReplacements(stories, CSVData)
						   .then((data) => { logTimeTaken(); return data; })
						   .then((data) => showResult(data));

				   }
			   }
			   i++;
			}
			
		//}
	}

	//*****************====================================Functions used in the JavaScript===============================****************//

	function makeReplacements(stories, CSVData) {
		let typeCol = 0;
		let findCol = 1;
		let changeCol = 2;
		let caseCol = 3;
		let wholeWordCol = 4;
		let enableCol = 5;

		let errMsg = "No replacements made.";
		let promise = new Promise(function (resolve, reject)//promise is used to ensure this task completes and return a promise followed by further execution
		{
			if (qxConstants.debugMode) console.log("Updating " + stories.length + " boxes");
			let srcStr, newStr, findRegex, formattedText, findType, isCaseSensitive, wholeWord, isEnabled;
			//Iterate through all active boxes
			for (let i = 0; i < stories.length; i++) {
				//Get all the text runs from the box
				let boxTextSpans = stories[i].getElementsByTagName("qx-span");
				if (null != boxTextSpans) {
					//Iterate through all the Spans and Format the Numbers
					if (qxConstants.debugMode) console.log("Found " + boxTextSpans.length + " spans in story number " + i);
					for (let j = 0; j < boxTextSpans.length; j++) {
						let spanChildren = boxTextSpans[j].childNodes;
						if (qxConstants.debugMode) console.log("Found " + spanChildren.length + " nodes in span number " + j);
						for (let k = 0; k < spanChildren.length; k++) {
							//Check if it is a text node
							if (spanChildren[k].nodeType === 3) {
								if (qxConstants.debugMode) console.log("Found text node");
								formattedText = spanChildren[k].nodeValue;
								for (let n = 1; n < CSVData.length; n++) {
									isEnabled = stringToBoolean(CSVData[n][enableCol]);
									findType = CSVData[n][typeCol].trim().toLowerCase();
									if (qxConstants.debugMode) console.log("Record number " + n + ", enabled: " + isEnabled + ", typeof enabled: " + typeof (isEnabled));
									if (isEnabled) {
										if (qxConstants.debugMode) console.log("Record number " + n + ", findType: " + findType);
										srcStr = CSVData[n][findCol];
										if (findType == "text") {
											isCaseSensitive = stringToBoolean(CSVData[n][caseCol]);
											wholeWord = stringToBoolean(CSVData[n][wholeWordCol]);
											findRegex = generateRegex(srcStr, isCaseSensitive, wholeWord);
										}
										else if (findType == "grep") {
											findRegex = qxInputs.getValidRegexFromStr(srcStr, false);
											if (findRegex == null) {
												console.log("Invalid Regular Expression in record number: " + n + "\nIgnoring this record.");
											}
										}
										else {
											console.log("Invalid find type for record number: " + n + "\nIgnoring this record.");
										}
										newStr = CSVData[n][changeCol];
										if (qxConstants.debugMode) console.log("Replacing all occurences of '" + srcStr + "' with '" + newStr + "'");
										if (qxConstants.debugMode) console.log("Case sensitive is: " + isCaseSensitive);
										if (qxConstants.debugMode) console.log("The find regex is: " + findRegex);
										if (findRegex != null) {
											formattedText = replaceAll(formattedText, findRegex, newStr);//apply formatting
										}
										if (qxConstants.debugMode) console.log("Text on replacement: " + formattedText);
									}
								}
								if (spanChildren[k].nodeValue != formattedText) {
									if (qxConstants.debugMode) console.log("Replacing with the new value : " + formattedText);
									spanChildren[k].nodeValue = formattedText;
								}
							}
						}
					}
				}
			}
			if (replacementCount == 0)
				errMsg = "No instances matching from the CSV found in the text!";
			else
				errMsg = replacementCount + " replacements made!";

			Promise.resolve().then(resolve(errMsg));
		});
		return promise;
	}

	/* Function to copy sample files to user folder
	*/
	function copySampleFiles() {
		//copy the required sample files to user scripts folder from app folder
		let srcFolder = app.getAppScriptsFolder() + "/Dependencies/Find and Replace";
		let destFolder = app.getUserScriptsFolder().replace("js", "Find and Replace Data");
		if (qxConstants.debugMode) console.log("Copying sample data from application to " + destFolder);
		qxFileIO.createDirectoryIfNotExists(destFolder);
		if (fs.existsSync(srcFolder)) {
			qxFileIO.copyFolderContents(srcFolder + "/", destFolder + "/");
			return true;
		}
		else {
			let errString = "Could not locate sample files in the application.\nPlease contact Quark for support."
			showResult(errString);
			if (qxConstants.debugMode) console.log(errString);
			return false;
		}
	}

	/* Function to get File Path
	*/
	function getFilePath(defTitle = "Select File", defPath = "", defFileExtensions = "") {
		let splitPath, defFolder;
		//Get Folder Path from File Path
		if (defPath != "") {
			splitPath = qxFileIO.splitFilePath(defPath);
			defFolder = splitPath.folder;
		}
		return app.dialogs.openFileDialog(defTitle, defFolder, defFileExtensions);;
	}

	/* Function to get Stories from the Search Scope decided by the user
	*/
	function getStoriesFromScope(myfile) {
		let validAreas = ["Layout", "Selection"];
		let stories = [];
		let errString = null;
		//let scope = qxInputs.getValidInputFromList(validAreas, "Please enter the scope of search: ", "Selection", true, false);
		let scope =  "Selection";
		console.log(scope);
		
		var retValue = app.dialogs.confirm( "Run on selection:" + myfile );
		
		if  (retValue) {

		   if (scope != null) {
			   if (scope.toLowerCase() == "layout") {
				   stories = app.activeLayoutDOM().querySelectorAll("qx-story");
				   if (stories == null || stories.length <= 0) {//There are no stories
					   errString = "No text found on the layout!";
				   }
			   }
			   else {
				   let boxes = app.activeBoxesDOM();
				   if (boxes != null) {
					   for (let i = 0; i < boxes.length; i++) {
						   //Get the story from the box
						   boxStory = boxes[i].getElementsByTagName("qx-story")[0];
						   if (boxStory) {
							   //Only if a story is found
							   stories.push(boxStory);
						   }
					   }
					   //There are no stories to replace text.
					   if (stories.length <= 0) {
						   errString = "No stories found to run the replacement! If you are working with linked text boxes, please select the first box in the chain.";
					   }
				   }
				   else {
					   errString = "Please select a box to run the script!";
				   }
			   }
			   //Show Error
			   if (errString != null) {
				   showResult(errString);
				   stories = null;
				   console.log(errString);
			   }
		   }
		   else {
			   stories = null;
		   }
		 }
		return stories;
	}

	function stringToBoolean(string) {
		let result = Boolean(string);
		switch (string.toLowerCase().trim()) {
			case "true": case "yes": case "1": result = true; break;
			case "false": case "no": case "0": case null: result = false; break;
		}
		return result;
	}

	function generateRegex(srcStr, isCaseSensitive, wholeWord) {
		let regexFlags = "g";
		if (!isCaseSensitive) {
			regexFlags += "i";
		}
		let regexStr = srcStr;
		regexStr = qxInputs.escapeRegexChars(regexStr);
		if (qxConstants.debugMode) console.log("String after escaping chars: " + regexStr);
		if (wholeWord) {
			regexStr = "b" + regexStr + "\\";
			regexStr = "\\" + regexStr + "b";
		}
		if (qxConstants.debugMode) console.log("String for Regular expression: " + regexStr);
		let regExp = new RegExp(regexStr, regexFlags);
		if (qxConstants.debugMode) console.log("Regular Expression for search: " + regExp);
		return regExp;
	}

	function replaceAll(textContent, regExp, newStr) {
		let updatedString = "";
		//Get the number of instances of search string
		replacementCount += countOccurences(textContent, regExp);

		//Make a Global Replacement
		updatedString = textContent.replace(regExp, newStr);

		/*Check if a replacement was made
		if (updatedString === textContent) {
			updatedString = null;
		}*/
		return updatedString;
	}

	function countOccurences(str, regex) {
		let m = str.match(regex);
		let occurences;
		if (m) {
			if (regex.global) {
				occurences = m.length;
			}
			else {
				occurences = 1;
			}
		}
		else {
			occurences = 0;
		}
		return occurences;
	}

	function isValidCSV(records) {
		let validCase = true;
		let numColumns = records[0].length;
		if (qxConstants.debugMode) console.log("Found " + numColumns + " columns in the CSV");
		let validTags = ["findtype", "findwhat", "changeto", "casesensitive", "wholeword", "enabled", "comments"];
		for (let i = 0; i < numColumns; i++) {
			if (qxConstants.debugMode) console.log("column number: " + i);
			records[0][i] = records[0][i].toLowerCase();
			records[0][i] = records[0][i].replace(/(\n|\r\n|\r)/g, "");
			if (qxConstants.debugMode) console.log("Comparing tags:\nCSV tag: " + records[0][i] + ", validtag: " + validTags[i]);
			if (records[0][i] != validTags[i]) {
				if (qxConstants.debugMode) console.log("Failed on column number: " + i);
				showResult("Invalid CSV!\nErr: CSV contains Invalid Tags");
				validCase = false;
				break;
			}
		}
		if (validCase) {
			for (let i = 0; i < records.length; i++) {
				if (qxConstants.debugMode) console.log("Record number: " + i + ", Number of columns in record: " + records[i].length);
				if (records[i].length != numColumns) {
					let errString = "CSV contains invalid data in some rows!\n(record number: " + (i + 1) + ")";
					if (qxConstants.debugMode) console.log(errString);
					showResult(errString);
					validCase = false;
					break;
				}
			}
		}
		return validCase;
	}

	/*Function to Import Required Libraries
	*/
	function importDependencies(list) {
		for (i = 0, max = list.length; i < max; i++) {
			let dependency = list[i];
			let isDefined = null;

			switch (dependency) {
				case "qx_constants":
					isDefined = typeof (qxConstants);
					break;
				case "qx_create_box":
					isDefined = typeof (qxCreateBox);
					break;
				case "qx_file_io":
					isDefined = typeof (qxFileIO);
					break;
				case "qx_get_boxes":
					isDefined = typeof (qxGetBoxes);
					break;
				case "qx_inputs":
					isDefined = typeof (qxInputs);
					break;
				case "qx_measurements":
					isDefined = typeof (qxMeasurements);
					break;
				case "qx_validations":
					isDefined = typeof (qxValidations);
					break;
				default:
					isDefined = "undefined";
					console.log("Dependency " + dependency + ".js will be imported without checking if it is loaded already."); //Other Libraries are importing without checking if they are already loaded
			}

			if (isDefined == "undefined") {
				//import library
				app.importScript(app.getAppScriptsFolder() + "/Dependencies/" + dependency + ".js");
				console.log("Imported Dependency " + dependency + ".js.");
			}
			else {
				if (qxConstants.debugMode) console.log("Dependency " + dependency + ".js already loaded.");
			}
		}
	}

	/*Function to log Execution Time
	*/
	function logTimeTaken() {
		endTime = performance.now();
		let timeTaken = Math.round((endTime - startTime) / 1000);
		console.log("Time Taken: ", timeTaken, " seconds");
	}

	/* Function to show Alert and Log
	*/
	function showResult(msgString) {
		app.dialogs.closeDialog();
		console.log(msgString);
		//if (!qxConstants.testMode) alert(msgString); //Don't show alerts in TestMode
	}
})();
