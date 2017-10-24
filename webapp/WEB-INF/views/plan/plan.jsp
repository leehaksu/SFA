<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/views/common/common.jsp"></c:import>
	
<script>
	var date = new Date();
	var today = moment().format("YYYY-MM-DD");

	var testnumber = moment('2010-10-20').isBefore('2010-10-21');
	//moment('2017-09-05','YYYY-MM-DD').diff('2017-09-04','day');

	//달력에서 클릭 한 날짜를 담는 변수
	var ClickedDay;
	var current;// ajax를 위해 변화하는 달 정보담는 변수	

	// ajax 통신후 response dat를 담는 변수들.
	var weeklist;
	var totaltargetmoney;
	var weektargetmoney;
	var weekno;
	var thisweekdate;

	//check UserID select 박스에서 변경된 아이디를 담는 변수이다.(팀장 전용)
	var selectID ='<c:out value="${authUser.id}"/>';
	
	var authUserID = '<c:out value="${authUser.id}"/>';

	//입력 체크 변수
	var changecheck = false;

	// dayplantable에 클릭한 날짜의 목표액을 주간테이블에서 가져오기 위한 변수
	var goalmoneyindex;

	//moment('2016-06','YYYY-MM').diff('2015-01','month');     //17 시간차
	$(document).ready( function() {
		
		//도전과제 ajax
		ajaxChallenge();
		//텍스트 에디터 초기화
		initEditor();
		/* //현재위치 정보 가져오기.
			getLocation();
		 *///dayplan 위치 검색 자동완성
			positionsAutocomplete();
			
			//달력 생성 
			$('#calendar').fullCalendar(
							{
								defaultDate : today,
								lang : "ko",
								selectable : true,
								weekends : false,
								lazyFetching:true,
								eventLimit : true, // allow "more" link when too many events
								disableDragging: true,
								events : function(start, end, timezone, callback) {
									current = $('#calendar').fullCalendar('getDate').format("YYYY-MM-DD");
									//달력에 모든 주간일정 ajax'

									getWeeks(current,authUserID,callback);
								},
								dayClick : function(date, jsEvent,view) {
									//클릭한 날짜를  날짜 형식을 'YYYY-MM-DD'로 맞춰준다.
									ClickedDay = date.format('YYYY-MM-DD');	

									//console.log(dayClick);	
									//날짜 클릭 이벤트 주간 계획 데이터 ajax
									if(typeof selectID == "undefined" || selectID == null || selectID == "")
									{
										changeweekplan(ClickedDay,authUserID,selectID);
									}
									else{
										changeweekplan(ClickedDay,selectID,authUserID);	
									}
									
									getsidedayplancontent(ClickedDay,selectID);
									
								},
								eventRender : function(e, elm) {
									elm.popover({
										title : e.title,
										container : 'body',
										placement : 'top',
										trigger : 'click'
									});
									elm.on("mouseleave",function() {
												$(this).popover('hide');
											});
								}
							});
			//이벤트 함수들
			//
			setTargetmoney();
			
			//textarea focus됬을 때 
			weekplanTextareaFocus();
			
			//day-content-modal close 이벤트
			weekplanDayContentModalClose();
			
			////////////////////////////////
			//주간 계획 modal input 추가   
			//key 값이 Enter이면 자동으로 input 추가로 해야 편할듯.
			weekplanDayContentAdd();
			////////////////////////////////

			//리스트 한개씩 지우기
			weekplanDayContentRemove();
		

			//주간 계획 modal 저장 
			weekplanDayContentSave();
			/////////////////////////////////////////////////////////////////////////////
			/* 수정이 필요한 부분 ~~~~~~~~~~~~~~~~~*/
			$('#side-dayplan-open-button').click(function() {
				
				
				//현재 날짜와 클릭한 날짜 비교 
				var plandatecheck = moment(ClickedDay).isSameOrAfter(today);
				
				//선택한 날짜가 있는지 없는지 유무 확인
				if (typeof ClickedDay == "undefined" || ClickedDay == null || ClickedDay == "") {
					$("#dayplancheckmodal").modal('show');
				} else {
					getLocation();	
					 
					//날짜 클릭 이벤트 일일 계획 데이터 ajax
					setTimeout(function() {
						console.log("지도데이터 확인");
						
						console.log(map);
						changedayplan(ClickedDay,selectID,authUserID,plandatecheck,map)
						}, 600);
					
					dayplanmodalShow();	
				}
				
				//회원에 권한에 따라 input 태그의 활성화 상태 적용
				if(authUserID != selectID){
					//alert("여기 탐");
					blockdayplan();
				}
				//계획서 날짜 입력
				$("#dateplan-date").attr("value",ClickedDay);
			});
			/////////////////////////////////////////////////////////////////////////////
			//dayplanmodal close 이벤트
			dayplanModalClose();

			//weekplan 저장하기 버튼 이벤트
			weekplanSaveButtonClick();

			//weekplan reset(삭제하기) button
			weekplanResetButton();
			
			//////////////////////////////////////////////////////////////
			//달력에 dayclick 이벤트가 발생하기전 주간 테이블 작성일
			/* 수정이 필요한 부분 ~~~~~~~~~~~~~~~~~*/
			//서버 날짜를 기준으로 날짜를 잡아야 하는 게 맞다.
			$("#reg-day").text(today);

			/*dayplan script */
			//dayplan 오늘 날짜 화면 표시
			$(".dayplan-date").text("날짜 미지정");

			$('#show-day-title').val("" + today);

			$('#dayplan-sendbutton').on("click", function() {
			//
			});

			//////////////////////////////////////////////////////////////
			
			//dayplan위치 button click 이벤트
			dayplanModalSearchPositionOpen();
	
			//dayplan 위치 검색 모달 close 이벤트
			dayplanModalSearchPositionClose();
			
			//dayplan위치 검색 이벤트
			dayplanModalSearchPosition(client_map_info);
			
			//dayplan savebutton 클릭 이벤트
			dayplanModalSave();
			
			//dayplan updatebutton 클릭 이벤트
			dayplanModalUpdate();
			
			//dayplan deletebutton 클릭 이벤트	
			dayplanModalDelete();
	
	
			/* $("#dayplan-cheif-sendbutton").on("click",function(){
				if(weekno != null){
					//action 설정 및 submit
					//꼭 id input 보내는 위치를 변경할껏! 기억하셈.
				}
			}); */
			
		$("#side-dayplan-coworker-button").on("change",function(){
			//weektable 초기화
			resetweekplan();
			
			//map 초기화
			resetmap();
			
			//  날짜 초기화.
			ClickedDay="";
			$(".dayplan-date").text("날짜 미지정");

			//option에서 선택된 사용자 정보
			selectID = $("#side-dayplan-coworker-button option:selected").val();
			var selectUserInfo = $("#side-dayplan-coworker-button option:selected").text().trim();
			selectUserInfo = selectUserInfo.split("/");  
			
			$("#name").text(selectUserInfo[0]);
			$("#dept").text(selectUserInfo[1]);
			
			
			
			$.get("select?id="+selectID+"&date="+today, 
		    	function(response, status){
				if(status == "success"){
					console.log(response.data);
	
					var events = [];

					$(response.data).each(function(index) {
						var templist;
						var tempdate;

						if (response.data[index].content !== null || response.data[index].content != "") {
							templist = response.data[index].content.split("\n");
							tempdate = response.data[index].date;

							if (templist == "") {
								events.push({
									title : '업무 내용 미기입',
									start : response.data[index].date
									// will be parsed
								});
							}
							for (i = 0; i < templist.length; i++) {
								//console.log(templist[i]);
								if (templist[i] !== "") {
									events.push({
										title : templist[i],
										start : tempdate
										// will be parsed
									});
								}
							}
						}
					});
					$('#calendar').fullCalendar('removeEvents');
		            $('#calendar').fullCalendar('addEventSource', events);
		            
		         
		            //	alert("아이디 변경"+selectID +", 현재 계정 아이디"+authUserID);
		            if(selectID !=authUserID)
					{
						console.log("수정불가");
						weekplandisabled();
					}
					else{
						console.log("수정가능");
						weekplanable();
					}
				}
				else{
					alert("오류 발생: "+status)
				}
			});
			
		});
});

	//texteditor
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
	<div class="panel-info" >
	<div class="content-header panel-heading">
		<h3>
			<strong>영업 계획서</strong>
		</h3>
	</div>
	</div>
	<div id="calendar_main">
		<div id=calendar></div>
	</div>

	<div id="side-dayplan">
		<div id="side-dayplan-title">
			<h5>
				<strong>금일 영업 계획</strong>
			</h5>
		</div>
		<div>
			<div id="side-dayplan-coworker">
				<!-- Small button group -->
				<div id="side-dayplan-coworker-group" class="btn-group">
					<c:choose>
					<c:when test="${authUser.level == '팀장'}">
					<select id="side-dayplan-coworker-button"
						class="btn btn-default btn-sm">
						<option value="${authUser.id}" >
							${authUser.name} / ${authUser.dept}
						</option>
						<c:forEach var="i" items="${members}" varStatus="status">
						<option value="${i.id}">
							${i.name} / ${i.dept}
						</option>
						</c:forEach>
					</select>
					</c:when>
					<c:otherwise>
					<button id="side-dayplan-my-button"
						class="btn btn-default btn-sm">
						${authUser.name} / ${authUser.dept}
					</button>
					</c:otherwise>
					</c:choose>
					<ul id="side-dayplan-coworker_list" class="dropdown-menu"
						role="menu">

					</ul>
				</div>
			</div>
			<div id="side_insert_group">
				<button id="side-dayplan-open-button" type="button"
					class="btn btn-default" aria-label="Left Align"
					data-target="#dayplanmodal">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
				</button>

				<div class="modal modal-center fade" id="dayplancheckmodal"
					role="dialog" style="z-index: 2000;">
					<div class="modal-dialog modal-center modal-sm">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header" style="border-bottom : 1px solid #fff">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">알 림</h4>
							</div>
							<div class="modal-body">
								<p>달력에서 날짜를 먼저 클릭해 주세요.</p>
							</div>
							<div class="modal-footer" style="border-top : 1px solid #fff">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">확인</button>
							</div>
						</div>

					</div>
				</div>
				
				<div id="dayplanmodal" class="modal fade" role="dialog"
					style="z-index: 2000;">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content" style="width: 800px;">
							<div class="modal-header">
								<h3 class="dayplan">
									<strong>일일 계획서</strong>
								</h3>
								<div>
									<button type="button" class="close" id="dayplanmodalclose"
										data-dismiss="modal">&times;</button>
									<br>
								</div>
							</div>

							<div class="modal-body">
								<form id="dayplanform" class="form-inline" method="#" action="#">
									<table id="dayplantable"
										style="width: 100%; margin: 0 auto; border-spacing: 20px; border-collapse: separate;">
										<tr>
											<td colspan="3" id="content2">
												<div class="form-group">
													<div style="display: inline-block;">
														<label for="show-day-title" style="width: 40px;">제목&nbsp;</label>
														<input id="dayplantable-title"
															class="form-control dayplanform-input" type="text"
															name="title" placeholder="[필수입력 항목]"
															style="width: 459px; margin-right: 6px;" required>
													</div>
													<input type="hidden" name="id" class="dayplanform-input"
														value="${authUser.id}"> <label for="day" style="width: 50px;">작성일&nbsp;</label>
													<div id="date-reg-date" class="form-control"
														style="width: 120px;"></div>
													<input type="hidden" id="dateplan-date" name="date" class="dayplanform-input">	
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<div id="challengeinput" class="form-group"
													style="width: -webkit-fill-available;">
													<div>
														<strong>오늘의 도전 과제(성과에 반영)</strong>
													</div>
													<select id="challenge"
														class="form-control dayplanform-input" name="challenge_no"
														style="width: -webkit-fill-available; text-align-last: center;">
													</select>
												</div>
											</td>
										</tr>
										<tr id="second-line">
											<td>
												<div class="form-group">
													<span><strong>목표액</strong></span>
													<div id="goalmoney" class="form-control dayplanform-input"></div>
												</div>
											</td>
											<td>
												<div class="form-group">
													<span><strong>예상 주행거리량(km)</strong></span> <input
														id="datetable-distance"
														class="form-control dayplanform-input" type="text" name="estimate_distance"
														placeholder="방문 지점 거리 측정하여 표시" readonly>
												</div>
											</td>
											<td>
												<div class="form-group">
													<span><strong>방문지점</strong></span> <input
														id="datetable-branch" data-toggle="tooltip"
														class="form-control dayplanform-input" type="text" name="estimate_course"
														placeholder="지도에서 방문지점 선택시 자동 삽입" readonly>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<div id="map_content">
												<input type="hidden" id="dayplan-route" name="route" value="">												
													<span id="mapsearch"><strong>지도 검색</strong> </span>
													<ul style="display: -webkit-box;">
														<li><button id="dateplan-searchRoutes" type="button" class="btn btn-info"
																onclick="searchRoute()">경로탐색</button>
														<li>
														<li><button id="dateplan-deleteRoutes" type="button" class="btn btn-info"
																onclick="deleteRoute()">경로삭제</button>
														<li>
														<li><button id="dateplan-searchPosition" class="btn btn-info"
																type="button">위치검색</button>
														<li>
													</ul>
													<div id="searchPosition-modal" class="modal fade"
														style="z-index: 10000;" role="dialog">
														<div class="modal-dialog modal-sm">

															<!-- Modal content-->
															<div class="modal-content">
																<div class="modal-header">
																	<button type="button" id="searchPosition-modal-close"
																		class="close" data-dismiss="modal">&times;</button>
																	<h4 class="modal-title">위치 검색</h4>
																</div>
																<div class="modal-body">
																	<ul id="position-list">
																		<li><strong>[업체 리스트]</strong></li>
																	</ul>

																</div>
																<div class="modal-footer">
																	<label for="my-positions">업체명: </label> <input
																		id="my-positions" name="search-position">
																	<button type="button" id="searchPosition-search"
																		class="btn btn-default">검색</button>
																</div>
															</div>
														</div>
													</div>
													<div id="map_div"></div>
												</div>
											</td>
										</tr>
									</table>
									<table class="table table-striped table-bordered"
										id="dayplantable-weekplan">
										<thead>
											<tr>
												<th>월</th>
												<th>화</th>
												<th>수</th>
												<th>목</th>
												<th>금</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><ul></ul></td>
												<td><ul></ul></td>
												<td><ul></ul></td>
												<td><ul></ul></td>
												<td><ul></ul></td>
											</tr>
										</tbody>
									</table>
								</form>
								<div class=" panel panel-default form-group"
									style="width: 100%;">
									<div class="panel-heading">
										<strong>업무 일정</strong>
									</div>
										<textarea id="date-textarea"></textarea>
								</div>
								<c:choose>
								<c:when test="${authUser.level == '팀원'} ">
								<div class="panel panel-info">
									<div class="panel-heading">
										<strong>팀장 의견</strong>
									</div>
									<div class="panel-body">팀장의견을 입력받을것.</div>
								</div>
								</c:when>
								<c:otherwise>
								
								</c:otherwise>
								</c:choose>
								<div class="modal-footer">
									<div class="btn-group btn-group-justified" role="group"
										style="width: 240px; float: right;">
										<div id="dayplan-write-btn" class="btn-group" role="group">
											<button id="dayplan-savebutton" class="btn btn-primary"
												type="submit">
												<strong>저장하기</strong>
											</button>
										</div>
										<div id="dayplan-update-btn" class="btn-group" role="group">
											<button id="dayplan-updatebutton" class="btn btn-info"
												type="submit" data-dismiss="modal">
												<strong>수정하기</strong>
											</button>
										</div>
										<div id="dayplan-delete-btn" class="btn-group" role="group">
											<button id="dayplan-deletebutton" class="btn btn-default"
												type="submit" data-dismiss="modal">
												<strong>삭제하기</strong>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div id="side-dayplan2">
				<div id="side-dayplan-date">
					<i class="fa fa-calendar" aria-hidden="true"></i> <span
						class="dayplan-date"></span>
				</div>
			</div>
			<div id="side-dayplan3">
				<div id="side-dayplan-content"
					style="overflow: hidden; word-wrap: break-word;"></div>
			</div>
		</div>
	</div>
	

	<div id="weekplan_main">
		<div id="weekplan-header">
		<div id="week_title">
			<h3>
				<strong>주간계획 </strong>
 			</h3> 
		</div>
		<div id="week_btn">
			<div class="btn-group btn-group-justified " role="group">
				<div id="write-btn" class="btn-group" role="group">
					<button id="insertDB_button" class="btn btn-primary" disabled
						type="button">저장하기</button>
				</div>
				<div id="delete-btn" class="btn-group" role="group">
					<button id="init_button" class="btn btn-primary" disabled
						type="button">전체 삭제</button>
				</div>
			</div>
		</div>
		</div>

		<form id="weekform" name="weekform" class="form-horizontal"
			method="post">
			<div class="form gorup">
				<input id="first_date" class="form-control" type="hidden"
					name="first_date">
			</div>
			<div>
				<div>
					<table style="margin: 0 auto;">
						<tr>
							<td>
								<div class="week-user-info">
									<span class="week-userinfo-label"><strong>소속&nbsp;</strong></span>
									<div id="dept" class="well well-sm weektable-userinfo">
										${authUser.dept}</div>
								</div>
							</td>
							<td>
								<div class="week-user-info">
									<span class="week-userinfo-label"><strong>이름&nbsp;</strong></span>
									<div id="name" class="well well-sm weektable-userinfo">${authUser.name}</div>
								</div>
							</td>
							<td>
								<div class="week-user-info">
									<span class="week-userinfo-label"><strong>작성일&nbsp;</strong></span>
									<div id="reg-day" class="well well-sm weektable-userinfo"></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="form gorup week-user-info" >
									<label id="weeklabel" for="target_figure">주간 목표액</label> <input
										class="well well-sm  weekinput" id="target_figure"
										name="target_figure" type="text" readonly>
								</div>
							</td>
							<td>
								<div class="form gorup week-user-info">
									<label for="week_sale">주간 매출액</label>
									<div class="well well-sm weekinput" id="week_sale"
										style="display: inline-block;">매출액(원)</div>
								</div>
							</td>
							<td>
								<div class="form gorup week-user-info">
									<label for="achive_rank">주간 달성률</label>
									<div class="well well-sm weekinput" id="achive_rank"
										style="display: inline-block; margin-left: 25px;">달성률(%)</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<div class="form gorup">
									<label for="weektabletitle">제목</label> <input
										class="well well-sm form-control" id="show-week-title"
										placeholder="[주간계획]" disabled></input> <input
										class="well well-sm form-control " id="weektabletitle"
										name="title" type="text" placeholder="제목입력" autocomplete=”off”
										disabled>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="weektable">
				<table class="tg">
					<tr>
						<th class="tg-amwm">요일</th>
						<th class="tg-e3zv">월(<span> </span>)
						</th>
						<th class="tg-e3zv">화(<span> </span>)
						</th>
						<th class="tg-e3zv">수(<span> </span>)
						</th>
						<th class="tg-e3zv">목(<span> </span>)
						</th>
						<th class="tg-e3zv">금(<span> </span>)
						</th>
					</tr>
					<tr>
						<td class="tg-9hbo">일일 목표액</td>
						<td class="weekmoney">
							<div class="form gorup" style="display: inline-block;">
								<input class="form-control target-money" id="monday_money"
									name="Monday_money" type="Number"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' min="0" disabled>
							</div> <span>원</span>
						</td>
						<td class="weekmoney">
							<div class="form gorup" style="display: inline-block;">
								<input class="form-control target-money" id="tuesday_money"
									name="Tuesday_money" type="Number"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' min="0" disabled>
							</div> <span>원</span>
						</td>
						<td class="weekmoney">
							<div class="form gorup" style="display: inline-block;">
								<input class="form-control target-money" id="wednesday_money"
									name="Wednesday_money" type="Number"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' min="0" disabled>
							</div> <span>원</span>
						</td>
						<td class="weekmoney">
							<div class="form gorup" style="display: inline-block;">
								<input class="form-control target-money" id="thursday_money"
									name="Thursday_money" type="Number"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' min="0" disabled>
							</div> <span>원</span>
						</td>
						<td class="weekmoney">
							<div class="form gorup" style="display: inline-block;">
								<input class="form-control target-money" id="friday_money"
									name="Friday_money" type="Number"
									onkeydown='return onlyNumber(event)'
									onkeyup='removeChar(event)' min="0" disabled>
							</div> <span>원</span>
						</td>
					</tr>
					<tr>
						<td class="tg-amwm">내용</td>
						<td class="tg-031e">
							<ul id="monday-container">
								<li><textarea class="form-control dayedit-content"
										id="monday-content" name="Monday" style="height: 150px"
										placeholder="업무 내용이 없습니다." disabled></textarea>
									<div class="modal fade" role="dialog" style="z-index: 1000;">
										<div class="modal-dialog">
											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close day-content-modal"
														data-dismiss="modal">&times;</button>
													<h4 class="modal-title">활동 계획 입력창</h4>
												</div>
												<div class="modal-body">
													<div class="modal-buttons" style="float: right;">
														<button class="modal-add-button" type="button"
															class="btn btn-default">
															추가 <i class="fa fa-plus" aria-hidden="true"></i>
														</button>
													</div>
													<br> <br>
													<ol class="to-do-list">

													</ol>
												</div>
												<div class="modal-footer">
													<button class="modal-save-button" type="button"
														class="btn btn-default" data-dismiss="modal">저장</button>
												</div>
											</div>
										</div>
									</div></li>
							</ul>
						</td>
						<td class="tg-031e">
							<ul id="tuesday-container">
								<li><textarea class="form-control dayedit-content"
										id="tuesday-content" name="Tuesday" style="height: 150px"
										placeholder="업무 내용이 없습니다." disabled></textarea>
									<div class="modal fade" role="dialog" style="z-index: 1000;">
										<div class="modal-dialog">
											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close day-content-modal"
														data-dismiss="modal">&times;</button>
													<h4 class="modal-title">활동 계획 입력창</h4>
												</div>
												<div class="modal-body">
													<div class="modal-buttons" style="float: right;">
														<!--클래스로 다 만들어서  스타일 적용할것.-->
														<button class="modal-add-button" type="button"
															class="btn btn-default">
															추가 <i class="fa fa-plus" aria-hidden="true"></i>
														</button>
													</div>
													<br> <br>
													<ol class="to-do-list">

													</ol>
												</div>
												<div class="modal-footer">
													<button class="modal-save-button" type="button"
														class="btn btn-default" data-dismiss="modal">저장</button>
												</div>
											</div>
										</div>
									</div></li>
							</ul>
						</td>
						<td class="tg-031e">
							<ul id="wednesday-container">
								<li><textarea class="form-control dayedit-content"
										id="wednesday-content" name="Wednesday" style="height: 150px"
										placeholder="업무 내용이 없습니다." disabled></textarea>
									<div class="modal fade" role="dialog" style="z-index: 1000;">
										<div class="modal-dialog">
											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close day-content-modal"
														data-dismiss="modal">&times;</button>
													<h4 class="modal-title">활동 계획 입력창</h4>
												</div>
												<div class="modal-body">
													<div class="modal-buttons" style="float: right;">
														<!--클래스로 다 만들어서  스타일 적용할것.-->
														<button class="modal-add-button" type="button"
															class="btn btn-default">
															추가 <i class="fa fa-plus" aria-hidden="true"></i>
														</button>
													</div>
													<br> <br>
													<ol class="to-do-list">

													</ol>
												</div>
												<div class="modal-footer">
													<button class="modal-save-button" type="button"
														class="btn btn-default" data-dismiss="modal">저장</button>
												</div>
											</div>
										</div>
									</div></li>
							</ul>
						</td>
						<td class="tg-031e">
							<ul id="thursday-container">
								<li><textarea class="form-control dayedit-content"
										id="thursday-content" name="Thursday" style="height: 150px"
										placeholder="업무 내용이 없습니다." disabled></textarea>
									<div class="modal fade" role="dialog" style="z-index: 1000;">
										<div class="modal-dialog">
											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close day-content-modal"
														data-dismiss="modal">&times;</button>
													<h4 class="modal-title">활동 계획 입력창</h4>
												</div>
												<div class="modal-body">
													<div class="modal-buttons" style="float: right;">
														<!--클래스로 다 만들어서  스타일 적용할것.-->
														<button class="modal-add-button" type="button"
															class="btn btn-default">
															추가 <i class="fa fa-plus" aria-hidden="true"></i>
														</button>
													</div>
													<br> <br>
													<ol class="to-do-list">

													</ol>
												</div>
												<div class="modal-footer">
													<button class="modal-save-button" type="button"
														class="btn btn-default" data-dismiss="modal">저장</button>
												</div>
											</div>
										</div>
									</div></li>
							</ul>
						</td>
						<td class="tg-031e">
							<ul id="friday-container">
								<li><textarea class="form-control dayedit-content"
										id="friday-content" name="Friday" style="height: 150px"
										placeholder="업무 내용이 없습니다." disabled></textarea>
									<div class="modal fade" role="dialog" style="z-index: 1000;">
										<div class="modal-dialog">
											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close day-content-modal"
														data-dismiss="modal">&times;</button>
													<h4 class="modal-title">활동 계획 입력창</h4>
												</div>
												<div class="modal-body">
													<div class="modal-buttons" style="float: right;">
														<!--클래스로 다 만들어서  스타일 적용할것.-->
														<button class="modal-add-button" type="button"
															class="btn btn-default">
															추가 <i class="fa fa-plus" aria-hidden="true"></i>
														</button>
													</div>
													<br> <br>
													<ol class="to-do-list">

													</ol>
												</div>
												<div class="modal-footer">
													<button class="modal-save-button" type="button"
														class="btn btn-default" data-dismiss="modal">저장</button>
												</div>
											</div>
										</div>
									</div></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	</main>
</body>
</html>