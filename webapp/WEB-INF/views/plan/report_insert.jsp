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




function addNewAddviceInfo(advice_no)
{
	$.post("/sfa/advice/select",
	{
	   advice_no:advice_no
	}
	,function(response,status){
		console.log("새로 추가된 상담일지 정보");
		console.log(response);	
	});
}



function setContentAndProtect(listLength){
	//alert("상담일자 갯수: "+listLength);
	for(i=1; i < listLength+1; i++){
		var content = $("#advice-textarea"+i).data("value");
		$("#advice-textarea"+i).froalaEditor('html.set',content);	
		$("#advice-textarea"+i).froalaEditor('edit.off');
		$("#advice_content"+i).attr("diabled",true);
	}
}

$(document).ready(function() {
	var listLength = '<c:out value="${fn:length(list)}"/>';
	var list = '<c:out value="${list}"/>';
	console.log(list);

	$("#advice-delete").on("click",function(){
		var adviceNo= $(this).next("input").val();
		
		$.post("delete",{
			advice_no : adviceNo
		},function(response,status){
			alert("삭제 성공!");
		});
	});
	
	$("#dayreporttable-report-sale").focusout(function(){
		setAchiveRank();
	});
	
	$("#dayreporttable-startGauge, #dayreporttable-endGauge").focusout(function(){
		setmile();
	});
	  
	  $("#dayreport-date").attr("value", today);

	  $("#advicereporttable-date").attr("value", today);	
      $("#dayreport-date").attr("value", today);
		
    	 adviceCount=1;				
		$( "#submitDay-datepicker" ).val(today);
		$( "#submitDay-datepicker" ).datepicker({
			dateFormat: 'yy-mm-dd', 
			minDate: 0,
		    beforeShow: function() {
		        setTimeout(function(){
		            $('.ui-datepicker').css('z-index', 99);
		        }, 0);
		    },
			onSelect: function(dateText,inst){
				submitdate=dateText;
				$("#dayreport-date").val(dateText);
				 $.post("check",
				    {
			 			date:dateText
				    },
				    function(response, status){
				    	//console.log(response.result);  //계획이 있으면 success 없으면 fail
				        
				    	if(response.result =="fail"){
				    		alert("주간계획 미작성!");
				    	}
				    	
				    	$("#dayreport-date").attr("value", dateText);
				        $("#advicereporttable-date").attr("value", dateText);				        
				    });
				 
				 $.get("/sfa/advice/select?date="+dateText,
						    function(response, status){
						    	console.log(status);
						    	console.log(response);
						    	console.log(response.data.length);  //계획이 있으면 success 없으면 fail
						        
						    	if(response.data.length == 0){
						    		console.log("작성된 상담일지가 존재하지 않습니다.");
						    	}
						    	else{
						    		console.log(response.data);
						    	}
						    	
						    	console.log("현재 날짜의 상담일지 load");
								console.log(response);	
						    /* 	$("#dayreport-date").attr("value", dateText);
						        $("#advicereporttable-date").attr("value", dateText); */				        
						    });
			}
		});
		
		makefloaraEditor();

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
							console.log(doc.data);
							for (index = 0; index < doc.data.length; index++) {
								$('#modal_table > tbody').append(
								"<tr><td class='tg-yw4l customer-info'>"
										+ doc.data[index].customer_code
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
	/* 	
		$("#dayreport-savebutton").click(function(){
			var dayreportForm = document.getElementById("dayreport-form");
			dayreportForm.action = "insert"; // action에 해당하는 jsp 경로를 넣어주세요.
			dayreportForm.submit(); 
		}); */
		
	
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
	
		$(document).on("click",".advice-submit",function(){			
			var advice = [];  
			$("#advice_content").find('input').each(function(index){
				var content={};
				var key = $("#advice_content").find('input').eq(index).attr('name'); 
				var value = $("#advice_content").find('input').eq(index).val();
				content[key] = value;
				advice.push(content);	
			});
			console.log(advice);	
		
			
			$.post("${pageContext.servletContext.contextPath}/advice/insert",
			{
				customer_code:advice[0].code,
				manager_name:advice[2].manager_name,
				date:advice[4].date,
				title:advice[5].title,
				content:$("#advice-textarea").froalaEditor('html.get')
			},function(response,status){
					console.log(response);
					var result =response.result;
					var advice_no =response.advice_no;
					addAdvice(result);
					addNewAddviceInfo(advice_no);
				});
		     
			/* $("#advice_content").children('#advice_form').each(function() {  
            	this.reset();  
         	}); */  

			//var index = $(".advicereporttable-savebutton").index(this);
			//console.log(index);
			//var form = $('#advice_content'+index);
			//form.submit();
			
		});
		setContentAndProtect(listLength);
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
	<div class="panel-info">
	<div class="content-header panel-heading">
		<h3 >
			<strong>일일 보고서</strong>
			<span style="float: right;">						
			<a href="#" onclick="reportSubmit()">
			 <i class="fa fa-floppy-o fa-lg" aria-hidden="true"></i>
			</a>
			&nbsp;	
			</span>
		</h3>	
	</div>
	</div>
	<article>
		<div>
			<div>			
				<div id="reportmain_content">
				<form name="dayreport" id="dayreport-form" method="post">
					<table id="dayreporttable">
						<tr id="rpt-content1">
							<td>
									<div style="display: inline-block;">
										<label class="reporttable-label" for="show-day-title">예상 목표액&nbsp;</label> 
											<input id="dayreporttable-goal-sale"
											class="form-control dayreportform-input" type="Number" name="goal_sale"
											placeholder="ajax통신" value="${goal_sale}" min="0" readonly>
									</div>
							</td>
							<td>
							<div style="display: inline-block;">
										<label class="reporttable-label" for="day" >매 출 액 &nbsp;</label> 
											<input id="dayreporttable-report-sale"
											class="form-control dayreportform-input" type="Number" name="report_sale"
											placeholder="일일 매출액" 
											onkeydown='return onlyNumber(event)'
											onkeyup='removeChar(event)'
											min="0" required >
									</div>
							</td>
							<td>
							<div style="display: inline-block;">
										<label class="reporttable-label" for="day">달 성 률(%) &nbsp;</label> <input id="dayreporttable-achive-rank"
											class="form-control dayreportform-input" type="text" 
											placeholder="일일 달성률" 
											required readonly value="${dateReportVo.achive_rank}%">
											<input type="hidden" id="achive-rank" name="achive_rank">
									</div>
							</td>
						</tr>
						<tr id="rpt-content2">
							<td>
									<div style="display: inline-block;">
										<label class="reporttable-label" for="show-day-title">출발 계기판
											&nbsp;</label> 
											<input id="dayreporttable-startGauge" class="form-control dayreportform-input" type="Number" name="start_gauge"
											placeholder="출발 계기판" 
											onkeydown='return onlyNumber(event)'
											onkeyup='removeChar(event)'
											required value="${dateReportVo.start_gauge}">
									</div>
							</td>
							<td>
							<div style="display: inline-block;">
										<label class="reporttable-label" for="day">도착 계기판 </label> <input id="dayreporttable-endGauge"
											class="form-control dayreportform-input" type="Number" name="end_gauge"
											placeholder="도착 계기판" 
											onkeydown='return onlyNumber(event)'
											onkeyup='removeChar(event)'
											required value="${dateReportVo.end_gauge}">
									</div>
							</td>
							<td>
							<div style="display: inline-block;">
										<label class="reporttable-label" for="day">주행거리(km)
											&nbsp;</label> <input id="dayreporttable-mile"
											class="form-control dayreportform-input" type="text" name="mile"
											placeholder="주행거리" 
											required readonly value="${dateReportVo.end_gauge}">
											<input type="hidden" id="mile" name="mile" value="${dateReportVo.end_gauge}">
									</div>	
							</td>
						</tr>
						<tr id="rpt-content3">	
							<td colspan="2" >
									<div style="display: inline-block;">
										<label class="reporttable-label" for="show-day-title">제목&nbsp;</label> 
											<input id="dayreporttable-title"
											class="form-control dayreportform-input" type="text" name="title"
											placeholder="제목을 입력해 주세요"
											style="width: 430px; margin-right: 6px;" required>
									</div>
							</td>
							<td>
							 <label class="reporttable-label" for="day">보고날짜&nbsp;</label> <input
										id="submitDay-datepicker" class="form-control"
										type="text"  placeholder="보고날짜"
										 required>
										<input id="dayreport-date" type="hidden" name="date" class="dayreportform-input">
							</td>
						</tr>
					</table>
					<div class=" panel panel-default form-group report-content">
						<div class="panel-heading">
							<strong>업무 보고 내용</strong>
						</div>
						<textarea id="report-content" name="content" class="date-textarea"></textarea>	
					</div>
					 </form>
					
					<div id="advice_contianer">
				
						<div id="advice_content"class="advice_content">
							<form id="advice_form">
								<div class="panel panel-success">
									<div class="panel-heading" style="color: #fff; ">
										<strong>상담카드</strong>
										<div style="float: right;">
										<a class="advice-submit" href="#" >
										<i class="fa fa-floppy-o fa-2x" aria-hidden="true"></i>
										</a>
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
																name="manager_name" placeholder="담당자" pattern="^[가-힣a-zA-Z]+$;"
																required>
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
																 required
																data-toggle="modal" data-target="#AdviceModal" autocomplete="off">
														</div>
														<div style="display: inline-block; margin-top: 20px;">
															<label for="day" style="width: 100px; text-align: center">보고날짜&nbsp;</label>
															<input id="advicereporttable-date"
																class="form-control advicereporttable-input" type="text"
																name="date" placeholder="보고날짜"
																 required
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
								<div style="clear:both; border-bottom: 1px solid #eee;"></div>
							</form>
						</div>
						<c:forEach items="${list}" var="adviceVo" varStatus="status">
						<div id="advice_content${status.count}"class="advice_content">
							<form id="advice_form">
								<div class="panel panel-info"
									style="clear: both; margin-top : 10px;">
									<div class="panel-heading" style="color: #fff; ">
										<strong>상담카드</strong>
										<div style="float: right;">
										<a id="advice-delete" href="#" > 
											<i class="fa fa-trash fa-2x" aria-hidden="true"></i>
										</a>
										<input id="advice_no" type="hidden" value="${adviceVo.advice_no}">
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
																required value="${adviceVo.customer_code}"
																data-toggle="modal" data-target="#AdviceModal" autocomplete="off">
														</div>
														<div style="display: inline-block;">
															<label for="day"
																style="width: 100px; text-align: center;">고객명</label> <input
																id="advicereporttable-customer"
																class="form-control advicereporttable-input" type="text"
																name="customer" placeholder="고객명"
																required value="${adviceVo.name}"
																data-toggle="modal" data-target="#AdviceModal" autocomplete="off">
														</div>
														<div style="display: inline-block;">
															<label for="day"
																style="width: 100px; text-align: center;">담당자
																&nbsp;</label> <input id="advicereporttable-manager_name"
																class="form-control advicereporttable-input" type="text"
																name="manager_name" placeholder="담당자" pattern="^[가-힣a-zA-Z]+$;"
																required value="${adviceVo.manager_name}"
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
																style="width: 415px; margin-right: 6px;" required value="${adviceVo.address}"
																data-toggle="modal" data-target="#AdviceModal" autocomplete="off">
														</div>
														<div style="display: inline-block; margin-top: 20px;">
															<label for="day" style="width: 100px; text-align: center">보고날짜&nbsp;</label>
															<input id="advicereporttable-date"
																class="form-control advicereporttable-input" type="text"
																name="date" placeholder="보고날짜"
																style="width: 220px; margin-right: 6px;" required value="${adviceVo.date}"
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
																required value="${adviceVo.title}" autocomplete="off">
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3" id="adv-content4">
													<div class="panel panel-default form-group"
														style="width: 95%; text-align: center; margin: 10px;">
														<textarea id="advice-textarea${status.count}" class="date-textarea" data-value="${adviceVo.content}" ></textarea>	
													</div>
												</td>
											</tr>
										</table>

									</div>
								</div>
								<div style="clear:both; border-bottom: 1px solid #eee;"></div>
							</form>
						</div>
						</c:forEach>												
					
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