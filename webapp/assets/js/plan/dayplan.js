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