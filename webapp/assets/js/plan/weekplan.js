//ajax 통신후 response data를 담는 변수들.
var weeklist;
var weektotaltargetmoney;
var weektargetmoney;
var weekno;
var thisweekdate;

//dayplantable에 클릭한 날짜의 목표액을 주간테이블에서 가져오기 위한 변수
var goalmoneyindex;


/*
 * 
 */
function ajaxChallenge(){
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
}

function getWeeks(current,callback){
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
}

function changeweekplan(dayClick,changeID){
	//주간계획
	$.ajax({
				url : "/sfa/week/select",
				type : 'POST',
				data : "date="+ dayClick+"id="+changeID, //2017-08-26
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
}

function setTargetmoney(){
	$(".target-money").change(function(event) {
		weektotaltargetmoney = Number($("#monday_money").val())
				+ Number($("#tuesday_money").val())
				+ Number($("#wednesday_money").val())
				+ Number($("#thursday_money").val())
				+ Number($("#friday_money").val());
		$("#target_figure").val(addThousandSeparatorCommas(weektotaltargetmoney));
	});
}

function weekplanTextareaFocus(){
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
}

function weekplanDayContentModalClose(){
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

}
function weekplanDayContentAdd(){
	$(".modal-add-button").on("click",function() {
		$(this).parent()
				.nextAll("ol")
				.append('<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>');
	});
}

function weekplanDayContentRemove(){
	$(document).on("click", ".removevbtn", function() {
		//console.log(this);
		$(this).parent().next().remove();
		$(this).parent().remove();
	});
}

function weekplanDayContentSave(){
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

}

function weekplanSaveButtonClick(){
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
}

function weekplanResetButton(){
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
}