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
	src="${pageContext.servletContext.contextPath}/assets/js/util/util.js"></script>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/plan/calendar.js"></script>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/plan/weekplan.js"></script>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/map/map.js"></script>
	<script
	src="${pageContext.servletContext.contextPath}/assets/js/plan/dayplan.js"></script>	
<script>
	var date = new Date();
	var today = moment().format("YYYY-MM-DD");

	var testnumber = moment('2010-10-20').isBefore('2010-10-21');
	//moment('2017-09-05','YYYY-MM-DD').diff('2017-09-04','day');

	//달력에서 클릭 한 날짜를 담는 변수
	var dayClick;
	var current;// ajax를 위해 변화하는 달 정보담는 변수	

	// ajax 통신후 response dat를 담는 변수들.
	var weeklist;
	var totaltargetmoney;
	var weektargetmoney;
	var weekno;
	var thisweekdate;

	//입력 체크 변수
	var changecheck = false;

	// dayplantable에 클릭한 날짜의 목표액을 주간테이블에서 가져오기 위한 변수
	var goalmoneyindex;

	
	
	//tmap 변수
	var map;
    var mapW, mapH;     // 지도의 가로, 세로 크기(Pixel단위) 를 지정 합니다. 
    var cLonLat, zoom;      //중심 좌표와 지도레벨을 정의 합니다. 
    var pr_3857 = new Tmap.Projection("EPSG:3857"); //Tmap default
    var pr_4326 = new Tmap.Projection("EPSG:4326"); // wgs84

    var client_map_info = []; // 마커들을 관할하는 변수
    
    var size = new Tmap.Size(24,38);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	    
    
    //현재 위치를 담기 위한 변수
	var current_latitude;
	var current_longitude;
   
	//마커을 그리는 layer변수 
	var markerLayer;
	
	//그림을 그리는 layer변수 
	var vector_layer = new Tmap.Layer.Vector(
  			  'Vector_Layer',
  			  {renderers: ['SVG', 'Canvas', 'VML']}
   		);
	//경로를 그리는 layer 변수
	var routeLayer;
	//이동 할 경로를 담는 변수 
 	var routeList = [];
	
 	//이동 할 경로의 이름을 담는 변수 
 	var routeNames = [];
 	
 	// 전체 경로 저장 변수
 	var routes;
 	
 	//일일 계획서 일일 목표액 저장 변수 
 	var dateGoalMoney;
 	
 	var positions=[];
 	
	var routecheck=false;
	
 	//좌표 배열 객체화
 	var lineString;
	var mLineFeature;
 	//라인의 css 설정
	var style_red = {
                   fillColor:"#FF0000",
                   fillOpacity:0.2,
                   strokeColor: "#FF0000",
                   strokeWidth: 1,
                   strokeDashstyle: "solid",
                   label:"500m",
                   labelAlign: "lm",
                   fontColor: "black",
                       fontSize: "9px",
                       fontFamily: "Courier New, monospace",
                       fontWeight: "bold",
                       labelOutlineColor: "white",
                       labelOutlineWidth: 3 
                  };
 	
	//map sample data 
	// 비트 아카데미
    //cLonLat = new Tmap.LonLat(default_longitude,default_latitude).transform(pr_4326,pr_3857)
 	
	function getLocation() {
			//console.log("1번째 실행");
        if (navigator.geolocation) {        
            navigator.geolocation.getCurrentPosition(showPosition,showError);
        } else { 
          	alert("위치 기반 서비스를 지원하지 않는 브라우저 입니다.")
        }
    }

     function showPosition(position) {
    	 //console.log("2번째 실행");
    	current_latitude = position.coords.latitude; 
    	current_longitude= position.coords.longitude;
    	
    	//map 생성
		init(); 
    } 
     function showError(error) {
    	 
    	    switch(error.code) {
    	        case error.PERMISSION_DENIED:
    	            alert("User denied the request for Geolocation.");
    	            break;
    	        case error.POSITION_UNAVAILABLE:
    	            alert("Location information is unavailable.");
    	            break;
    	        case error.TIMEOUT:
    	            alert("The request to get user location timed out.");
    	            break;
    	        case error.UNKNOWN_ERROR:
    	            alert("An unknown error occurred.");
    	            break;
    	    }
    	}
      
    function setVariables(position){   
    	//console.log("4번째 실행");
        zoom = 16;  // zoom level입니다.  0~19 레벨을 서비스 하고 있습니다. 
        mapW = '682px';  // 지도의 가로 크기 입니다. 
        mapH = '240px';  // 지도의 세로 크기 입니다. 
        cLonLat = new Tmap.LonLat(current_longitude,current_latitude).transform(pr_4326,pr_3857);
    }
    
    function onMouseMarker (evt){
        if(evt.type == "mouseover"){
            this.show();
        } else {
            this.hide();
        }
    }
    
    function onclickmarker(e){
    	//경로에 중복이 있는지 체크 
    	if($.inArray(this.labelHtml,routeNames) >= 0){
    		console.log("경로에 이미 존재하는 경유지 입니다.");
    		// modal로 확인 취소를 통해 넣을 것인지 말것인지 선택하게 만든다. 
        }
    	var tempLonLat = new Tmap.LonLat(this.lonlat.lon,this.lonlat.lat).transform(pr_3857,pr_4326);
        
  		 //클릭한 순서대로 지점 이름이 배열에 삽입된다.
  		routeNames.push(this.labelHtml);
  		//클릭한 순서대로 지점 좌표가 배열에 삽입된다.		
      	routeList.push(tempLonLat);
      	//routeList.push(new Tmap.Geometry.Point(this.lonlat.lon,this.lonlat.lat));

	}

    /* // 2개 사이의 거리 계산 
      function loadGetAddressFromLonLat(routeList){
        var tdata = new Tmap.TData();
        console.log(routeList);
        var s_lonLat = new Tmap.LonLat(routeList[0].x,routeList[0].y);
        var e_lonLat = new Tmap.LonLat(routeList[1].x,routeList[1].y);
        tdata.getRoutePlan(s_lonLat,e_lonLat);

        tdata.events.register("onComplete", tdata, onComplete);
        tdata.events.register("onProgress", tdata, onProgress);
        tdata.events.register("onError", tdata, onError);
    }
     function onComplete(){
    	  console.log(this.responseXML);
    	  console.log(jQuery(this.responseXML).find("fullAddress").text());
    	  console.log(jQuery(this.responseXML).find("totalDistance").text());
    	}
    	 
    	function onProgress(){
    	   console.log("준비중");
    	}
    	 
    	function onError(){
    	    alert("onError");
    	} 
 */    	
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
    
    function init() {	
	 	//setTimeout(function(){ alert("Hello"); }, 100000);
	 	console.log("3번째 실행");
      	setVariables();
        map = new Tmap.Map({div:'map_div', width:mapW, height:mapH, animation:true}); 
    	map.setCenter(cLonLat,zoom);
        
        markerLayer = new Tmap.Layer.Markers( "MarkerLayer" );
        map.addLayer(markerLayer);
        var currentlabel =  new Tmap.Label("현재 위치");
        var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset); 
        
        //console.log("현재위치에 마크");
        var currentmarker = new Tmap.Markers(cLonLat, icon, currentlabel);		        
        markerLayer.addMarker(currentmarker);	
    	$.ajax({
			url : '/sfa/position/',
			type : 'POST',
			dataType : 'json',
			contentType: "application/json; charset=UTF-8",
			success : function(response) {
				console.log(response.data);
				
				for(i=0; i < response.data.length; i++){
					var mapinfo =new Object();					
					mapinfo.id = response.data[i].id; 
// 					mapinfo.customerCode = response.data[i].customerCode;
					mapinfo.name = response.data[i].name;
					mapinfo.positionX = response.data[i].positionX;
					mapinfo.positionY = response.data[i].positionY;
					client_map_info.push(mapinfo);
					console.log(client_map_info[i]);
					positions.push(response.data[i].name);		
					
					//위치 검색에 업체리스트 삽입
					$("#position-list").append("<li>"+client_map_info[i].name+"</li>");
				}

		        console.log("client_map_info.length의 길이: "+client_map_info.length);
	    		    
		         for(i=0; i < client_map_info.length; i++){   
		        	var templonlat = new Tmap.LonLat(client_map_info[i].positionY,client_map_info[i].positionX).transform(pr_4326,pr_3857);
		        	var title = "지점: " + client_map_info[i].name;
		        	var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset); 		  
		  //      	console.log(templonlat +" 좌표는 " + title +"입니다.");		        	
		        	var label = new Tmap.Label(client_map_info[i].name);
		        	var tempmarker = new Tmap.Markers(templonlat, icon, label);		        
		    
		        	var popUp;
		        	popUp = new Tmap.Popup("popup",templonlat,new Tmap.Size(150, 50),title,true,function(e){
		        		this.hide();
		        	}); 
		        	tempmarker.events.register("mouseover", popUp, onMouseMarker);
		        	tempmarker.events.register("mouseout", popUp, onMouseMarker);
		        	map.addPopup(popUp);
		        	popUp.hide();
		        	tempmarker.events.register("click", tempmarker, onclickmarker);
		   			markerLayer.addMarker(tempmarker);		
		   			
		   		
		        } 		
			},
			error : function(xhr,status,error) {
				alert(xhr + " 와 " + status + " 와 " + error);
			}
			
    	});
    	   		
        /*  if(markers!=null){
			//markers.clearMarkers();
		} */
          
    }
    
 	
    
    /* // 이 함수는 픽셀의 값을 좌표 값으로 변환해주는 기능을 합니다.
    function LonLatFromPixel(){
        alert(map.getLonLatFromPixel(
            new Tmap.Pixel(document.getElementById('x').value,document.getElementById('y').value)));
    } */
    
    
    function searchRoute(){
    	//클릭한 list의 좌표 업체 별로 passList에 넣어 줄것. 문자열로! 끝은 G,0으로 통일할 것이며, 최대 5개의 경유지만 가능
    	//그러므로 route list의 length가 5개 이상이면 검색이 불가능 하거나 5개 까지만 검색이 되게 해야함.
    	//그리고 5개 까지만 검색이 가능함을 사전에 미리 알려줘야한다.
    	
    	var startX = current_longitude;
        var startY = current_latitude;
    	
    	if(routecheck == false && routeList.length > 0 && routeList.length < 6){
    	routecheck= true;
    	//console.log(templonlat.lat+","+templonlat.lon);
    	var routeFormat = new Tmap.Format.KML({extractStyles:true, extractAttributes:true});
        var endX = routeList[routeList.length-1].lon;
        var endY = routeList[routeList.length-1].lat;
        
        var passList="";
        //"126.96491216,37.53093031,280110,G,0_126.86525408,37.54834317,4298932,G,0";
        if(routeList.length>1){
	        for(i=0;i<routeList.length-1;i++){
	        	passList +=routeList[i].lon+","+routeList[i].lat+"_"; 
	      	}
        }
        console.log(passList.substring(0,passList.length-1));
       /*  동작대리점 / 1582792 / 37.50418360 / 126.97535640 / 4
        용산대리점 / 280110 / 37.53093031 /126.96491216 / 16	
        양천대리점 / 4298932 / 37.54834317 /126.86525408 / 16 */
        var urlStr = "https://apis.skplanetx.com/tmap/routes?version=1&format=xml";
        urlStr += "&startX="+startX;
        urlStr += "&startY="+startY;
        urlStr += "&endX="+endX;
        urlStr += "&endY="+endY;
        urlStr += "&reqCoordType=WGS84GEO"
        urlStr += "&passList="+passList;
        urlStr += "&appKey=2a1b06af-e11d-3276-9d0e-41cb5ccc4d6b"; 

           

         var obj = {

        		 endX: 14135428.84691669,
        		 endY: 4505733.44979528,
        		 startX: 14140669.59746090,
        		 startY: 4508640.36061872,
        		 endX: '14135428.84691669',
        		 endY: '4505733.44979528',
        		 startX: '14140669.59746090',
        		 startY: '4508640.36061872'
        		};
         var road ="startX="+startX+"&startY="+startY+"&endX="+endX+"&endY="+endY+"&reqCoordType=WGS84GEO"+"&passList="+passList; 	 
        	
         	$.ajax({
             url: "https://apis.skplanetx.com/tmap/routes?version=1&appKey=2a1b06af-e11d-3276-9d0e-41cb5ccc4d6b",
             type: 'post',
             data: road,
             contentType: "application/x-www-form-urlencoded;charset=utf-8",
             data:  "startX : "+startX+
             "startY :"+startY+
             +"endX : "+endX+
             +"endY :"+endY,
             success: function( data, textStatus, jQxhr ){
                 console.log(data);
             },
             error: function( jqXhr, status, errorThroxwn ){
            	 console.log(jqXhr);
                 console.log( errorThroxwn + "," + status);
             }
         });

      
        var prtcl = new Tmap.Protocol.HTTP({
                                            url: urlStr,
                                            format:routeFormat
                                            });
        routeLayer = new Tmap.Layer.Vector("route", {protocol:prtcl, strategies:[new Tmap.Strategy.Fixed()]});
        routeLayer.events.register("featuresadded", routeLayer, onDrawnFeatures);
        map.addLayer(routeLayer);
    
        
        routes =""; 
    	for(i=0; i < routeNames.length; i++){
   		 		routes += routeNames[i] +"->";		
    		}
			routes = routes.substring(0,routes.length-2);
			$("#datetable-branch").val(routes);
    		$("#datetable-branch").attr("title",routes);	    			    		
    		$('#datetable-branch').tooltip(); 
    	}
    	else{
    		if(routecheck == true){
    	    		alert("이미 검색된 경로가 존재 합니다.");
    	    }
    		else if(routeList.length <= 0){
    	    		alert("선택된 경로가 하나도 존재 하지 않습니다.");
    	    }
    	}
    }
    //경로 그리기 후 해당영역으로 줌
    function onDrawnFeatures(e){
        map.zoomToExtent(this.getDataExtent());
    }
    
    function complete(data){
    	console.log("진짜됨");
    	console.log(data);   	
    }
   
   /*  function searchRoute(){
    	if(routecheck == false){
	    	map.addLayers([vector_layer]);
	    	
	    	//좌표 배열 객체화
	    	 lineString = new Tmap.Geometry.LineString(routeList);
	    	 console.log("루트들");
	    	console.log(routeList);
	    	//vector feature 객체화
	    	mLineFeature = new Tmap.Feature.Vector(lineString, null, style_red);
	  
	    	//벡터 레이어에 등록
	    	vector_layer.addFeatures([mLineFeature]);
			
	    	console.log("경로탐색~");
	    	
	    	routecheck= true;
	    	var routes =""; 
	    	for(i=0; i < routeNames.length; i++){
	   		 		routes += routeNames[i] +"->";		
	    		}
    			routes = routes.substring(0,routes.length-2);
    			$("#datetable-branch").val(routes);
	    		$("#datetable-branch").attr("title",routes);	    			    		
	    		$('#datetable-branch').tooltip(); 
	    	
	    	//출발 지점과 도착지점 일때 	
	    	 if(routeList.length == 2){
	    		console.log(routeList.length);
		    	loadGetAddressFromLonLat(routeList);		
	    	} 
	    		$.ajax({
	    			url : 'https://apis.skplanetx.com/tmap/routes?version=1',
	    			type : 'POST',
	    			data : {'startX': 14140669.59746090,'startY': 4508640.36061872,'endX': 14135428.84691669,'endY':4505733.44979528},
	    			dataType : 'json',
	    			contentType: "application/json; charset=UTF-8",
	    			success : function(response) {
	    				console.log(response);
	    			},
	    			error : function(xhr,status,error) {
	    				alert(xhr + " 와 " + status + " 와 " + error);
	    			}
	        	});
    	}
    	else{
    		alert("이미 검색된 경로 결과가 존재합니다.");
    	}
    } */
    
    function deleteRoute(){
    	
    	if((vector_layer != null || routeList.lenth >1) && routecheck == true){
    		map.removeLayer(routeLayer);
    		routecheck= false;
    		routeList=[];
    		routeNames=[];
           	console.log(routeList);            
    		routes ="";
    		$("#datetable-branch").val(routes);
    		$("#datetable-branch").attr("title",routes);	    			    		
    		$('#datetable-branch').tooltip('destroy'); 
        	console.log("경로삭제~");
    	}
    	else{
    		alert("선택된 경로가 없거나 잘못된 경로입니다.");
    	}
    }
   
    
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

	function splitlist(todo) {
		$.trim(todo)
	}
	
	
	//moment('2016-06','YYYY-MM').diff('2015-01','month');     //17 시간차
	$(document).ready( function() {
		//도전과제 ajax
		ajaxChallenge();
		//텍스트 에디터 초기화
		initEditor();
		//현재위치 정보 가져오기.
			getLocation();
		//dayplan 위치 검색 자동완성
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
									//달력에 모든 주간일정 ajax
									getWeeks(current,callback);
								},
								dayClick : function(date, jsEvent,view) {
									//클릭한 날짜를  날짜 형식을 'YYYY-MM-DD'로 맞춰준다.
									dayClick = date.format('YYYY-MM-DD');	
									//현재 날짜와 클릭한 날짜 비교 
									var plandatecheck = moment(dayClick).isSameOrAfter(today);
									
									//선택한 날짜가 있는지 없는지 유무 확인
									if (dayClick != null) {
										//날짜 클릭 이벤트 일일 계획 데이터 ajax
										changedayplan(dayClick,plandatecheck);
										getCustomerPosition();
									} else {
										$("#dayplancheckmodal").modal('show');
										getCustomerPosition();
									}
									
									
									//console.log(dayClick);	
									//날짜 클릭 이벤트 주간 계획 데이터 ajax
									 changeweekplan(dayClick);
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
				//문제점! 바로 뜨면 안됨. 날짜 클릭확인!!!!이 이루어져야 한다. 캘린더의 dayclick이벤트를 수정할 것. 
				dayplanmodalShow();	
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
		<div id="sidebar-wrapper">
			<c:import url="/WEB-INF/views/include/navigator.jsp">
				<c:param name="menu" value="main" />
			</c:import>
		</div>
	</div>
		<main id="page-content-wrapper" role="main">

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
						<button id="side-dayplan-coworker-button"
							class="btn btn-default btn-sm dropdown-toggle" type="button"
							data-toggle="dropdown" aria-expanded="false">
							${authUser.name} / ${authUser.dept} &nbsp; &nbsp; &nbsp;<span
								class="caret"></span>
						</button>
						<ul id="side-dayplan-coworker_list" class="dropdown-menu" role="menu">
							
						</ul>
					</div>
				</div>
				<div id="side_insert_group">
					<button id="side-dayplan-open-button" type="button"
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

				<div id="side-dayplan2">
					<div id="side-dayplan-date">
						<i class="fa fa-calendar" aria-hidden="true"></i> <span
							class="dayplan-date"></span>
					</div>
				</div>
				<div id="side-dayplan3">
					<div id="side-dayplan-content" style="overflow:hidden;word-wrap:break-word;">	
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
						<table >
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
									<div class="form gorup" week-user-info>
										<label id="weeklabel" for="target_figure">주간 목표액</label> <input
											class="well well-sm  weekinput"
											id="target_figure" name="target_figure" type="text" readonly>
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
</body>
</html>