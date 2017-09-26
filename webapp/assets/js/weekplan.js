
	var date = new Date(); 
	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
	var d = date.getDate();
	var m = date.getMonth() + 1;
	var y = date.getFullYear();
	var dl= date.getDay();
	var todayLabel = week[dl];
	var today = y + "-" + m + "-" + d;  //moment(,"YYYY-MM-DD");
	var Month = y +"-" +m;
	var calendatyear;	
	var calendatmonth;
	var calendatday;
	var calMonth;
	
	var targetdate = today; 

	var weeklist;
	var totaltargetmoney;
	var weektargetmoney;
	var weekno;
	var thisweekdate;
	var changecheck = false;
	
	function onlyNumber(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	
	function addThousandSeparatorCommas(num) {
		 if ( typeof num == "undefined" || num == null || num == "" ) {
		        return "";
		 }
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	function removeComma(n) {  // 콤마제거
	    if ( typeof n == "undefined" || n == null || n == "" ) {
	        return "";
	    }
	    var txtNumber = '' + n;
	    return txtNumber.replace(/(,)/g, "");
	}
	
	
	function splitlist(todo){
		$.trim(todo)
	}
	
	function comparedate(){
		$("#search").click(function(){
	         
	        var startDate = $( "input[name='startDate']" ).val();
	        var startDateArr = startDate.split('-');
	         
	        var endDate = $( "input[name='endDate']" ).val();
	        var endDateArr = endDate.split('-');
	                 
	        var startDateCompare = new Date(startDateArr[0], startDateArr[1], startDateArr[2]);
	        var endDateCompare = new Date(endDateArr[0], endDateArr[1], endDateArr[2]);
	         
	        if(startDateCompare.getTime() > endDateCompare.getTime()) {
	             
	            alert("시작날짜와 종료날짜를 확인해 주세요.");
	             
	            return;
	        }
	         
	        $("#frmSearch").submit();
	});
	}

	 $('.fc-prev-button').click(function() {
		var moment = $('#calendar').fullCalendar('getDate');
		calmonth = moment.format('YYYY-MM-DD');
		targetdate  =  calmonth;
		console.log("이전버튼 클릭 날짜:" +calmonth);
	});
	
	$('.fc-next-button').click(function() {
		var moment = $('#calendar').fullCalendar('getDate');
		console.log(moment)
		var calmonth = moment.format('YYYY-MM-DD');
		targetdate  =  calmonth;
		console.log("다음버튼 클릭 날짜:" + calmonth);
	});
	
	//moment('2016-06','YYYY-MM').diff('2015-01','month');     //17 시간차
	$(document).ready(function() {			
				$('#calendar').fullCalendar(
						{
							defaultDate : targetdate,
							lang : "ko",
							selectable : true,
 							weekends : false,
 						    eventLimit : true, // allow "more" link when too many events
							events : function(start, end, timezone, callback) {
	
								console.log("캘린더 날짜: " + getDate);
								console.log("캘린더 이전날짜: " + targetdate);
		                          $.ajax({
		                              url: '/sfa/week/select',
		                              type:'GET',
		                              dataType: 'json',
		                              success: function(doc) {
		                                  
		                                  $(doc.data).each(function(index) {  
		                                	  var templist;
 											  var tempdate;
				                        	
		                                		  if(doc.data[index].content !== null ){
		                                			  if(doc.data[index].content !== ""){
			                                		  templist = doc.data[index].content.split("\n");
			                                		  tempdate = doc.data[index].date;
			                                		  
			                                		  for(i =0; i < templist.length; i++){  
			                                			  //console.log(templist[i]);
			                                			  if(templist[i] !== ""){
				                                			  events.push({
						                                          title: templist[i],
						                                          start: tempdate // will be parsed
						                                      });
			                                			  }
					                                	}
		                                			  }
		                                		  }
		                                  });
		                          
		                                  callback(events);
		                              }
		                          });
		                      },
		                     
		                      
							dayClick : function(date, jsEvent, view) {								
								var date = date.format('YYYY-MM-DD');
								console.log(date);						
								 
								$.ajax({
									url : "/sfa/week/select",
									type:'POST',
									data : "date="+date,  //2017-08-26
									dataType : "json",
									success : function(response){
										console.log(response.data)
										
										//제목 넣기
										weekno = response.data.week_no;
										
										
										//modal-list, textarea 초기화
										$(".dayedit-content").val("");
										$(".to-do-list").children().remove();	// 현재 모달에 입력된 값 다 날리고
											
										//주간테이블  textarea에 들어갈 데이터 체크 후 배열에 담는다. 앞에 공백이 있으면 제거 해주고 넣어야 함.
										weeklist =[ $.trim(response.data.monday), $.trim(response.data.tuesday),
											$.trim(response.data.wednesday),$.trim(response.data.thursday),$.trim(response.data.friday)]
										
										weektargetmoney =[new Number(response.data.monday_money),new Number(response.data.tuesday_money),new Number(response.data.wednesday_money),new Number(response.data.thursday_money),new Number(response.data.friday_money)];
										console.log(weektargetmoney);
										
										
										//주간 테이블 작성일 넣기
										if ( typeof response.data.reg_date == "undefined" || response.data.reg_date == null || response.data.reg_date == "" ) {
											$("#reg-day").text(today);
										}
										else{
											$("#reg-day").text(response.data.reg_date);
										}
										
										//주간 테이블 주간 목표액 넣기
										$("#target_figure").attr("type","text");
										totaltargetmoney = addThousandSeparatorCommas(response.data.target_figure);
										$('#target_figure').val(totaltargetmoney);
										
										//주간 테이블 주간 매출액 넣기
										 ( typeof response.data.week_sale == "undefined" || response.data.week_sale == null || response.data.week_sale == "" ) ?  $('#week_sale').text("매출액이 없습니다.") : $('#week_sale').text(addThousandSeparatorCommas(response.data.week_sale));
										
										//주간 테이블 주간 달성율 넣기
										 ( typeof response.data.achive_rank == "undefined" || response.data.achive_rank == null || response.data.achive_rank == "" ) ?  $('#achive_rank').text("%")  : $('#achive_rank').text(response.data.achive_rank + "%");
										
										//주간 테이블 제목 넣기
										 (typeof response.data.week_no == "undefined" || response.data.week_no == null || response.data.week_no == "" ) ? $("#weektabletitle").val("") :$("#weektabletitle").val("[ 주간계획 ] " + response.data.week_no.substring(4, 6) +"월 " + response.data.week_no.substring(7, 8) +" 주차");
										
										$('.weekmoney > div > input').each(function(index){											
											 if( typeof  weektargetmoney[index] == "undefined" || weektargetmoney[index] == null ||  weektargetmoney[index] == 0 ||weektargetmoney[index] == "") {
												 $(this).val(0);
											    }
																						
												$(this).val(weektargetmoney[index]);
										});
										
										
										
										//주간테이블에 요일 마다 list 넣기.
										$('.tg-031e > ul > li > textarea').each(function(index){
											if(weeklist[index] !== "null"){
												$(this).val(weeklist[index]);
											}
											else{
												$(this).attr('placeholder',"업무 내용이 없습니다.");
											}
										});
										
										//주간 테이블에요일마다 날짜 넣기
										thisweekdate=[response.data.monday_date,response.data.tuesday_date,response.data.wednesday_date,response.data.thursday_date,response.data.friday_date]
										//console.log("요일날짜" + thisweekdate);//확인
										
										
										$('.tg-e3zv > span').each(function(index){
											var tmpDate = thisweekdate[index].split("-"); // 날짜 "-" 기준으로 짜르기
											$(this).text(tmpDate[1] + "-" + tmpDate[2]); //월-일만 표기
										});
										
										$("input").attr("readonly",false);
										$("textarea").attr("disabled",false);
										$("#target_figure").attr("readonly",true);
										
										
										$("#insertDB_button").removeAttr("disabled");

										changecheck ^= changecheck;  //날짜를 클릭하면 변화플래그로 변화를 체크하여 textarea를 바꿔 준다. 
										
											 
									},
									error : function(xhr, status, error) {
						                 alert(xhr+" 와 "+ status + " 와 "+error);
						           }
								});
								//일일 계획서 가져오기(09-05 수정부분)
								$.ajax({
									url : "/sfa/date/select",
									type:'POST',
									data : "date="+date,  //2017-08-26
									dataType : "json",
									success : function(response){
										console.log(response);
										$("#reg-day").text(date);
										if(response.data.content==null)
										{
											$("#date_list").text("계획이 없습니다.");
										}
										$("#date_list").text(response.data.content);
									},
									error : function(xhr, status, error) {
						                 alert(xhr+" 와 "+ status + " 와 "+error);
						           }
								});
								//(09-05 수정부분)
							},
							
							eventMouseover : function(event, jsEvent, view){
								 var tooltip = '<div class="tooltipevent" style="width:auto;height:auto;border-style:outset;background:#ccc;position:absolute;z-index:10001;">' + event.title + '</div>';
								    var $tooltip = $(tooltip).appendTo('body');

								    $(this).mouseover(function(e) {
								        $(this).css('z-index', 100);
								        $tooltip.fadeIn('500');
								        $tooltip.fadeTo('10', 1.9);
								    }).mousemove(function(e) {
								        $tooltip.css('top', e.pageY + 10);
								        $tooltip.css('left', e.pageX + 20);
								    });
								
								
								//console.log(view._props.currentEvents[0].title);
								//alert(view.currentEvents[0]);
								//$("view").tooltip(event.title);
							},
							eventMouseout : function( event, jsEvent, view ) { 
								 $(this).css('z-index', 10);
								    $('.tooltipevent').remove();
							}
							
						});

				
				$(".target-money").change(function(event){
					totaltargetmoney = Number($("#monday_money").val()) + Number($("#tuesday_money").val()) + Number($("#wednesday_money").val()) + Number($("#thursday_money").val()) + Number($("#friday_money").val());   
					$("#target_figure").val(addThousandSeparatorCommas(totaltargetmoney));
					
				});
				
			
				//textarea focus됬을 때 
				$(".dayedit-content").focus(function(){
					var splitlist;
					
					if(changecheck == false){
					$(".to-do-list").each(function(index){
						console.log(index + "요일 입력" );
						console.log(splitlist);
						splitlist = weeklist[index].split("\n");
						for(i=0; i < splitlist.length; i++){
							var item = '<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>';
							$(this).append(item);
						}
						for(i=0; i < splitlist.length; i++){
							$(this).children("li").eq(i).children(".modallist-todo-input").val(splitlist[i]);
						}
					});
				} 
					changecheck = true;
					$(this).next().attr("class","modal show");	
					$(this).blur();
				 });
			
				$(".close").on("click",function(){
					
							
						$(this).parent().next().children(".to-do-list").children().remove();
						
						var dayeditcontent = $(this).parents("li").children(".dayedit-content").val();
						 var trimdata = $.trim(dayeditcontent);
						 
						 var remakesplitlist = trimdata.split("\n");
						//console.log(remakesplitlist);
						
						
						for(i=0; i < remakesplitlist.length; i++){
							var item = '<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>';
							$(this).parent().next().children(".to-do-list").append( item );
						}
						
						
						//console.log(remakesplitlist.length);
						for(i=0; i < remakesplitlist.length; i++){
							$(this).parent().next().children(".to-do-list").children("li").eq(i).children(".modallist-todo-input").val(remakesplitlist[i]);
						} 
						
					
				 	$(".modal").attr("class","modal fade");
				});
				
				
				//주간 계획 modal input 추가 
				$(".modal-add-button").on("click",function(){
 						$(this).parent().nextAll("ol").append('<li><input class="form-control modallist-todo-input" type="text"><button class="removevbtn" type="button">삭제</button></li><br>');
 						
				});
				
				//리스트 한개씩 지우기
				$(document).on("click",".removevbtn",function(){ 
						//console.log(this);
						$(this).parent().next().remove();
						$(this).parent().remove();
					});
 
				//주간 계획 modal 저장 
				$(".modal-save-button").click(function(){
					var plan="";
					var emptycheck= true;
					$(this).parent().prev().find("input").each(function( index, item ){
						if($(this).val() == ""){
							alert("비어있는 칸이 존재 합니다.칸을 없애시거나 채워주세요.");
							$(this).focus();
							emptycheck = false;
						}
						plan += $(this).val() + "\n";
					});
					
					if(emptycheck == true){
						$(".modal").attr("class","modal fade");
						$(this).parents("ul").children("li").children("textarea").val(plan);
						//console.log($(this).parent().next().children().next().children());
					}
				});
			
				$(side_drop_button02).click(function(){
					$("#dayplanmodal").attr("class","modal show");
					$('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴 
					$('#element').on('scroll touchmove mousewheel', function(event) { // 터치무브와 마우스휠 스크롤 방지     
						event.preventDefault();     
						event.stopPropagation();     
						return false; });
				});
				
				$("#dayplanmodalclose").click(function(){
					$('html, body').css({'overflow': 'auto', 'height': '100%'}); //scroll hidden 해제 
					$('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
				});
				
				
				$("#insertDB_button").on("click", function(){
					var form = document.getElementById("weekform");
					
					// 첫째날 담아 보내기
					$("#first_date").val(thisweekdate[0]);
					//console.log(thisweekdate[0].data);
					alert(thisweekdate[0]);
					// , 빼고 보내기
					$("#target_figure").attr("type","Number");
					$("#target_figure").val(new Number(removeComma(totaltargetmoney)));
					alert(typeof($("#target_figure").val()));
					alert($("#monday_money").val());
					alert(typeof $("#monday_money").val());
										
					if(weekno != null){
						//action 설정 및 submit
						form.action = "update";  // action에 해당하는 jsp 경로를 넣어주세요.
						form.submit();
					}
					else{
						form.action = "insert";  // action에 해당하는 jsp 경로를 넣어주세요.
						form.submit();
					}
				})
				
				//달력에 dayclick 이벤트가 발생하기전 주간 테이블 작성일

				$("#reg-day").text(today);
				
				
				   
				
 				
				
			});
