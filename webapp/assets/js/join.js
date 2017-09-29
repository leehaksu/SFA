	var reg_uid = /^[A-Za-z]{1}[A-Za-z0-9]{3,19}$/;
	var reg_upw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{8,24}$/;
	var reg_email=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	$(document).ready(function(){	   
		$("#confirm_button").click(function() {
			//1. 아이디가 비어있는지 체크
			if ($("#inputId").val() == "") {
				alert("아이디가 비어있습니다.");
				$("#inputId").focus();
				return false;				
			}
			//1-1 아이디 중복 확인 체크
			if(("#check-image").is(":visible" ) == false )
			{
				alert("아이디 중복확인은 필수입니다.");
				return false;
			}
			//2. 비밀번호가 비어있는지 체크   
			if ($("#inputPassword").val() == "") {
				alert("비밀번호가 비어있습니다.");
				$("#inputPassword").focus()
				return false;
			}
			//2-2 비밀번호 조건 체크 
			if (reg_upw.test($("#inputPassword").val()) != true) {
				alert("비밀번호는 숫자, 특수문자 포함 8자 이상이어야 합니다.");
				return false;
			}

			
			//3. 비밀번호 확인이 비어있는지 체크 
			if ($("#inputPasswordCheck").val() == "") {
				alert("비밀번호 확인 부탁드립니다.");
				$("#inputPasswordCheck").focus();
				return false;
			}
			
			//4. 이름이 비어있는지 체크 
			if ($("#inputName").val() == "") {
				alert("이름이 비어있습니다.");
				$("#inputName").focus();
				return false;
			}
			return true;
		});

		$("#Idcheck-button").click(function() {
			var id = $("#joininputId").val();
			
			console.log(id);
			
			if (id == "") {
				
				return;
			}
			
			if (reg_uid.test(id) != true) {
				alert("아이디 형식이 잘못 되었습니다. 다시 확인해 주세요.");
				return "";
			}

			//ajax 통신
			$.ajax({
				url : "/sfa/check?id=" + id,
				type : "get",
				dataType : "json",
				data : "",
				success : function(response) {

					// 통신 에러(서버 에러)
					if (response.result == "error") {
						//console.log(response.message);
						return;
					}

					if (response.result == "success") {
						alert("이미 존재하는 아이디 입니다.");
						$("#inputId").val("");
						$("#inputId").focus();
					} else {
						alert("사용 가능한 아이디 입니다.");
						$("#check-image").show();
						$("#check-button").hide();
					}
				},
				error : function(jqXHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		});
		
		$("#Emailcheck-button").click(function() {
			var email = $("#inputEmail").val();
			
			if (email == "") {
				
				return;
			}
			
			if (reg_email.test(email) != true) {
				alert("이메일 형식이 잘못 되었습니다. 다시 확인해 주세요.");
				return "";
			}

			//ajax 통신
			$.ajax({
				url : "/sfa/checkEmail?email="+email,
				type : "GET",
				dataType : "json",
				data : "",
				success : function(response) {

					// 통신 에러(서버 에러)
					if (response.result == "error") {
						//console.log(response.message);
						return;
					}

					if (response.result == "fail") {
						alert("이미 존재하는 이메일 입니다.");
						$("#inputEmail").val("");
						$("#inputEmail").focus();
					} else {
						alert("사용 가능한 이메일 입니다.");
					}
				},
				error : function(jqXHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		});
		
		
		
		
		$("#inputId").change(function(){
			$("#check-button").show();
			$("#check-image").hide();
			if (reg_uid.test($("#inputId").val()) != true) {
				alert("아이디 형식이 잘못 되었습니다. 다시 확인해 주세요.");
			}	
		});
		
	//비밀번호 변경시 비밀번호 확인 칸 초기화
	$("#inputPassword").focusin(function(){
		$("#inputPasswordCheck").val("");
	});
	$("#inputPasswordCheck").keyup(function(){	
		//3-1. 비밀번호와 비밀번호 체크 비교
		if ($("#inputPassword").val() != $("#inputPasswordCheck").val()) {
			//alert("비밀번호와 비밀번호 확인이  일치하지 않습니다.");
			//$("#inputPassword").val("");
			//$("#inputPasswordCheck").val("");
			$("#passwordcheck").show();
			//$("#inputPassword").focus();
			return false;
		}
		else{
			$("#passwordcheck").hide();
		}
	});
	
	$("#confirm_button").click(function(){
		
		
	});
});
