
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
	var default_latitude ="37.49349134";
	var default_longitude="127.02785193" ;
	
	//경로 position 정보를 ajax로 받기 위한 변수 
	var route;
	
    
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

	function getLocation() {
		console.log("1번째 실행");
        if (navigator.geolocation) {        
              navigator.geolocation.getCurrentPosition(showPosition,showError);
        } else { 
          	alert("위치 기반 서비스를 지원하지 않는 브라우저 입니다.")
          	
        }
    }

     function showPosition(position) {
    	 console.log("2번째 실행");
    	current_latitude = position.coords.latitude; 
    	current_longitude= position.coords.longitude;
    	
    	//map 생성
		init(); 
    } 
     function showError(error) {
    	 	init();
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
        if(typeof current_longitude == "undefined" || current_longitude == null || current_longitude == ""){
        	cLonLat = new Tmap.LonLat(default_longitude,default_latitude).transform(pr_4326,pr_3857);  
        }else{
        	cLonLat = new Tmap.LonLat(current_longitude,current_latitude).transform(pr_4326,pr_3857);     	
        }
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
    		alert("경로에 이미 존재하는 경유지 입니다.");
    		return ;// modal로 확인 취소를 통해 넣을 것인지 말것인지 선택하게 만든다. 
        }
    	var tempLonLat = new Tmap.LonLat(this.lonlat.lon,this.lonlat.lat).transform(pr_3857,pr_4326);
    	 
    	//주차장 리스트 초기화
    	$("#parkinglotlist").empty();
    
    	//지점이름으로 POI 검색
    	getPOIbylabel(this.labelHtml);
    	
  		 //클릭한 순서대로 지점 이름이 배열에 삽입된다.
  		routeNames.push(this.labelHtml);
  		//클릭한 순서대로 지점 좌표가 배열에 삽입된다.		
      	routeList.push(tempLonLat);
      	//routeList.push(new Tmap.Geometry.Point(this.lonlat.lon,this.lonlat.lat));
      	
      	initRoutelist();
	} 

