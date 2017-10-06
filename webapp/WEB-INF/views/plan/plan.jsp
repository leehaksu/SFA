<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<c:import url="/WEB-INF/views/common/common.jsp"></c:import>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/plan/calendar.js"></script>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/plan/weekplan.js"></script>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/plan/dayplan.js"></script>	
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/map/map.js"></script>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/util/util.js"></script>
	
<script>
	$(document).ready( function() {
		$.get("challenge/", function(response, status){
	       	console.log("도전 데이터 크기"+response.data.length);
	       	for(i=0; i < response.data.length;i++){
	       		console.log(i+"번째 도전입력");
	       	    var option = document.createElement("option");
	       	 	option.setAttribute("value",response.data[i].content);
	       	 	var t = document.createTextNode(response.data[i].content);
	       	 	option.appendChild(t);
	       	 	$("#challenge").append(option);
	       	}
	    });
		
		$(function() { $('#date-textarea').froalaEditor(
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
		//현재위치 정보 가져오기.
			getLocation();
			
			//자동완성
			$("#my-positions").autocomplete({
	       		source: positions
	       	});
			
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
								events : function(start, end,
										timezone, callback) {
									//console.log("캘린더 날짜: " + today);
									current = $('#calendar').fullCalendar('getDate').format("YYYY-MM-DD");
									//console.log("moment변수" + current);
									$.ajax({
												url : '/sfa/week/select?date='+ current,
												type : 'GET',
												dataType : 'json',
												success : function(doc) {
													var events = [];
													console.log(doc.data);

													$(doc.data).each(function(index) {
													var templist;
													var tempdate;

													if (doc.data[index].content !== null || doc.data[index].content != "") {
														templist = doc.data[index].content.split("\n");
														tempdate = doc.data[index].date;
														
														if (templist == "") {
															events.push({
																		title : '업무 내용 미기입',
																		start : doc.data[index].date
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
													callback(events);
											}
									});
								},
								dayClick : function(date, jsEvent,view) {
									//클릭한 날짜를  날짜 형식을 'YYYY-MM-DD'로 맞춰준다.
									dayClick = date.format('YYYY-MM-DD');	
									//현재 날짜와 클릭한 날짜 비교 
									var plandatecheck = moment(dayClick).isSameOrAfter(today);
									
									//선택한 날짜가 있는지 없는지 유무 확인
									if (dayClick != null) {
										$.ajax({
												url : "/sfa/date/select",
												type : 'POST',
												data : "date="+ dayClick, //2017-09-08
												dataType : "json",
												success : function(response) {
					 								console.log(response.data);
					 							
					 								//금일 일일 계획서 내용 초기화
					 								$("#side_title_04").empty();
					 								
					 								////금일 일일 계획서 내용 존재 여부 확인
					 								if(response.data == null){
						 									//alert("작성된 일일 계획서가 없습니다.");
						 									$("#side_title_04").text("입력된 계획이 없습니다.");
						 									$("#dayplantable-title").val("");
						 									$("#date-reg-date").text("미작성일");
						 									$("#date-reg-date").css("background-color","#eee");
						 									$("#goalmoney").css("background-color","#eee");
						 									//날짜를 기준으로 클릭한 날짜가 현재 날짜와 같거나 이후이면 새로 작성가능(저장버튼 show).
						 									if(plandatecheck){ 
							 									$("#dayplantable-title").removeAttr('disabled');
							 									$("#challenge").removeAttr('disabled');
							 									$("#dateplan-searchRoutes").removeAttr('disabled');
							 									$("#dateplan-deleteRoutes").removeAttr('disabled');
							 									$("#dateplan-searchPosition").removeAttr('disabled');
								 								$("#write-btn").show();	
							 								}
							 								//지난 날짜에 대하여 예외처리(모든 입력과 이벤트를 불가능하게 한다.)
							 								else{
							 									$("#dayplantable-title").attr('disabled',true);
							 									$("#challenge").attr('disabled',true);
							 									$("#dateplan-searchRoutes").attr('disabled',true);
							 									$("#dateplan-deleteRoutes").attr('disabled',true);
							 									$("#dateplan-searchPosition").attr('disabled',true);
							 									$("#write-btn").hide();
								 								$("#update-btn").hide();
																$("#delete-btn").hide();
							 								}
						 									
						 									return ;
					 									}
					 								else{
					 										var tempcontent = response.data.content.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
					 										console.log();
					 										$("#side_title_04").html();
															$("#dayplantable-title").val(response.data.title);
						 									$("#date-reg-date").text(response.data.reg_date);
						 									$("#date-reg-date").css("background-color","");
						 									$("#goalmoney").css("background-color","");
							 								 if(response.data.challenge_no != null){
							 									$("#challenge option").each(function(){
							 										if($(this).val()==response.data.challenge_content){
							 											$(this).html(response.data.challenge_content);
							 											$(this).prop('selected',true);
							 										}
							 										else{
							 											$(this).removeAttr("selected");
							 										}
							 									});
							 								}
							 								else{
							 										$("#challenge option:eq(0)").prop("selected",true);
							 									} 
							 								$("#datetable-distance").val(response.data.estimate_distance);
							 								$("#datetable-branch").val(response.data.estimate_course);	
							 								$('#date-textarea').froalaEditor('html.set', response.data.content);
							 								$('#datetable-branch').tooltip('enable'); 
							 							
							 								if(plandatecheck){ 
							 									$("#dayplantable-title").removeAttr('disabled');
							 									$("#challenge").removeAttr('disabled');
							 									$("#dateplan-searchRoutes").removeAttr('disabled');
							 									$("#dateplan-deleteRoutes").removeAttr('disabled');
							 									$("#dateplan-searchPosition").removeAttr('disabled');
								 								$("#write-btn").hide();
								 								$("#update-btn").show();
																$("#delete-btn").show();	
							 								}
							 								//지난 날짜에 대하여 예외처리(모든 입력과 이벤트를 불가능하게 한다.)
							 								else{
							 									$("#dayplantable-title").attr('disabled',true);
							 									$("#challenge").attr('disabled',true);
							 									$("#dateplan-searchRoutes").attr('disabled',true);
							 									$("#dateplan-deleteRoutes").attr('disabled',true);
							 									$("#dateplan-searchPosition").attr('disabled',true);
							 									$("#write-btn").hide();
								 								$("#update-btn").hide();
																$("#delete-btn").hide();
							 								}
												}
												},
												error : function(
														xhr,
														status,
														error) {
													alert(xhr + " 와 " + status + " 와 " + error);
												}
											});
										$.post("/sfa/customer/position",
									        	function(data,status){
									            //console.log(data );
									        });
									} else {
										$("#dayplancheckmodal").modal('show');
										$.post("/sfa/position",
									        	function(data,status){
									            //console.log(data);
									        });
									}
									
									
									//console.log(dayClick);	
									
									//주간계획
									$.ajax({
												url : "/sfa/week/select",
												type : 'POST',
												data : "date="+ dayClick, //2017-08-26
												dataType : "json",
												success : function(response) {
													console.log(response.data)
													//제목 넣기
													weekno = response.data.week_no;
													//modal-list, textarea 초기화
													$(".dayedit-content").val("");
													$(".to-do-list").children().remove(); // 현재 모달에 입력된 값 다 날리고

													//주간테이블  textarea에 들어갈 데이터 체크 후 배열에 담는다. 앞에 공백이 있으면 제거 해주고 넣어야 함.
													weeklist = [
															$.trim(response.data.monday),
															$.trim(response.data.tuesday),
															$.trim(response.data.wednesday),
															$.trim(response.data.thursday),
															$.trim(response.data.friday) ]

													//주간 테이블에 들어갈 목표액을 배열에 담아 보관한다. 
													weektargetmoney = [
														 new Number(response.data.monday_money),
															new Number(response.data.tuesday_money),
															new Number(response.data.wednesday_money),
															new Number(response.data.thursday_money),
															new Number(response.data.friday_money) ];
															console.log(weektargetmoney);

													//주간 테이블 작성일 넣기
													if (typeof response.data.reg_date == "undefined" || response.data.reg_date == null || response.data.reg_date == "") {
														$("#reg-day").text(today);
													} else {
														$("#reg-day").text(response.data.reg_date);
													}

													//주간 테이블 주간 목표액 넣기
													$("#target_figure").attr("type","text");
													weektotaltargetmoney = addThousandSeparatorCommas(response.data.target_figure);
													$('#target_figure').val(weektotaltargetmoney+"");
													

													//주간 테이블 주간 매출액 넣기
													(typeof response.data.week_sale == "undefined" || response.data.week_sale == null || response.data.week_sale == "") 
													? $('#week_sale').text("매출액이 없습니다."): $('#week_sale').text(addThousandSeparatorCommas(response.data.week_sale));

													//주간 테이블 주간 달성율 넣기
													(typeof response.data.achive_rank == "undefined" || response.data.achive_rank == null || response.data.achive_rank == "") 
													? $('#achive_rank').text("%"): $('#achive_rank').text(response.data.achive_rank + "%");

													//주간 테이블 제목 넣기
													if (typeof response.data.week_no == "undefined"
															|| response.data.week_no == null
															|| response.data.week_no == "") {
														$("#weektabletitle").val("");
														$("#show-week-title").val("미입력주차");
													} else {
														var show_week_title = response.data.week_no.substring(4,6)
																+ "월 "
																+ response.data.week_no.substring(7,8)
																+ " 주차";
														$("#show-week-title").val(show_week_title);
														$("#weektabletitle").val(response.data.title);
													}
													// 주간 일일 목표액 넣기
													$('.weekmoney > div > input').each(
																	function(index) {
																		if (typeof weektargetmoney[index] == "undefined"
																				|| weektargetmoney[index] == null
																				|| weektargetmoney[index] == 0
																				|| weektargetmoney[index] == "") {
																			$(this).val("");
																		}
																		//console.log(weektargetmoney[index]);
																		$(this).val(weektargetmoney[index]);
																	});

													//주간테이블에 요일 마다 list 넣기.
													$('.tg-031e > ul > li > textarea').each(
																	function(index) {
																		if (weeklist[index] !== "null") {
																			$(this).val(
																				weeklist[index]);
																		} else {
																			return;
																		}
																	});

													//주간 테이블에요일마다 날짜 넣기
													thisweekdate = [
															response.data.monday_date,
															response.data.tuesday_date,
															response.data.wednesday_date,
															response.data.thursday_date,
															response.data.friday_date ]
													//console.log("요일날짜" + thisweekdate);//확인

													$('.tg-e3zv > span').each(function(index) {
														var tmpDate = thisweekdate[index].split("-"); // 날짜 "-" 기준으로 짜르기
														$(this).text(
																		tmpDate[1]
																		+ "-"
																		+ tmpDate[2]); //월-일만 표기
														//날짜 비교를 통해 오늘날짜와 주간 테이블의 요일 날짜를 비교하여 이전 날짜면 true 같거나 이후 날짜면 false를 반환한다.
														var editedaycheck = moment(thisweekdate[index]).isBefore(today);
														//console.log(editedaycheck);

														if (editedaycheck) {
															$("#week_btn >.btn-group").attr("class","btn-group btn-group-justified fade");
															$("#weektabletitle").attr("disabled",true);
															$(".target-money:eq("+ index + ")").attr("disabled",true);
															$(".dayedit-content:eq("+ index + ")").attr("disabled",true);
														} else {
															$(".btn-group").attr("class","btn-group btn-group-justified");
															$("#weektabletitle").attr("disabled",false);
															$(".target-money:eq("+ index+ ")").attr("disabled",false);
															$(".dayedit-content:eq("+ index + ")").attr("disabled",false);
														}
													});
													$("#target_figure").attr("readonly",true);
													$("#insertDB_button").removeAttr("disabled");
													$("#init_button").removeAttr("disabled");

													daychangecheck ^= daychangecheck; //날짜를 클릭하면 변화플래그로 변화를 체크하여 textarea를 바꿔 준다. 

													$(".dayplan-date").text(dayClick);

													/* dayplantable AJAX*/
													$('#show-day-title').val(dayClick);

													//console.log("클릭날짜:"+ dayClick + "비교날짜" + thisweekdate[0]);
													for (i = 0; i < thisweekdate.length; i++) {
														if (thisweekdate[i] === dayClick) {
															goalmoneyindex = i;
															//console.log("클릭날짜:"+ date + "비교날짜" + thisweekdate[i] + "배열인덱스 번호:" +i);
														}
													}
													if (typeof weektargetmoney[goalmoneyindex] == "undefined"
															|| weektargetmoney[goalmoneyindex] == null
															|| weektargetmoney[goalmoneyindex] == 0
															|| weektargetmoney[goalmoneyindex] == "") {
														$("#goalmoney").text("목표액이 없습니다.");
														dateGoalMoney=0;
													}

													else {
														dateGoalMoney=weektargetmoney[goalmoneyindex];
														$("#goalmoney").text(addThousandSeparatorCommas(dateGoalMoney)+ "원");
													}
													//일일 계획서의 주간 테이블 초기화 작업
													$('#dayplantable-weekplan > tbody> tr > td > ul').each(function() {
														$(this).children('li').remove();
														$(this).children('br').remove();
													});
													
													//일일 계획서의 주간 테이블 데이터 삽입
													$('#dayplantable-weekplan > tbody> tr > td').each(
													function(index) {
														var templist = weeklist[index].split("\n");
														if (weeklist[index] !== "null"
																&& weeklist[index] !== ""
																&& typeof weeklist[index] !== "undefined") {
															for (i = 0; i < templist.length; i++) {
																$(this).children("ul").append(
																				"<li>"
																				+ templist[i]
																				+ "</li>");
															//console.log(weeklist[index]);
															}
														} else {
															$(this).children("ul").append("<li> 업무 내용 미기입</li>");
														}
													});
													
													//plan 페이지 오른쪽 일일 계획
													
												},
												error : function(xhr,status,error) {
													alert(xhr + " 와 " + status + " 와 " + error);
												}
											});
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
			$(".target-money").change(function(event) {
				weektotaltargetmoney = Number($("#monday_money").val())
						+ Number($("#tuesday_money").val())
						+ Number($("#wednesday_money").val())
						+ Number($("#thursday_money").val())
						+ Number($("#friday_money").val());
				$("#target_figure").val(addThousandSeparatorCommas(weektotaltargetmoney));
			});
			//textarea focus됬을 때 
			$(".dayedit-content").focus(function() {
				var splitlist;
				var dayedit_content = $(this).val();

				if (daychangecheck == false) {
					$(".to-do-list").each(function(index) {
						//console.log(index + "요일 입력" );
						//console.log("요일 내용" + $(this).val());						
						splitlist = dayedit_content.split("\n");
						for (i = 0; i < splitlist.length; i++) {
							var item = '<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>';
							$(this).append(item);
						}
						for (i = 0; i < splitlist.length; i++) {
							$(this).children("li").eq(i).children(".modallist-todo-input").val(splitlist[i]);
						}
					});
				}
				daychangecheck = true;
				$(this).next().attr("class","modal show");
				$(this).blur();
			});
			$(".day-content-modal").on("click",function() {
				$(this).parent().next().children(".to-do-list").children().remove();

				var dayeditcontent = $(this).parents("li").children(".dayedit-content").val();
				var trimdata = $.trim(dayeditcontent);

				var remakesplitlist = trimdata.split("\n");
				//console.log(remakesplitlist);

				for (i = 0; i < remakesplitlist.length; i++) {
					var item = '<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>';
					$(this).parent().next().children(".to-do-list").append(item);
				}

				//console.log(remakesplitlist.length);
				for (i = 0; i < remakesplitlist.length; i++) {
					$(this).parent()   // 수정이 필요한 코드 //
							.next()
							.children(".to-do-list")
							.children("li")
							.eq(i)
							.children(".modallist-todo-input")
							.val(remakesplitlist[i]);
				}

				$(".modal").attr("class","modal fade");
			});

			//주간 계획 modal input 추가 
			$(".modal-add-button").on("click",function() {
				$(this).parent()
						.nextAll("ol")
						.append('<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>');
			});

			//리스트 한개씩 지우기
			$(document).on("click", ".removevbtn", function() {
				//console.log(this);
				$(this).parent().next().remove();
				$(this).parent().remove();
			});

			//주간 계획 modal 저장 
			$(".modal-save-button").click(function() {
				var plan = "";
				var emptycheck = true;
				$(this).parent()
						.prev()
						.find("input")
						.each(function(index,item) {
									if ($(this).val() == "") {
										alert("비어있는 칸이 존재 합니다.칸을 없애시거나 채워주세요.");
										$(this).focus();
										emptycheck = false;
									}
									plan += $(this).val()+ "\n";
								});
				if (emptycheck == true) {
					$(".modal").attr("class","modal fade");
					$(this).parents("ul").children("li").children("textarea").val(plan);
					//console.log($(this).parent().next().children().next().children());
				}
			});

			$('#side_drop_button02').click(function() {
				//바로 뜨면 안됨. 날짜 클릭 확인이 이루어져야 한다. 
				dayplanmodalShow();
		       /*  var curLonLat = new Tmap.LonLat(127.027632,37.498078).transform(pr_4326,pr_3857)
		        var carlabel = new Tmap.Label("지점: 강남역 입니다");
		        var curmarker = new Tmap.Marker(curLonLat, icon, carlabel);
		        markerLayer.addMarker(curmarker); 
		       	 */
		       	 
				/* if (dayClick != null) {
					$.ajax({
							url : "/sfa/date/select",
							type : 'POST',
							data : "date="+ dayClick, //2017-09-08
							dataType : "json",
							success : function(response) {
 								console.log(response);
 									if(response.data == null){
	 									alert("작성된 일일 계획서가 없습니다.");
	 									dayplanmodalShow();
	 									$("#write-btn").show();
	 									$("#update-btn").hide();
	 									$("#delete-btn").hide();
	 									return ;
 									}
 									else{
	 									$("#dayplantable-title").val(response.data.title);
	 									$("#date-reg-date").text(response.data.reg_date);
		 								 if(response.data.challenge_no != null){
		 									$("#challenge option").each(function(){
		 										if($(this).val()==response.data.challenge_content){
		 											$(this).html(response.data.challenge_content);
		 											$(this).prop('selected',true);
		 										}
		 										else{
		 											$(this).removeAttr("selected");
		 										}
		 									});
		 								}
		 								else{
		 										$("#challenge option:eq(0)").prop("selected",true);
		 									} 
		 								$("#datetable-distance").val(response.data.estimate_distance);
		 								$("#datetable-branch").val(response.data.estimate_course);	
		 								$('#date-textarea').froalaEditor('html.set', response.data.content);
		 								$('#datetable-branch').tooltip('enable'); 
		 								dayplanmodalShow();
		 								$("#write-btn").hide();
		 								$("#update-btn").show();
										$("#delete-btn").show();
							}
							},
							error : function(
									xhr,
									status,
									error) {
								alert(xhr + " 와 " + status + " 와 " + error);
							}
						});
					$.post("/sfa/position",
				        	function(data,status){
				            console.log(data );
				        });
				} else {
					$("#dayplancheckmodal").modal('show');
					$.post("/sfa/position",
				        	function(data,status){
				            console.log(data);
				        });
				} */
				  
	       	 	
			});
			$("#dayplanmodalclose").on("click",function() {
				$('#datetable-branch').tooltip('disable');
				$('html, body').css({'overflow' : 'auto','height' : '100%'}); //scroll hidden 해제 
				$('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
				$('.editor').remove();
				$('.dayplanform-input').each(function() {
					$(this).val("");
				});
				; 
				$('#dayplantable-weekplan > tbody> tr > td > ul').each(function() {
						$(this).children('li').remove();
						$(this).children('br').remove();
					});
				$('#date-textarea').froalaEditor('html.set', '');

				$("#dayplanmodal").attr("class","modal fade");
			});

			$("#insertDB_button").on("click",function() {
				var form = document.getElementById("weekform");

				// 첫째날 담아 보내기
				$("#first_date").val(thisweekdate[0]);
				//console.log(thisweekdate[0].data);
				alert(thisweekdate[0]);
				// , 빼고 보내기
				$("#target_figure").attr("type","Number");
				$("#target_figure").val(new Number(removeComma(weektotaltargetmoney)));

				if (weekno != null) {
					//action 설정 및 submit
					form.action = "update"; // action에 해당하는 jsp 경로를 넣어주세요.
					form.submit();
				} else {

					form.action = "insert"; // action에 해당하는 jsp 경로를 넣어주세요.
					form.submit();
				}
			});

			$("#init_button").on("click",function() {
				for (index = 0; index < thisweekdate.length; index++) {
					if (moment(thisweekdate[index]).isSameOrAfter(today)) {
						daychangecheck = true;
						$("#weektabletitle").val("");
						$(".target-money:eq("+ index+ ")").val("");
						$(".dayedit-content:eq("+ index + ")").val("");
						$(".to-do-list").children().remove();
						$(".to-do-list").append('<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>');
					}
				}
			});
			//달력에 dayclick 이벤트가 발생하기전 주간 테이블 작성일
			$("#reg-day").text(today);

			/*dayplan script */
			//dayplan 오늘 날짜 화면 표시
			$(".dayplan-date").text("날짜 미지정");

			$('#show-day-title').val("" + today);

			$('#dayplan-sendbutton').on("click", function() {
			//
			});

			
			$("#searchPosition-modal-close").on("click", function() {
				$("#searchPosition-modal").attr("class","modal fade");
			});
			
			
			$("#searchPosition-search").on("click", function() {
				var targetName = $("#my-positions").val();
				client_map_info.forEach(function(item,index,array){
					if(client_map_info[index].name == targetName){
						var templonlat = new Tmap.LonLat(client_map_info[index].positionY,client_map_info[index].positionX).transform(pr_4326,pr_3857);
						map.setCenter(templonlat,zoom)
						console.log(templonlat);
						return ;
					}
				});
				$("#searchPosition-modal").attr("class","modal fade");
			});
			
			
			$("#dayplan-savebutton").click(function(){
				if($("#dayplantable-title").val() == null || $("#dayplantable-title").val() =="")
				{
					return ;	
				}
				var title = $("#dayplantable-title").val();	
				var content = $('#date-textarea').froalaEditor('html.get');
				var challenge = $("#challenge").val();	
				console.log(title);
				console.log(content);
				console.log(challenge);
				//var temp = '<p><b>글자진하게</b></p><p>평범하게</p><p><i>기울게</i></p><p><h1>h1이다</h1></p><p><h2>h2다</h2></p><p><h3>h3다</h3></p>';
				//$('#date-textarea').froalaEditor('html.set', temp);
				
				  $.post("/sfa/date/insert",{
				  		 title:title,
				  		 goal_sale: dateGoalMoney,
				  		 content: content,
				  		 date:dayClick,
				  		 estimate_distance: 100,
				  		 estimate_course:routes,
				  		 challenge_content:challenge
				  		},
				        function(data,status){
				            alert("Data: " + data + "\nStatus: " + status);
				        });
					 		
			});	
			
			
			$("#dayplan-updatebutton").click(function(){
				if($("#dayplantable-title").val() == null || $("#dayplantable-title").val() =="")
				{
					return ;	
				}
				var title = $("#dayplantable-title").val();	
				var content = $('#date-textarea').froalaEditor('html.get');
				var challenge = $("#challenge").val();	
				console.log(title);
				console.log(content);
				console.log(challenge);
				//var temp = '<p><b>글자진하게</b></p><p>평범하게</p><p><i>기울게</i></p><p><h1>h1이다</h1></p><p><h2>h2다</h2></p><p><h3>h3다</h3></p>';
				//$('#date-textarea').froalaEditor('html.set', temp);
				
					  $.post("/sfa/date/update",
						        {
						  		 title:title,
						  		 goal_sale: dateGoalMoney,
						  		 content: content,
						  		 date:dayClick,
						  		 estimate_distance: 100,
						  		 estimate_course:routes,
						  		 challenge_content:challenge
						        },
						        function(data,status){
						            console.log("Data: " + data + "\nStatus: " + status);
						           
									$("#dayplanmodal").attr("class","modal fade");
						        });
			});
			
			
			$("#dayplan-deletebutton").click(function(){
			  $.post("/sfa/date/delete",
		        { 
		  		  date : dayClick, 
		        },
		        function(data,status){
		            console.log("Data: " + data + "\nStatus: " + status);
		            $('#datetable-branch').tooltip('disable');
					$('html, body').css({'overflow' : 'auto','height' : '100%'}); //scroll hidden 해제 
					$('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
					$('.editor').remove();
					$('.dayplanform-input').each(function() {
						$(this).val("");
					});
					; 
					$('#dayplantable-weekplan > tbody> tr > td > ul').each(function() {
							$(this).children('li').remove();
							$(this).children('br').remove();
						});
					$('#date-textarea').froalaEditor('html.set', '');

		            $("#dayplanmodal").attr("class","modal fade");
		        });
			});
	
			
			$("#dateplan-searchPosition").click(function(){
				
				$('#searchPosition-modal').attr("class","modal show");
			});
	
			/* $("#dayplan-cheif-sendbutton").on("click",function(){
				if(weekno != null){
					//action 설정 및 submit
					//꼭 id input 보내는 위치를 변경할껏! 기억하셈.
				}
			}); */
			
		
});

	//texteditor
</script>


</head>
<body >
	<nav class="navbar navbar-default">
		<c:import url="/WEB-INF/views/include/header.jsp">
			<c:param name="menu" value="main" />
		</c:import>
	</nav>
	<div id="wrapper">
		<div class="col-sm-3" id="sidebar-wrapper">
			<c:import url="/WEB-INF/views/include/navigator.jsp">
				<c:param name="menu" value="main" />
			</c:import>
		</div>

		<main id="page-content-wrapper" role="main">

		<div id="calendar_main">
			<div id=calendar></div>
		</div>
		
		<div id="side_main">
			<div id="side_title">
				<h5>
					<strong>금일 영업 계획</strong>
				</h5>
			</div>
			<div id="side_title">
				<div id="side_drop_button">
					<!-- Small button group -->
					<div id="side_drop_group" class="btn-group">
						<button id="side_drop_button"
							class="btn btn-default btn-sm dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="false">
							${authUser.name} / ${authUser.dept} &nbsp; &nbsp; &nbsp;<span
								class="caret"></span>
						</button>
						<ul id="side_drop_button" class="dropdown-menu" role="menu">

						</ul>
					</div>
				</div>
				<div id="side_insert_group">
					<button id="side_drop_button02" type="button"
						class="btn btn-default" aria-label="Left Align"
						data-target="#dayplanmodal">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</button>

					<div class="modal fade" id="dayplancheckmodal" role="dialog"
						style="z-index: 2000;">
						<div class="modal-dialog modal-sm">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">우선 사항</h4>
								</div>
								<div class="modal-body">
									<p>달력에서 날짜를 먼저 클릭해 주세요.</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">확인</button>
								</div>
							</div>

						</div>
					</div>
					<!-- Modal -->
					<%-- 					<c:choose>
						<c:when test="${authUser.level == '팀장'}">
							<!-- c:import로 구분하여 불러들이기 -->
							<div id="dayplanmodal" class="modal fade" role="dialog"
								style="z-index: 2000;">
								<div class="modal-dialog">

									<!-- Modal content-->
									<div class="modal-content" style="width: 800px;">
										<div class="modal-header">
											<h3 class="dayplan">
												<strong>일일 계획서</strong>
											</h3>
											<button type="button" class="close" id="dayplanmodalclose"
												data-dismiss="modal">&times;</button>
											<br>
										</div>

										<div class="modal-body" onload="init()">
											<form id="dayplanform" class="form-inline" method="#"
												action="#">
												<table id="dayplantable"
													style="width: 100%; margin: 0 auto; border-spacing: 20px; border-collapse: separate;">
													<tr>
														<td id="content1">
															<div>
																<span><strong>소속&nbsp;</strong></span>
																<div id="dept" class="well well-sm weektable-userinfo">
																	영업1팀</div>
															</div>
														</td>
														<td id="content2">
															<div>
																<span><strong>이름&nbsp;</strong></span>
																<div id="name" class="well well-sm weektable-userinfo">노경욱</div>
															</div>
														</td>
														<td id="content3">
															<div>
																<span><strong>작성일&nbsp;</strong></span>
																<div id="reg-day"
																	class="well well-sm weektable-userinfo"></div>
															</div>
														</td>
													</tr>
													<tr>
														<td id="content4" colspan="2">
															<label for="show-day-title" style="width: 40px;">제목&nbsp;</label>
															<div class="form-group" style="float: left;">
																<input id="title" class="well well-sm form-control"
																	style="margin-bottom: 0px; width: 468px;" type="text"
																	name="" placeholder="제목" disabled> <input
																	type="hidden" name="id" value="노대리">
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
																<input id="challenge" class="form-control" type="text"
																	name="" placeholder="select형식으로 정해진 과제 중 선택으로??"
																	style="width: -webkit-fill-available;" disabled>
															</div>
														</td>
													</tr>
													<tr id="second-line">
														<td>
															<div class="form-group">
																<span><strong>목표액</strong></span> <input id="goalmoney"
																	class="form-control" type="text" name=""
																	placeholder="주간 목표액을 placeholder로 보여주기" disabled>
															</div>
														</td>
														<td>
															<div class="form-group">
																<span><strong>예상 주행거리량</strong></span> <input
																	id="distance" class="form-control" type="text" name=""
																	placeholder="방문 지점 거리 측정하여 표시" disabled>
															</div>
														</td>
														<td>
															<div class="form-group">
																<span><strong>방문지점</strong></span> <input id="branch"
																	class="form-control" type="text" name=""
																	placeholder="지도에서 방문지점 선택시 자동 삽입" disabled>
															</div>
														</td>
													</tr>
													<tr>
														<td colspan="3">
															<div onload="init()">
																<span id="mapsearch"><strong>지도 검색</strong> </span>
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
														<tr style="height: auto;">
															<td><ul></ul></td>
															<td><ul></ul></td>
															<td><ul></ul></td>
															<td><ul></ul></td>
															<td><ul></ul></td>
														</tr>
													</tbody>
												</table>
											</form>
											<div class="form-group" style="width: 100%;">
												<div>
													<strong>업무 계획</strong>
												</div>
												<textarea id="scheduleinput" class="form-control" name=""
													placeholder="오늘의 일정은?" disabled></textarea>
											</div>

												<div>
													<strong>팀장 의견</strong>
												</div>
											<div class="form-group" style="width: 100%;display: inline-flex;">
												<textarea id="cheif-comment-input" class="form-control"
													placeholder="팀장의 한마디" name="" style="width: 639px;"></textarea>
												<button id="dayplan-cheif-sendbutton" class="btn btn-default"
													type="submit">
													<strong>comments</strong>
												</button>													
											</div>
											
										</div>
									</div>
								</div>
							</div>
						</c:when>
					</c:choose>
 --%>
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
									<form id="dayplanform" class="form-inline" method="#"
										action="#">
										<table id="dayplantable"
											style="width: 100%; margin: 0 auto; border-spacing: 20px; border-collapse: separate;">
											<tr>
												<td colspan="3" id="content2">
													<div class="form-group">
														<div style="display: inline-block;">
															<label for="show-day-title" style="width: 40px;">제목&nbsp;</label>
															<input id="dayplantable-title"
																class="form-control dayplanform-input" type="text"
																name="" placeholder="[필수입력 항목]"
																style="width: 459px; margin-right: 6px;" required>
														</div>
														<input type="hidden" name="id" class="dayplanform-input"
															value="노대리"> <label for="day"
															style="width: 50px;">작성일&nbsp;</label>
														<div id="date-reg-date" class="form-control" style="width: 120px;"></div>
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
															class="form-control dayplanform-input" name=""
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
														<span><strong>예상 주행거리량</strong></span> <input
															id="datetable-distance" class="form-control dayplanform-input"
															type="text" name="" placeholder="방문 지점 거리 측정하여 표시" readonly>
													</div>
												</td>
												<td>
													<div class="form-group">
														<span><strong>방문지점</strong></span> <input id="datetable-branch" data-toggle="tooltip"
															class="form-control dayplanform-input" type="text"
															name="" placeholder="지도에서 방문지점 선택시 자동 삽입" readonly>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3">
													<div>
														<span id="mapsearch"><strong>지도 검색</strong> </span>
														<ul style="display: -webkit-box;">
															<li><button id= "dateplan-searchRoutes" type="button" onclick="searchRoute()">경로탐색</button><li>
															<li><button id= "dateplan-deleteRoutes" type="button" onclick="deleteRoute()">경로삭제</button><li>
															<li><button id= "dateplan-searchPosition" type="button" >위치검색</button><li>
														</ul>
														<div id="searchPosition-modal" class="modal fade" style="z-index:10000;" role="dialog">
														  <div class="modal-dialog modal-sm">
														
														    <!-- Modal content-->
														    <div class="modal-content">
														      <div class="modal-header">
														        <button type="button" id="searchPosition-modal-close" class="close" data-dismiss="modal">&times;</button>
														        <h4 class="modal-title">위치 검색</h4>
														      </div>
														      <div class="modal-body">		
														      		<ul id="position-list">
														      		<li><strong>[업체 리스트]</strong></li>
														      		</ul>
														      		
														      </div>
														      <div class="modal-footer">
														        <label for="my-positions">업체명: </label>
														        <input id="my-positions" name="search-position">
														        <button type="button" id="searchPosition-search" class="btn btn-default" >검색</button>
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
											<strong>업무 일정</strong>		
										<textarea id="date-textarea"></textarea>									
									</div>
									<div class="panel panel-info">
										<div class="panel-heading">
											<strong>팀장 의견</strong>
										</div>
										<div class="panel-body">일 이따구로 할꺼야?</div>
									</div>
									<div class="modal-footer">
										<div class="btn-group btn-group-justified" role="group"
											style="width: 240px; float: right;">
											<div id="write-btn" class="btn-group" role="group">
												<button id="dayplan-savebutton" class="btn btn-primary"
													type="submit">
													<strong>저장하기</strong>
												</button>
											</div>
											<div id="update-btn" class="btn-group" role="group">
												<button id="dayplan-updatebutton" class="btn btn-info"
													type="submit" data-dismiss="modal">
													<strong>수정하기</strong>
												</button>
											</div>
											<div id="delete-btn" class="btn-group" role="group">
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

				<div id="side_title_02">
					<div id="side_title_03">
						<i class="fa fa-calendar" aria-hidden="true"></i> <span
							class="dayplan-date"></span>
					</div>
				</div>
				<div id="side_title_02">
					<div id="side_title_04" style="overflow:hidden;word-wrap:break-word;">	
					</div>
				</div>
			</div>
		</div>

		<div id="weekplan_main">
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
			<div id="week">
				<hr>
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
									<div class="user-info">
										<span class="userinfo-label"><strong>소속&nbsp;</strong></span>
										<div id="dept" class="well well-sm weektable-userinfo">
											  ${authUser.dept}</div>
									</div>
								</td>
								<td>
									<div class="user-info">
										<span class="userinfo-label"><strong>이름&nbsp;</strong></span>
										<div id="name" class="well well-sm weektable-userinfo">${authUser.name}</div>
									</div>
								</td>
								<td>
									<div class="user-info">
										<span class="userinfo-label"><strong>작성일&nbsp;</strong></span>
										<div id="reg-day" class="well well-sm weektable-userinfo"></div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form gorup">
										<label id="weeklabel" for="target_figure">주간 목표액</label> <input
											class="well well-sm  weekinput"
											id="target_figure" name="target_figure" type="text" readonly>
									</div>
								</td>
								<td>
									<div class="form gorup">
										<label for="week_sale">주간 매출액</label>
										<div class="well well-sm weekinput" id="week_sale"
											style="display: inline-block;">매출액(원)</div>
									</div>
								</td>
								<td>
									<div class="form gorup">
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
											name="title" type="text" placeholder="제목입력"
											autocomplete=”off” disabled>
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
									<li>
										<textarea class="form-control dayedit-content"
											id="monday-content" name="Monday" style="height: 150px"
											placeholder="업무 내용이 없습니다." disabled></textarea>
										<div class="modal fade" role="dialog" style="z-index: 1000;">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close day-content-modal" data-dismiss="modal">&times;</button>
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
										</div>
									</li>
								</ul>
							</td>
							<td class="tg-031e">
								<ul id="tuesday-container">
									<li>
										<textarea class="form-control dayedit-content"
											id="tuesday-content" name="Tuesday" style="height: 150px"
											placeholder="업무 내용이 없습니다." disabled></textarea>
										<div class="modal fade" role="dialog" style="z-index: 1000;">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close day-content-modal" data-dismiss="modal">&times;</button>
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
										</div>
									</li>
								</ul>
							</td>
							<td class="tg-031e">
								<ul id="wednesday-container">
									<li>
										<textarea class="form-control dayedit-content"
											id="wednesday-content" name="Wednesday" style="height: 150px"
											placeholder="업무 내용이 없습니다." disabled></textarea>
										<div class="modal fade" role="dialog" style="z-index: 1000;">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close day-content-modal" data-dismiss="modal">&times;</button>
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
										</div>
									</li>
								</ul>
							</td>
							<td class="tg-031e">
								<ul id="thursday-container">
									<li>
										<textarea class="form-control dayedit-content"
											id="thursday-content" name="Thursday" style="height: 150px"
											placeholder="업무 내용이 없습니다." disabled></textarea>
										<div class="modal fade" role="dialog" style="z-index: 1000;">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close day-content-modal" data-dismiss="modal">&times;</button>
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
										</div>
									</li>
								</ul>
							</td>
							<td class="tg-031e">
								<ul id="friday-container">
									<li>
										<textarea class="form-control dayedit-content"
											id="friday-content" name="Friday" style="height: 150px"
											placeholder="업무 내용이 없습니다." disabled></textarea>
										<div class="modal fade" role="dialog" style="z-index: 1000;">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close day-content-modal" data-dismiss="modal">&times;</button>
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
										</div>
									</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		</main>
	</div>
</body>
</html>