
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
		return "0";
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
//Infinity 인지 체크
function confInfinity( val ) {
	if( val==Infinity ) return true;
	else return false;
}
//isNaN 인지 체크
function confisNaN( val ) {
	if( isNaN(val) ) return true;
	else return false;
}


function makefloaraEditor(){
	$('.date-textarea').froalaEditor(
			{
			  toolbarButtons: ['bold', 'italic','paragraphFormat'],
				paragraphFormat: 
				{
				    N: 'Normal',
				    H1: 'Heading 1',
				    H2: 'Heading 2',
					H3: 'Heading 3'
			  	}
			});
}