function init() {	
	 	console.log("3번째 실행");
      	setVariables();
        map = new Tmap.Map({div:'map_div', width:mapW, height:mapH, animation:true}); 
    	map.setCenter(cLonLat,zoom);
        
        markerLayer = new Tmap.Layer.Markers( "MarkerLayer" );
        map.addLayer(markerLayer);
        var currentlabel =  new Tmap.Label("현재 위치");
        var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset); 
        var starticon = new Tmap.Icon("https://www.google.co.kr/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwifm7CVw4jXAhVGH5QKHZ_QAo4QjRwIBw&url=http%3A%2F%2Fm.blog.daum.net%2Fdodoad1004%2F15&psig=AOvVaw2sQYJUf8K044u1CVX922or&ust=1508909220106498", size, offset); 
        
        //console.log("현재위치에 마크");
        var currentmarker = new Tmap.Markers(cLonLat, starticon, currentlabel);		        
        markerLayer.addMarker(currentmarker);	
    	$.ajax({
			url : '/sfa/customer/position/',
			type : 'POST',
			dataType : 'json',
			contentType: "application/json; charset=UTF-8",
			success : function(response) {
				console.log(response.data);
				
				for(i=0; i < response.data.length; i++){
					var mapinfo =new Object();					
					mapinfo.id = response.data[i].id; 
 					mapinfo.customerCode = response.data[i].customer_code;
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
				alert("죄송합니다 다시 시도해 주세요.");
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
 

 function drawRoute(route,routeFormat,map){
	 if(route != null){
	    var prtcl = new Tmap.Protocol.HTTP({
            url: route,
            format:routeFormat
            });
	    routeLayer = new Tmap.Layer.Vector("route", {protocol:prtcl, strategies:[new Tmap.Strategy.Fixed()]});
	routeLayer.events.register("featuresadded", routeLayer, onDrawnFeatures);
	map.addLayer(routeLayer);
	 }
	 else{
		 //alert("기존 경로를 부를 수 없습니다.");
	 }	 
 }
 
 function initRoutelist(){
	    routes =""; 
	 	for(i=0; i < routeNames.length; i++){
			 		routes += routeNames[i] +"->";		
	 		}
				routes = routes.substring(0,routes.length-2);
				$("#datetable-branch").val(routes);
	 		$("#datetable-branch").attr("title",routes);	    			    		
	 		$('#datetable-branch').tooltip(); 
 }
 
 function searchRoute(){
 	//클릭한 list의 좌표 업체 별로 passList에 넣어 줄것. 문자열로! 끝은 G,0으로 통일할 것이며, 최대 5개의 경유지만 가능
 	//그러므로 route list의 length가 5개 이상이면 검색이 불가능 하거나 5개 까지만 검색이 되게 해야함.
 	//그리고 5개 까지만 검색이 가능함을 사전에 미리 알려줘야한다.
	 
	 var routevalue = $("#dayplan-route").val();
	/*//ajax 변수로 날라갈 route 데이터를 담고 있는 input의 value 초기화
	 $("#dayplan-route").removeAttr("value");
	*/
	 //alert(routevalue);
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
     } else if(routeList.length > 5){
    	 alert("경유지는 최대 5곳 까지만 가능합니다.");
     }
     
     console.log(passList.substring(0,passList.length-1));
    /*  동작대리점 / 1582792 / 37.50418360 / 126.97535640 / 4
     용산대리점 / 280110 / 37.53093031 /126.96491216 / 16	
     양천대리점 / 4298932 / 37.54834317 /126.86525408 / 16 */
     route = "https://apis.skplanetx.com/tmap/routes?version=1&format=xml";
     route += "&startX="+startX;
     route += "&startY="+startY;
     route += "&endX="+endX;
     route += "&endY="+endY;
     route += "&reqCoordType=WGS84GEO"
     route += "&passList="+passList;
     route += "&appKey=2a1b06af-e11d-3276-9d0e-41cb5ccc4d6b"; 

     console.log(route);
   
     drawRoute(route,routeFormat,map);
 
     
     
      var road ="startX="+startX+"&startY="+startY+"&endX="+endX+"&endY="+endY+"&reqCoordType=WGS84GEO"+"&passList="+passList; 	 
   	
    	$.ajax({
   		method : "POST",
   		    url : "https://apis.skplanetx.com/tmap/routes?version=1",
   		    data: road,
   		    headers : {
   		        "Content-Type" : "application/x-www-form-urlencoded",
   		        "appKey" : "2a1b06af-e11d-3276-9d0e-41cb5ccc4d6b"
   		    },
   		    success: function( data, textStatus, jQxhr ){
   		    	//console.log(data.features[0].properties.totalDistance/1000);
   		    	//console.log(typeof data.features[0].properties.totalDistance);
   		    	$("#datetable-distance").val(Math.floor(data.features[0].properties.totalDistance/1000));
   		    	$("#dayplan-route").attr("value",route);
   		    },
              error: function( jqXhr, status, errorThroxwn ){
             	 console.log(jqXhr);
                  console.log( errorThroxwn + "," + status);
                  alert("오류 발생!! 다시 시도해 주세요.");
              }

   		});

    	initRoutelist();
 	}
 	else{
 		if(routecheck == true || routevalue != null && routevalue.length != 0 ){
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

 function getparkinglot(keyword){

	 $.ajax({
		 method : "GET",
		 url : "http://openapi.seoul.go.kr:8088/756543787173687234324f53656a72/json/GetParkInfo/1/5/"+keyword,
		 success: function( data, textStatus, jQxhr ){
			 console.log(data);
			 console.log(data.GetParkInfo);
			 console.log(data.GetParkInfo.list_total_count);
			 console.log(data.GetParkInfo.row[0]);			 
			 console.log(data.GetParkInfo.row[0].PARKING_NAME);			 
			 
			 for(i=0; i<data.GetParkInfo.list_total_count;i++){				 
				 $("#parkinglotlist").append(
							"<tr>" +
							"<td><ul>"+data.GetParkInfo.row[i].PARKING_NAME+"</ul></td>" +
							"<td><ul>"+data.GetParkInfo.row[i].CAPACITY+"</ul></td>" +
							"<td><ul>"+ data.GetParkInfo.row[i].RATES +"</ul></td>" +
							"<td><ul>"+ data.GetParkInfo.row[i].TIME_RATE +"</ul></td>" +
							"</tr>");
					
			 }		 
		 },
		  error: function( jqXhr, status, errorThroxwn ){
          	 console.log(jqXhr);
               console.log( errorThroxwn + "," + status);
               alert("오류 발생!! 다시 시도해 주세요.");
           }
	 })
 }
 
 

 function getPOIbylabel(keyword){
	 alert(keyword);
	 var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset);     
	 $.ajax({
	   		method : "GET",
	   		    url : "https://apis.skplanetx.com/tmap/pois?version=1&searchKeyword="+keyword,
	   		    headers : {
	   		        "Content-Type" : "application/x-www-form-urlencoded",
	   		        "appKey" : "2a1b06af-e11d-3276-9d0e-41cb5ccc4d6b"
	   		    },
	   		    success: function( data, textStatus, jQxhr ){	   				        	
		        	console.log();
	   		    	getparkinglot(data.searchPoiInfo.pois.poi[0].lowerAddrName);
	   		    	
   		    },
	              error: function( jqXhr, status, errorThroxwn ){
	             	 console.log(jqXhr);
	                  console.log( errorThroxwn + "," + status);
	                  alert("오류 발생!! 다시 시도해 주세요.");
	              }
	   		});
 }
 
 function getPOI(){
	 var keyword = $("#searchPOI").val();
	 var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset);     
	 var cLonLat;
	 $.ajax({
	   		method : "GET",
	   		    url : "https://apis.skplanetx.com/tmap/pois?version=1&searchKeyword="+keyword,
	   		    headers : {
	   		        "Content-Type" : "application/x-www-form-urlencoded",
	   		        "appKey" : "2a1b06af-e11d-3276-9d0e-41cb5ccc4d6b"
	   		    },
	   		    success: function( data, textStatus, jQxhr ){
	   		 	var name= data.searchPoiInfo.pois.poi[0].name;
	        	var tel= data.searchPoiInfo.pois.poi[0].telNo.split("-");
	        	var address = data.searchPoiInfo.pois.poi[0].upperAddrName +" "+data.searchPoiInfo.pois.poi[0].middleAddrName+" "+data.searchPoiInfo.pois.poi[0].lowerAddrName;
	            	console.log(data);
	   		    	console.log(data.searchPoiInfo.pois.poi[0].frontLat+","+data.searchPoiInfo.pois.poi[0].frontLon);
	   		    	cLonLat = new Tmap.LonLat(data.searchPoiInfo.pois.poi[0].frontLon,data.searchPoiInfo.pois.poi[0].frontLat);
	   		    	map.setCenter(cLonLat,zoom);
	   		    	var markerLayer = new Tmap.Layer.Markers();
	   		    	map.addLayer(markerLayer);
   		    		var cLonLat = new Tmap.LonLat(data.searchPoiInfo.pois.poi[0].frontLon,data.searchPoiInfo.pois.poi[0].frontLat);
   		    		var label = new Tmap.Label(data.searchPoiInfo.pois.poi[0].name);
   		    		var tempmarker = new Tmap.Markers(cLonLat, icon, label);	
   		    		
   		    		
   		    		tempmarker.events.register("click", tempmarker, onclickmarkerselect(name,tel,address));
		        	markerLayer.addMarker(tempmarker);		
		        	
		        	var popup;
		        	popup = new Tmap.Popup("p1",
		        							cLonLat,
		        	                        new Tmap.Size(200, 100),
		        	                        data.searchPoiInfo.pois.poi[0].name +"<br>"+
		        	                        "주소지:" + data.searchPoiInfo.pois.poi[0].upperAddrName +" "+data.searchPoiInfo.pois.poi[0].middleAddrName+" "+data.searchPoiInfo.pois.poi[0].lowerAddrName+
		        	                        "<br>"+"전화번호:"+data.searchPoiInfo.pois.poi[0].telNo+"<br>"
		        	                        ); 
		        	map.addPopup(popup);
		        	popup.hide();
		        
		        	/*addcustomerinfo(name,tel,address);
		        	*/
		        	tempmarker.events.register("mouseover", popup, onOverMarker);
		        	tempmarker.events.register("mouseout", popup, onOutMarker);
		        	function onOverMarker (evt){
		        	    this.show();
		        	}
		        	
		        	getparkinglot(data.searchPoiInfo.pois.poi[0].lowerAddrName);
   		    },
	              error: function( jqXhr, status, errorThroxwn ){
	             	 console.log(jqXhr);
	                  console.log( errorThroxwn + "," + status);
	                  alert("오류 발생!! 다시 시도해 주세요.");
	              }
	   		});
 }
 
 function addcustomerinfo(name,tel,address){
	 $("#customername").val(name);
	 $("#contact1").val(tel[0]);
 	$("#contact2").val(tel[1]);
 	$("#contact3").val(tel[2]);
	$("#customer-address-input").val(address);
 }
 function onOutMarker (evt){
	    this.hide();
 }

 function onclickmarkerselect(name,tel,address){
	 addcustomerinfo(name,tel,address);
	 $("#search_customer_map").modal("hide");

 }
 
 
 function deleteRoute(){
	
	 var routevalue = $("#dayplan-route").val();
	 //ajax 변수로 날라갈 route 데이터를 담고 있는 input의 value 초기화
	 $("#dayplan-route").removeAttr("value");
	
 	if((vector_layer != null || routeList.length >0) && routecheck == true){
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
 		if(routevalue != "" || routevalue != null && routevalue.length != 0 ){
 			map.removeLayer(routeLayer);	 		
 		}else{
 		alert("선택된 경로가 없거나 잘못된 경로입니다.");
 		}
 	}
 	
 	
 }
 