function DecimalNumber(e) {
	// Allow: backspace, delete, tab, escape, enter
	if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
		// Allow: Ctrl+A
		(e.keyCode == 65 && e.ctrlKey === true) ||
		// Allow: home, end, left, right
		(e.keyCode >= 35 && e.keyCode <= 39)) {
		// let it happen, don't do anything
		return true;
	}

	// Allow: '.' (just once)
	if (e.keyCode == 190 || e.keyCode == 110) {
		if ($(this).val().indexOf('.') == -1) {
			return true;
		}
	}

	// Allow copy, cut and don't allow paste
	var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
	if (ctrlDown && e.altKey) return true;
	else if (ctrlDown && e.keyCode == 67) return true; // c
	else if (ctrlDown && e.keyCode == 86) return false; // v
	else if (ctrlDown && e.keyCode == 88) return true; // x

	// Ensure that it is a number and stop the keypress
	if ((e.shiftKey || e.altKey || e.ctrlKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
		e.preventDefault();
	}
}

function IntegerNumber(e) {
	// Allow: backspace, delete, tab, escape, enter
	if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
		// Allow: Ctrl+A
		(e.keyCode == 65 && e.ctrlKey === true) ||
		// Allow: home, end, left, right
		(e.keyCode >= 35 && e.keyCode <= 39)) {
		// let it happen, don't do anything
		return true;
	}

	// Allow copy, cut and don't allow paste
	var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
	if (ctrlDown && e.altKey) return true;
	else if (ctrlDown && e.keyCode == 67) return true; // c
	else if (ctrlDown && e.keyCode == 86) return false; // v
	else if (ctrlDown && e.keyCode == 88) return true; // x

	// Ensure that it is a number and stop the keypress
	if ((e.shiftKey || e.altKey || e.ctrlKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
		e.preventDefault();
	}
}

/* For tickets, bills and referral guide codes */
function BillNumber(e) {    
    // Allow: backspace, delete, tab, escape, enter, dash(2)
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 109, 189]) !== -1 ||
        // Allow: Ctrl+A
		(e.keyCode == 65 && e.ctrlKey === true) ||
        // Allow: home, end, left, right
		(e.keyCode >= 35 && e.keyCode <= 39)) {
        // let it happen, don't do anything
        return true;
    }

    // Allow copy, cut and don't allow paste
    var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
    if (ctrlDown && e.altKey) return true;
    else if (ctrlDown && e.keyCode == 67) return true; // c
    else if (ctrlDown && e.keyCode == 86) return false; // v
    else if (ctrlDown && e.keyCode == 88) return true; // x

    // Ensure that it is a number and stop the keypress
    if ((e.shiftKey || e.altKey || e.ctrlKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}

function Text(e) {
    // Allow: backspace, delete, tab, escape, enter, dash(2)
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 109, 189]) !== -1 ||
        // Allow: Ctrl+A
		(e.keyCode == 65 && e.ctrlKey === true) ||
        // Allow: home, end, left, right
		(e.keyCode >= 35 && e.keyCode <= 39)) {
        // let it happen, don't do anything
        return true;
    }

    // Allow copy, cut and don't allow paste
    var ctrlDown = e.ctrlKey || e.metaKey; // Mac support
    if (ctrlDown && e.altKey) return true;
    else if (ctrlDown && e.keyCode == 67) return true; // c
    else if (ctrlDown && e.keyCode == 86) return true; // v
    else if (ctrlDown && e.keyCode == 88) return true; // x

    var key = String.fromCharCode(e.which);
    var RegExpression = /^[a-zA-ZñáéíóúÑÁÉÍÓÚäëïöüÄËÏÖÜ\s]*$/;

    return RegExpression.test(key);
}
