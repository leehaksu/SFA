

function setAchiveRank(){
	var goalSale = $("#dayreporttable-goal-sale").val();
	var reportSale = $("#dayreporttable-report-sale").val();
	var achiveRank =reportSale/goalSale * 100;
	
	if(confInfinity(achiveRank))
	{
		$("#dayreporttable-achive-rank").val(100+"%");
		$("#achive-rank").val(100);	
	}else if(confisNaN(achiveRank)){
		$("#dayreporttable-achive-rank").val("0%");
		$("#achive-rank").val("");
	}else	
	{
		achiveRank=Math.floor(achiveRank);	
		$("#dayreporttable-achive-rank").val(achiveRank+"%");
		$("#achive-rank").val(achiveRank);		
	}
}
function setmile(){
	var startGauge = $("#dayreporttable-startGauge").val();
	var endGauge = $("#dayreporttable-endGauge").val();
	console.log(typeof startGauge);
	console.log(typeof endGauge);
	console.log(startGauge.length);
	console.log(endGauge.length);
	
	
	if((startGauge >=0 && startGauge.length != 0) && (endGauge.length != 0 && endGauge >=0 )){
		if(endGauge-startGauge < 0){
			$("#dayreporttable-mile").val("잘못된 입력값");
		}else{
			$("#dayreporttable-mile").val(endGauge-startGauge); 	
			$("#mile").val(endGauge-startGauge);	
		}	
	}else{
		$("#dayreporttable-mile").val(""); 
		$("#mile").val(""); 		
	}
	
}


function validateForm() {
	for(i =0; i < document.forms["dayreport-form"].length; i++){
		var input = document.forms["dayreport-form"][i];
		console.log(input);
		console.log(input.hasAttribute("required"));
		 if(input.hasAttribute("required")){
			if(input.value == ""){
				 alert("필수 입력 항목이 입력되지 않았습니다.");
				 input.focus();
				 return false;
			}
			if($("#report-content").froalaEditor('html.get').length == 0){
				alert($("#report-content").froalaEditor('html.get'));
				alert($("#report-content").froalaEditor('html.get').length);
				alert("업무 내용이 비어있습니다.");
				return false;
			}
			if($("#dayreporttable-mile").val() == "잘못된 입력값"){
				alert("계기판 정보가 잘못 입력되었습니다.");
				return false;
			}
		} 
	}
	return true;
}

function reportSubmit(){
	var dayreportForm = document.getElementById("dayreport-form");
	dayreportForm.action = "insert"; // action에 해당하는 jsp 경로를 넣어주세요.
	if(validateForm()){
		dayreportForm.submit();  	
	}
	
}

function reportUpdate(){
	var dayreportForm = document.getElementById("dayreport-form");
	dayreportForm.action="update"; // action에 해당하는 jsp 경로를 넣어주세요.
	if(validateForm()){
		dayreportForm.submit();  	
	}
}


function addAdvice(result){
	if(result == "success"){
		adviceCount += 1;
		var div = document.createElement('div');
		div.setAttribute("id","advice_content"+adviceCount);
		div.setAttribute("class","advice_content");

		div.innerHTML = document.getElementById('advice_content').innerHTML;
		document.getElementById('advice_contianer').appendChild(div);
	}
}

