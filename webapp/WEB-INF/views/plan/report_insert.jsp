<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<c:import url="/WEB-INF/views/common/common.jsp"></c:import>
<script type="text/javascript">
//현재 날짜 변수
var today = moment().format("YYYY-MM-DD");
//상담 일지 갯수 변수
var adviceCount;
//datepicker 클릭 확인 변수
var dayClickCheck=false;
//제출 날짜 담는 변수
var submitdate;
//선택된 상담카드
var clickedAdviceId;

function onlyNumber(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)|| keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
		return;
	else
		return false;
}
function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function addThousandSeparatorCommas(num) {
	if (typeof num == "undefined" || num == null || num == "") {
		return "";
	}
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function removeComma(n) { // 콤마제거
	if (typeof n == "undefined" || n == null || n == "") {
		return "";
	}
	var txtNumber = '' + n;
	return txtNumber.replace(/(,)/g, "");
}

// form의 submit 수행시 validate 하는 함수
function validateForm(){
	if(dayClickCheck == false){
		alert("제출일를 선택해주세요");
	}
}

$(document).ready(function() {
	  $("#dayreporttable-files").fileinput({showCaption: false});	
	  
	  $("#dayreport-date").attr("value", today);

	  $("#advicereporttable-date").attr("value", today);	
	 $.post("select",
	    {
 			Date:today
	    },
	    function(response, status){
	        console.log(response.data);
	    });

    	 $("#dayreport-date").attr("value", today);
		
    	 adviceCount=1;				
		$( "#submitDay-datepicker" ).val(today);
		$( "#submitDay-datepicker" ).datepicker({
			dateFormat: 'yy-mm-dd', 
			minDate: 0,
		    //comment the beforeShow handler if you want to see the ugly overlay
		    beforeShow: function() {
		        setTimeout(function(){
		            $('.ui-datepicker').css('z-index', 99);
		        }, 0);
		    },
			onSelect: function(dateText,inst){
				submitdate=dateText;
				$("#dayreport-date").val(dateText);
				 $.post("select",
				    {
			 			Date:dateText
				    },
				    function(response, status){
				        console.log(response.data);
				        $("#dayreport-date").attr("value", dateText);
				        $("#advicereporttable-date").attr("value", dateText);				        
				    });
			}
		});
		
		$(function() { $('.date-textarea').froalaEditor(
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
		});

		
	
		//고객코드,고객명,주소 input태그 focus 될때  modal show
		$(document).on("focus",'#advicereporttable-customer, #advicereporttable-code, #advicereporttable-address',function() {
				//init modal_table
				$('#modal_table > tbody').empty();

				//내가 클릭한 상담카드
				clickedAdviceId = $(this).parents(".advice_content").attr("id");
				$.ajax({
						url : '/sfa/customer/select',
						type : 'GET',
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(doc) {
							//console.log(doc.data);

							for (index = 0; index < doc.data.length; index++) {
								$('#modal_table > tbody').append(
								"<tr><td class='tg-yw4l customer-info'>"
										+ doc.data[index].code
										+ "</td>"
										+ "<td class='tg-yw4l customer-info'>"
										+ doc.data[index].name
										+ "</td>"
										+ "<td class='tg-yw4l customer-info'>"
										+ doc.data[index].address
										+ "</td>"
										+ "<td id='customer-button' class='tg-yw4l'>"
										+ "<button id='advicereport-selectbutton' class='btn btn-info' data-dismiss='modal'>"
										+ "<strong>선택</strong></button>"
										+ "</td>"
										+ "</tr>");
							}
						},
						error : function(xhr,status, error) {
							console.log(xhr);
							console.log(status+ " 와 "+ error);
						}
					});
		});
		
		$("#dayreport-savebutton").click(function(){
			var dayreportForm = document.getElementById("dayreport-form");
			dayreportForm.action = "insert"; // action에 해당하는 jsp 경로를 넣어주세요.
			dayreportForm.submit(); 
		});
		
	
		$(document).on("click",".cancle-btn",function(){			 
			$('#modal_table > tbody').empty();
		});	
		
		$(document).on("click","#advicereport-selectbutton",function(){			 
			var customerInfo= [];
			console.log("픽미");
			console.log($(this).index()); 
		
 			$(this).parent().prevAll(".customer-info").each(function(index){				
 				console.log(this.innerHTML);
 				customerInfo.push(this.innerHTML);
			}); 			
 			console.log("선택된 상담카드ID: " + clickedAdviceId);

 			$("#"+clickedAdviceId).find("#advicereporttable-code").val(customerInfo[2]);
 			$("#"+clickedAdviceId).find("#advicereporttable-customer").val(customerInfo[1]);
 			$("#"+clickedAdviceId).find("#advicereporttable-address").val(customerInfo[0]);

		});
	
		$(document).on("click",".advicereporttable-savebutton",function(){			
			var advice = [];  
			$("#advice_content1").find('input').each(function(index){
				var content={};
				var key = $("#advice_content1").find('input').eq(index).attr('name'); 
				var value = $("#advice_content1").find('input').eq(index).val();
				content[key] = value;
				advice.push(content);	
			});
			console.log(advice);	
		
			
			$.post("${pageContext.servletContext.contextPath}/advice/insert",
			{
				code:advice[0].code,
				manager_name:advice[2].manager_name,
				date:advice[4].date,
				title:advice[5].title,
				content:$("#advice-textarea").froalaEditor('html.get')
			},
			function(response,status){
				
				if(response.result == "success"){
					adviceCount += 1;
					var div = document.createElement('div');
					div.setAttribute("id","advice_content"+adviceCount);
					div.setAttribute("class","advice_content");

					div.innerHTML = document.getElementById('advice_content1').innerHTML;
					document.getElementById('advice_contianer').appendChild(div);					
				}
			});
		     
			$("#advice_content1").children('#advice_form').each(function() {  
            	this.reset();  
         	});  

			//var index = $(".advicereporttable-savebutton").index(this);
			//console.log(index);
			//var form = $('#advice_content'+index);
			//form.submit();
			
		});
		
	});
</script>
</head>
<body>
	<nav class="navbar navbar-default">
		<c:import url="/WEB-INF/views/include/header.jsp">
			<c:param name="menu" value="main" />
		</c:import>
	</nav>
	<div id="wrapper">
		<div id="sidebar-wrapper">
			<c:import url="/WEB-INF/views/include/navigator.jsp">
				<c:param name="menu" value="main" />
			</c:import>
		</div>
	</div>
	<main id="page-content-wrapper" role="main">
	<article>
		<div>
			<div>
				<div class="page-header">
					<h3 class="dayreport">
						<strong>일일 보고서</strong>
					</h3>
				</div>
				<div id="reportmain_content">
				<form name="dayreport" id="dayreport-form"  onsubmit="return validateForm()" method="post">
					<table id="dayreporttable">
						<tr>
							<td colspan="3" id="rpt-content1">
								<div class="form-group">
									<div style="display: inline-block;">
										<label for="show-day-title"
											style="width: 100px; text-align: center;">예상
											목표액&nbsp;</label> 
											<input id="dayreporttable-goal-sale"
											class="form-control dayreportform-input" type="text" name="goal_sale"
											placeholder="ajax통신" >
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 110px; text-align: center;">매
											출 액 &nbsp;</label> 
											<input id="dayreporttable-report-sale"
											class="form-control dayreportform-input" type="Number" name="report_sale"
											placeholder="일일 매출액" 
											onkeydown='return onlyNumber(event)'
											onkeyup='removeChar(event)'
											min="0" required >
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 110px; text-align: center;">달
											성 률 &nbsp;</label> <input id="dayreporttable-achive-rank"
											class="form-control dayreportform-input" type="text" name=""
											placeholder="일일 달성률" 
											required readonly>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3" id="rpt-content2">
								<div class="form-group">
									<div style="display: inline-block;">
										<label for="show-day-title"
											style="width: 100px; text-align: center;">출발 계기판
											&nbsp;</label> 
											<input id="dayreporttable-startGauge" class="form-control dayreportform-input" type="text" name="start_gauge"
											placeholder="출발 계기판" 
											required >
											<a href="#" style="text-decoration: none" data-toggle="modal" data-target="#myModal"><i
											class="fa fa-camera" aria-hidden="true"></i></a>
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 100px; text-align: center;">도착
											계기판 </label> <input id="dayreporttable-endGauge"
											class="form-control dayreportform-input" type="text" name="end_gauge"
											placeholder="도착 계기판" 
											required ><a href="#AdviceModal"
											style="text-decoration: none" data-toggle="modal" data-target="#myModal"><i class="fa fa-camera"></i></a>
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 100px; text-align: center;">주행거리
											&nbsp;</label> <input id="dayreporttable-mile"
											class="form-control dayreportform-input" type="text" name="mile"
											placeholder="주행거리" 
											required >
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3" id="rpt-content3">
								<div class="form-group">
									<div style="display: inline-block;">
										<label for="show-day-title"
											style="width: 100px; text-align: center">제목&nbsp;</label> 
											<input id="dayreporttable-title"
											class="form-control dayreportform-input" type="text" name="title"
											placeholder="제목을 입력해 주세요"
											style="width: 430px; margin-right: 6px;" required>
									</div>
									 <label for="day"
										style="width: 115px; text-align: center">제출일&nbsp;</label> <input
										id="submitDay-datepicker" class="form-control"
										type="text"  placeholder="작성날짜"
										 required>
										<input id="dayreport-date" type="hidden" name="date" class="dayreportform-input">
								</div>
							</td>
						</tr>
					</table>
					<div class=" panel panel-default form-group"
						style="width: 100%; text-align: center">
						<div class="panel-heading">
							<strong>업무 보고 내용</strong>
						</div>
						<textarea name="content" class="date-textarea"></textarea>	
					</div>
					<div class="form-group">
						<input id="dayreporttable-files" class="form-control" multiple type="file">
					</div>
					<div class="panel panel-info" style="clear: both;">
						<div class="panel-heading">
							<strong>팀장 의견</strong>
						</div>
						<div class="panel-body">일 이따구로 할꺼야?</div>
					</div>
					</form>
					<div>
						<div class="btn-group btn-group-justified" role="group"
							style="width: 240px; float: right;">
							<div id="write-btn" class="btn-group" role="group">
								<button id="dayreport-savebutton" class="btn btn-primary"
									type="submit">
									<strong>저장하기</strong>
								</button>
							</div>
						</div>
					</div>				
					<div class="modal fade" id="myModal" role="dialog" style="z-index:1000000">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">계기판 사진</h4>
								</div>
								<div class="modal-body">
									존나 달리셨네요?
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<div id="advice_contianer"
						style="padding: 5px;">
						<div class="page-header">
							<h4 style="width: 70%; display: inline-block;">
								<Strong>상담일지</Strong>
							</h4>
						</div>
						<div id="advice_content1" class="advice_content">
							<form id="advice_form">
								<div class="panel panel-info"
									style="clear: both; margin-top : 10px;">
									<div class="panel-heading" style="color: #fff; ">
										<strong>상담카드</strong>
										<div style="float: right;">
										<i class="fa fa-floppy-o fa-lg" aria-hidden="true"></i>
										&nbsp;
										 <i class="fa fa-trash fa-lg" aria-hidden="true"></i>
										</div>
									</div>
									<div class="panel-body">
										<table id="advicereporttable"
											style="background-color: #fff; width: 100%; border-radius: 5px;">
											<tr style="margin-top: 5px;">
												<td colspan="3" id="adv-content1">
													<div class="form-group" style="margin-top: 15px;">
														<div style="display: inline-block;">
															<label for="show-day-title"
																style="width: 100px; text-align: center;">고객 코드
																&nbsp;</label> <input id="advicereporttable-code"
																class="form-control advicereporttable-input" type="text"
																name="code" placeholder="고객 코드"
																required
																data-toggle="modal" data-target="#AdviceModal" autocomplete="off">
														</div>
														<div style="display: inline-block;">
															<label for="day"
																style="width: 100px; text-align: center;">고객명</label> <input
																id="advicereporttable-customer"
																class="form-control advicereporttable-input" type="text"
																name="customer" placeholder="고객명"
																required
																data-toggle="modal" data-target="#AdviceModal" autocomplete="off">
														</div>
														<div style="display: inline-block;">
															<label for="day"
																style="width: 100px; text-align: center;">담당자
																&nbsp;</label> <input id="advicereporttable-manager_name"
																class="form-control advicereporttable-input" type="text"
																name="manager_name" placeholder="담당자"
																required
																>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3" id="adv-content2">
													<div class="form-group">
														<div style="display: inline-block;">
															<label for="show-day-title"
																style="width: 100px; text-align: center">주소&nbsp;</label>
															<input id="advicereporttable-address"
																class="form-control advicereporttable-input" type="text"
																name="address" placeholder="주소 자동입력 "
																style="width: 415px; margin-right: 6px;" required
																data-toggle="modal" data-target="#AdviceModal" autocomplete="off">
														</div>
														<div style="display: inline-block; margin-top: 20px;">
															<label for="day" style="width: 100px; text-align: center">제출일&nbsp;</label>
															<input id="advicereporttable-date"
																class="form-control advicereporttable-input" type="text"
																name="date" placeholder="작성날짜"
																style="width: 220px; margin-right: 6px;" required
																readonly>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3" id="adv-content3">
													<div class="form-group">
														<div style="display: inline-block;">
															<label for="show-day-title"
																style="width: 100px; text-align: center">제목&nbsp;</label>
															<input id="advicereporttable-title"
																class="form-control advicereporttable-input" type="text"
																name="title" placeholder="제목을 입력해 주세요"
																required autocomplete="off">
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3" id="adv-content4">
													<div class="panel panel-default form-group"
														style="width: 95%; text-align: center; margin: 10px;">
														<textarea id="advice-textarea" class="date-textarea"></textarea>	
													</div>
												</td>
											</tr>
										</table>

									</div>
								</div>
								<div class="btn-group btn-group-justified" role="group"
									style="width: 150px; float: right; margin: 10px;">
									<div id="write-btn" class="btn-group" role="group">
										<button class="btn btn-info advicereporttable-savebutton" type="button">
											<strong>저장하기</strong>
										</button>
									</div>
									<!-- <div id="delete-btn" class="btn-group" role="group">
										<button class="btn btn-danger advicereporttable-deletebutton" type="submit">
											<strong>삭제하기</strong>
										</button>
									</div> -->
								</div>
								<div style=" clear:both; border-bottom: 1px solid #eee;"></div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</article>


	<div class="modal fade" id="AdviceModal" role="dialog"
		style="z-index: 2000;"  data-backdrop="static">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content" style="width: 800px;">
				<div class="modal-header">
					<button type="button" class="close cancle-btn" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<strong>대리점 검색</strong>
					</h4>
				</div>
				<div id="modal-body" class="modal-body">
					<label style="margin-right: 10px; margin-left: 10px;">고 객 명
					</label><input id="advicereporttable-name"
						class="form-control advicereportform-input" type="text" name=""
						placeholder="주소 자동입력 " style="width: 500px; margin-right: 6px;"
						required>
					<button id="advicereport-updatebutton" class="btn btn-info"
						type="submit">
						<strong>검 색</strong>
					</button>
					<table id="modal_table" class="tg">
					<thead>
						<tr>
							<th class="tg-031e">고객 코드</th>
							<th class="tg-031e">고객명</th>
							<th class="tg-031e">주소</th>
							<th class="tg-031e">선택<br></th>
						</tr>
					</thead> 
					<tbody></tbody>	
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger cancle-btn" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	</main>
	
</body>
</html>