function findID(){
	$.post("pwd/reset",
			{"id":id},
	function(data,status){
		 console.log(data);
   	}).done(function() {
	    $("#passwordReset-image").show();
	  })
	  .fail(function() {
	    alert( "초기화 실패" );
	  });

}
