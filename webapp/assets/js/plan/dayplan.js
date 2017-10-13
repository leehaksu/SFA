//일일 계획서 모달 show() 및 css
   	function dayplanmodalShow(){
		$("#dayplanmodal").attr("class","modal show");
		$('html, body').css({
			'overflow' : 'hidden',
			'height' : '100%'
		}); // 모달팝업 중 html,body의 scroll을 hidden시킴 
		$('#element').on('scroll touchmove mousewheel',function(event) { // 터치무브와 마우스휠 스크롤 방지     
			event.preventDefault();
			event.stopPropagation();
			return false;
		}); 
 	}
   	
  //자동완성
	function positionsAutocomplete(){
   	$("#my-positions").autocomplete({
   		source: positions
   	});
	}
	
	function initEditor(){
		$('#date-textarea').froalaEditor(
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
	
	//일일 계획서의 모든 입력 block
	function blockdayplan(){
		$("#dayplantable-title").attr('disabled',true);
		$("#challenge").attr('disabled',true);
		$("#dateplan-searchRoutes").attr('disabled',true);
		$("#dateplan-deleteRoutes").attr('disabled',true);
		$("#dateplan-searchPosition").attr('disabled',true);
		$("#write-btn").hide();
		$("#update-btn").hide();
		$("#delete-btn").hide();
	}
	
	//달력 클릭시 일일계획서 데이터  ajax
	function changedayplan(dayClick,id,plandatecheck){
		$.ajax({
			url : "/sfa/date/select",
			type : 'POST',
			data : "date="+ dayClick +"id=" +id, //2017-09-08
			dataType : "json",
			success : function(response) {
					console.log(response.data);
				
					//금일 일일 계획서 내용 초기화
					$("#side-dayplan-content").empty();
					
					////금일 일일 계획서 내용 존재 여부 확인
					if(response.data == null){
							//alert("작성된 일일 계획서가 없습니다.");
							$("#side-dayplan-content").text("입력된 계획이 없습니다.");
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
								blockdayplan();
							}
							
							return ;
						}
					else{
							var tempcontent = response.data.content.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
							console.log();
							$("#side-dayplan-content").html();
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
	}
	
	function getCustomerPosition(){
		$.post("/sfa/customer/position",
	        	function(data,status){
	            console.log(data);
	            console.log(status);
	            
	        });
	}
	function resetmap(){
		$("#map_div").remove();
		$("#map_content").append("<div id='map_div'></div>");
	}
	function dayplanModalClose(){
		$("#dayplanmodalclose").on("click",function() {
			resetmap();
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
	}
	function dayplanModalSearchPositionClose(){
		$("#searchPosition-modal-close").on("click", function() {
			$("#searchPosition-modal").attr("class","modal fade");
		});
	}
	function dayplanModalSearchPosition(client_map_info){
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
	}
	function dayplanModalSave(){
		$("#dayplan-savebutton").click(function(){
			//지도 삭제 후 다시 생성
			resetmap();
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
	}
	
	function dayplanModalUpdate(){
		$("#dayplan-updatebutton").click(function(){
			//지도 삭제후 재생성
			resetmap();
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
	}
	
	function dayplanModalDelete(){
		$("#dayplan-deletebutton").click(function(){
			//지도 삭제후 재생성
			resetmap();
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
	}
	
	function dayplanModalSearchPositionOpen(){
		$("#dateplan-searchPosition").click(function(){
			
			$('#searchPosition-modal').attr("class","modal show");
		});
	}
	
	