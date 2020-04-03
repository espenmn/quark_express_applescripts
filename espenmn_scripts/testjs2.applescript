/*
File: Shrink or Grow Box at Centre
Description: The following script runs on a selected box and performs one out of two operations: Shrink / Grow
*/

(function () {
	//************* Default Values - Changes made here are safe
	const defaultOperation = "Shrink"; //Valid Values: "Shrink", "Grow"
	const defaultSizeChange = 72; //Only in Points, 72pt = 1 inch

	//************* Do NOT make changes beyond this point if you don't know JavaScript
	const dependencies = ["qx_constants", "qx_validations", "qx_inputs", "qx_measurements", "qx_get_boxes"]; //File Names of Dependencies to Load From QuarkXPress App (skip .js extension)
	let startTime, endTime;

	//Import Dependency Scripts
	importDependencies(dependencies);

	if (qxValidations.isLayoutOpen()) {
		//get the selected box
		let box = qxGetBoxes.getSelectedBox(false);
		if (box == null) {
			showResult("Please select a single box to run the script. Tables, Grouped Items, and Composition Zones are not supported.");
		}
		else {
			//get the current horizontal measurement units of the layout
			let currHorzUnits = qxMeasurements.getUnitsFromString(box.style.qxLeft);

			//get the operation to be performed
			let operation = getValidOperation();
			if (operation != null) {//user cancelled
				//input transformation amount
				let transformAmt = getTransAmountInPts(operation, currHorzUnits, box);
				if (transformAmt != null) {
					console.log("Entered " + operation + " amount: " + transformAmt + "pt");
					//apply the changes to box
					box.style.qxLeft = "23pt";
				}
			}
		}
	}

	//*****************====================================Functions used in the JavaScript===============================****************//

	//get valid operation input
	function getValidOperation() {
		let strPrompt = "Enter the resize operation:";
		let strDefaultValue = defaultOperation;
		let validValues = ["Shrink", "Grow"];
		let boolShowListInPrompt = true;
		let boolIsCaseSensitive = false;
		return qxInputs.getValidInputFromList(validValues, strPrompt, strDefaultValue, boolShowListInPrompt, boolIsCaseSensitive);
	}


	//get valid shrink/grow amount
	function getTransAmountInPts(operation, currHorzUnits, box) {
		let amount = null;
		let inputStr = "Please enter " + operation + " amount: ";
		let boxWidth = qxMeasurements.getBoxWidthInPts(box);
		let boxHeight = qxMeasurements.getBoxHeightInPts(box);
		operation = operation.toLowerCase();
		if (operation == "shrink") {
			let maxVal = Math.min((boxWidth - 0.2), (boxHeight - 0.2));
			if (maxVal > 0) {
				let input = qxInputs.getValidNumericInput(inputStr, defaultSizeChange, 0, maxVal, false, currHorzUnits);
				if (input != null) {
					console.log("Entered Value: " + input);
					input = qxMeasurements.convertAnyUnitToPoints(input);
					amount = -input;
				}
			}
			else {
				let alertStr = "The selected item cannot be shrunk!";
				if (box.style.qxBackgroundColor == "") {
					alertStr += "\nerror: Lines cannot be shrunk!";
				}
				showResult(alertStr);
			}
		}
		else {
			let layout = app.activeLayout();
			let pasteboardHt = qxMeasurements.convertAnyUnitToPoints(qxMeasurements.getPasteboardDims(layout).height);
			if (qxConstants.debugMode) console.log("pasteboard Height: " + pasteboardHt);
			let pasteboardWt = qxMeasurements.convertAnyUnitToPoints(qxMeasurements.getPasteboardDims(layout).width);
			if (qxConstants.debugMode) console.log("pasteboard Width: " + pasteboardWt);
			let boxTop = qxMeasurements.convertAnyUnitToPoints(box.style.qxTop);
			let boxBottom = qxMeasurements.convertAnyUnitToPoints(box.style.qxBottom);
			let boxLeft = qxMeasurements.convertAnyUnitToPoints(box.style.qxLeft);
			let boxRight = qxMeasurements.convertAnyUnitToPoints(box.style.qxRight);
			let maxBoxDim = qxMeasurements.convertAnyUnitToPoints("242in");
			let maxVal = Math.min((2 * boxTop) + 72, (2 * (boxLeft + (pasteboardWt / 3))) - 1, (2 * (pasteboardHt - 36 - boxBottom)), (2 * ((pasteboardWt * (2 / 3)) - boxRight)), (maxBoxDim - boxWidth), (maxBoxDim - boxHeight));
			if (qxConstants.debugMode) console.log("Maximum grow amount possible: " + maxVal);
			let input = qxInputs.getValidNumericInput(inputStr, "72", "0", maxVal, false, currHorzUnits);
			if (input != null) {
				input = qxMeasurements.convertAnyUnitToPoints(input);
				amount = input;
			}
		}
		return amount;
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
		console.log(msgString);
		if (!qxConstants.testMode) alert(msgString); //Don't show alerts in TestMode
	}
})();
