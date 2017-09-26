<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SaleForceAutomation</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/assets/css/main.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/bootstrap-theme.min.css">
<link rel='stylesheet'
	href="${pageContext.servletContext.contextPath}/assets/css/fullcalendar.css" />
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/assets/css/join.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.servletContext.contextPath}/assets/css/jquery-ui.min.css">


<script
	src="${pageContext.servletContext.contextPath}/assets/js/jquery-3.2.1.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/jquery-ui.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script
	src="${pageContext.servletContext.contextPath}/assets/js/bootstrap.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/moment.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/assets/js/fullcalendar.js"></script>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/assets/js/ko.js"></script>


<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/froala_editor/css/froala_editor.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/assets/froala_editor/css/froala_style.min.css">
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/assets/froala_editor/js/froala_editor.min.js"></script>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/assets/froala_editor/js/plugins/paragraph_format.min.js"></script>

<script type="text/javascript">
//현재 날짜 변수
var today = moment().format("YYYY-MM-DD");
//상담 일지 갯수 변수
var adviceCount;
var dayClickCheck=false;
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
	
	 $.post("select",
	    {
 			Date:today
	    },
	    function(response, status){
	        console.log(response.data);
	    });

    	 $("#dayreport-date").attr("value", today);
		
    	 adviceCount=0;				
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
				$("#dayreport-date").val(dateText);
				 $.post("select",
				    {
			 			Date:dateText
				    },
				    function(response, status){
				        console.log(response.data);
				        $("#dayreport-date").attr("value", dateText);
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

		/* $("#dayreporttable-profit").focusout(function(){
			var profit = $("#dayreporttable-profit").val();	
		}); */
		
	
		
		//추가하기 버튼을 눌를 경우 이벤트 발생
		$("#add_advice").click(function() {
			adviceCount += 1;
			console.log("들어오니??");
			var div = document.createElement('div');
			div.setAttribute("id","advice_content"+adviceCount);

			div.innerHTML = document.getElementById('advice_content').innerHTML;
			document.getElementById('advice_contianer').appendChild(div);	
		});
	
		
		$('#dayreporttable-customer').focus(function() {
			$.ajax({
						url : '/sfa/customer/select',
						type : 'GET',
						dataType : 'json',
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(doc) {
							console.log(doc);
							console.log(doc.data);

							for (index = 0; index < doc.data.length; index++) {
								$('#modal_table').append(
								"<tr><td class='tg-yw4l'>"
										+ doc.data[index].code
										+ "</td>"
										+ "<td class='tg-yw4l'>"
										+ doc.data[index].name
										+ "</td>"
										+ "<td class='tg-yw4l'>"
										+ doc.data[index].address
										+ "</td>"
										+ "<td class='tg-yw4l'>"
										+ "<button id='dayreport-updatebutton' class='btn btn-info'>"
										+ "<strong>선택</strong></button>"
										+ "</td>"
										+ "</tr>");
							}

						},
						error : function(xhr,
								status, error) {
							alert(xhr + " 와 "
									+ status
									+ " 와 "
									+ error);
						}
					});
		});
		
		$("#dayreport-savebutton").click(function(){
			var dayreportForm = document.getElementById("dayreport-form");
			dayreportForm.action = "insert"; // action에 해당하는 jsp 경로를 넣어주세요.
			dayreportForm.submit(); 
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
	<article>
		<div id="join_container">
			<div class="col-md-12">
				<div class="page-header">
					<h3 class="dayreport">
						<strong>일일 보고서</strong>
					</h3>
				</div>
				<div id="page_content">
				<form name="dayreport" id="dayreport-form"  onsubmit="return validateForm()" method="post">
					<table id="dayreporttable">
						<tr>
							<td colspan="3" id="content2">
								<div class="form-group">
									<div style="display: inline-block;">
										<label for="show-day-title"
											style="width: 100px; text-align: center;">예상
											목표액&nbsp;</label> <input id="dayreporttable-goal-sale"
											class="form-control dayreportform-input" type="text" name="goal_sale"
											placeholder="ajax통신" style="width: 150px; margin-right: 6px;"
											>
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 115px; text-align: center;">매
											출 액 &nbsp;</label> <input id="dayreporttable-report-sale"
											class="form-control dayreportform-input" type="Number" name="report_sale"
											placeholder="일일 매출액" style="width: 150px; margin-right: 6px;"
											onkeydown='return onlyNumber(event)'
											onkeyup='removeChar(event)'
											min="0" required >
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 115px; text-align: center;">달
											성 률 &nbsp;</label> <input id="dayreporttable-achive-rank"
											class="form-control dayreportform-input" type="text" name=""
											placeholder="일일 달성률" style="width: 230px; margin-right: 6px;"
											required >
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3" id="content2">
								<div class="form-group">
									<div style="display: inline-block;">
										<label for="show-day-title"
											style="width: 100px; text-align: center;">출발 계기판
											&nbsp;</label> 
											<input id="dayreporttable-startGauge" class="form-control dayreportform-input" type="text" name="start_gauge"
											placeholder="출발 계기판" style="width: 150px; margin-right: 6px;"
											required >
											<a href="#" style="text-decoration: none" data-toggle="modal" data-target="#myModal"><i
											class="fa fa-camera" aria-hidden="true"></i></a>
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 100px; text-align: center;">도착
											계기판 </label> <input id="dayreporttable-endGauge"
											class="form-control dayreportform-input" type="text" name="end_gauge"
											placeholder="도착 계기판" style="width: 150px; margin-right: 6px;"
											required ><a href="#AdviceModal"
											style="text-decoration: none" data-toggle="modal" data-target="#myModal"><i class="fa fa-camera"></i></a>
									</div>
									<div style="display: inline-block;">
										<label for="day" style="width: 100px; text-align: center;">주행거리
											&nbsp;</label> <input id="dayreporttable-mile"
											class="form-control dayreportform-input" type="text" name="mile"
											placeholder="주행거리" style="width: 227px; margin-right: 6px;"
											required >
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3" id="content2">
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
										style="width: 230px; margin-right: 6px;" required>
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
							<div id="update-btn" class="btn-group" role="group">
								<button id="dayreport-updatebutton" class="btn btn-info"
									type="submit">
									<strong>수정하기</strong>
								</button>
							</div>
							<div id="delete-btn" class="btn-group" role="group">
								<button id="dayreport-deletebutton" class="btn btn-default"
									type="submit">
									<strong>삭제하기</strong>
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
							<button id="delete_advice" class="btn  btn-sm btn-danger"
								style="float: right; margin-top: 10px; margin-right: 10px; float: right;">삭제</button>
							<button id="add_advice" class="btn btn-info btn-sm"
								style="float: right; margin-top: 10px; margin-right: 10px; float: right;">추가</button>
							<button id="search_advice" class="btn  btn-sm btn-default"
								style="float: right; margin-top: 10px; margin-right: 10px; float: right;">검색</button>		
						</div>
						<div id="advice_content" class="advice_content">
							<form>
								<div class="panel panel-info"
									style="clear: both; margin-top : 10px;">
									<div class="panel-heading" style="color: #fff; ">
										<strong>상담카드</strong>
									</div>
									<div class="panel-body">
										<table id="advicereporttable"
											style="background-color: #fff; width: 100%; border-radius: 5px;">
											<tr style="margin-top: 5px;">
												<td colspan="3" id="content2">
													<div class="form-group" style="margin-top: 15px;">
														<div style="display: inline-block;">
															<label for="show-day-title"
																style="width: 100px; text-align: center;">고객 코드
																&nbsp;</label> <input id="advicereporttable-title"
																class="form-control advicereporttable-input" type="text"
																name="" placeholder="고객 코드"
																style="width: 150px; margin-right: 6px;" required
																><a href="#"
																style="text-decoration: none"></a>
														</div>
														<div style="display: inline-block;">
															<label for="day"
																style="width: 100px; text-align: center;">고객명</label> <input
																id="advicereporttable-customer"
																class="form-control advicereporttable-input" type="text"
																name="" placeholder="고객명"
																style="width: 150px; margin-right: 6px;" required
																data-toggle="modal" data-target="#AdviceModal">
														</div>
														<div style="display: inline-block;">
															<label for="day"
																style="width: 100px; text-align: center;">담당자
																&nbsp;</label> <input id="advicereporttable-manager"
																class="form-control advicereporttable-input" type="text"
																name="" placeholder="담당자"
																style="width: 220px; margin-right: 6px;" required
																>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3" id="content2">
													<div class="form-group">
														<div style="display: inline-block;">
															<label for="show-day-title"
																style="width: 100px; text-align: center">주소&nbsp;</label>
															<input id="advicereporttable-address"
																class="form-control advicereporttable-input" type="text"
																name="" placeholder="주소 자동입력 "
																style="width: 415px; margin-right: 6px;" required
																>
														</div>
														<div style="display: inline-block;">
															<label for="day" style="width: 100px; text-align: center">작성일&nbsp;</label>
															<input id="advicereporttable-regDate"
																class="form-control advicereporttable-input" type="text"
																name="" placeholder="작성날짜"
																style="width: 220px; margin-right: 6px;" required
																>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3" id="content2">
													<div class="form-group">
														<div style="display: inline-block;">
															<label for="show-day-title"
																style="width: 100px; text-align: center">제목&nbsp;</label>
															<input id="advicereporttable-title"
																class="form-control advicereporttable-input" type="text"
																name="" placeholder="제목을 입력해 주세요"
																style="width: 740px; margin-right: 6px;" required>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3" id="content2">
													<div class="panel panel-default form-group"
														style="width: 95%; text-align: center; margin: 10px;">

														<textarea class="date-textarea"></textarea>	
													</div>
												</td>
											</tr>
										</table>

									</div>
								</div>
								<div class="btn-group btn-group-justified" role="group"
									style="width: 150px; float: right; margin: 10px;">
									<div id="write-btn" class="btn-group" role="group">
										<button id="advicereporttable-savebutton" class="btn btn-info"
											type="submit">
											<strong>저장하기</strong>
										</button>
									</div>
									<div id="delete-btn" class="btn-group" role="group">
										<button id="advicereporttable-deletebutton" class="btn btn-danger"
											type="submit">
											<strong>삭제하기</strong>
										</button>
									</div>
								</div>
								<div style=" clear:both; border-bottom: 1px solid #eee;"></div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</article>

	<!-- Modal -->
	<div class="modal fade" id="AdviceModal" role="dialog"
		style="z-index: 2000;">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content" style="width: 800px;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<strong>대리점 검색</strong>
					</h4>
				</div>
				<div id="modal-body" class="modal-body">
					<label style="margin-right: 10px; margin-left: 10px;">고 객 명
					</label><input id="dayreporttable-title"
						class="form-control dayreportform-input" type="text" name=""
						placeholder="주소 자동입력 " style="width: 500px; margin-right: 6px;"
						required>
					<button id="dayreport-updatebutton" class="btn btn-info"
						type="submit">
						<strong>검 색</strong>
					</button>
					<table id="modal_table" class="tg">
						<tr>
							<th class="tg-031e">고객 코드</th>
							<th class="tg-031e">고객명</th>
							<th class="tg-031e">주소</th>
							<th class="tg-031e">선택<br></th>
						</tr>
						<tr id="tg_tr">
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>