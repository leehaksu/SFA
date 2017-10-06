	
	//숫자만 입력
	function onlyNumber(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)|| keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			return false;
	}
	//문자 제거
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	//1000자리마다 ,찍기
	function addThousandSeparatorCommas(num) {
		if (typeof num == "undefined" || num == null || num == "") {
			return "";
		}
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	//',' 제거
	function removeComma(n) { // 콤마제거
		if (typeof n == "undefined" || n == null || n == "") {
			return "";
		}
		var txtNumber = '' + n;
		return txtNumber.replace(/(,)/g, "");
	}
