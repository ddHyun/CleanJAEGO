<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>CleanJAEGO</title>   
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="resources/css/styles.css" rel="stylesheet" />
<!-- <link href="resources/css/bootstrap.min.css" rel="stylesheet" /> -->
</head>

<body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!">CleanJAEGO</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" onclick="location.href='main'">Home</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">카테고리</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#!">전체재고</a></li>
                                <li><hr class="dropdown-divider" /></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="button" onclick="location.href='login'">
                        	<i class="bi bi-box-arrow-in-right"></i>
                            	로그인
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">클린재고</h1>
                    <p class="lead fw-normal text-white-50 mb-0">우리집 재고관리</p>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5" style="background-color:#cfffe5">
			 <div class="container px-4 px-lg-5 mt-5">           
			 <form>
			  <fieldset>			    
			    <div class="form-email">
			      <label for="inputEmail1" class="form-label mt-4">이메일</label>
			      <input type="email" class="form-control" id="inputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
			      <small id="emailHelp" class="form-text text-muted" style="color:red;"></small>
			    </div>
			    <div class="form-pwd">
			      <label for="inputPassword1" class="form-label mt-4">비밀번호</label>
			      <input type="password" class="form-control" id="inputPassword1" placeholder="Password">
			      <small id="pwdHelp" class="form-text text-muted" style="color:red;"></small>
			    </div> 
			    <div class="form-pwd">
			      <label for="inputPassword2" class="form-label mt-4">비밀번호 확인</label>
			      <input type="password" class="form-control" id="inputPassword2" placeholder="Password">
			      <small id="pwdHelp2" class="form-text text-muted" style="color:red;"></small>
			    </div> 
			    <div class="form-pwd">
			      <label class="form-label mt-4"></label>
			    </div>
			  </fieldset>
			</form>
		    <form class="form-btn"> 
		    	<button type="button" class="btn btn-outline-dark" id="joinBtn">회원가입</button>
		    </form>		    
			</div>

        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="resources/js/scripts.js"></script>
        <script src="resources/js/jquery-3.6.0.min.js"></script>
</body>

<script>
	$(document).ready(function(){
		$('#inputEmail1').focus();
	});		
	
	//회원가입
	$('#joinBtn').click(function(){
		let email = $('#inputEmail1');
		let pwd = $('#inputPassword1');
		let pwd2 = $('#inputPassword2');
		let emailHelp = $('#emailHelp');
		let pwdHelp = $('#pwdHelp');
		let pwdHelp2 = $('#pwdHelp2');
		let emailVal = $.trim(email.val());
		let pwdVal = $.trim(pwd.val());
		let pwdVal2 = $.trim(pwd2.val());
		let emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		let pwdPattern = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		let check = false;
		
		email.on('keyup paste', function(){
			emailHelp.css('display', 'none');
		});		
		
		//유효성
		if(emailVal==''){
			emailHelp.html('이메일을 입력해주세요');				
			email.focus();
			check = false;
			return false;
		}
		if(!emailPattern.test(emailVal)){
			emailHelp.css('display', 'block');
			emailHelp.html('이메일 형식이 올바르지 않습니다');
			email.val("");
			email.focus();
			check = false;
			return false;
		}else{
			check = true;
			console.log('email format ok / check: '+check);
		}
		
		pwd.on('keypress', function(){
			pwdHelp.css('display', 'none');
		});
		
		if(pwdVal==''){
			pwdHelp.html('비밀번호를 입력해주세요');
			pwd.focus();
			check = false;
			return false;
		}			
		/* if(!pwdPattern.test(pwdVal)){
			pwdHelp.css('display', 'block');
			pwdHelp.html('특수문자를 포함한 8~16자리의 숫자, 영문만 입력이 가능합니다');
			pwd.val("");
			pwd.focus();
			check = false;
			return false;
		} */
		
		pwd2.on('keyup', function(){
			pwdHelp2.css('display', 'none');
		});
		
		if(pwdVal != pwdVal2){
			pwdHelp2.html('비밀번호가 일치하지 않습니다');
			pwd2.val('');
			pwd2.focus();
			check = false;
			return false;
		}else{
			check = true;
			console.log('pwd correct/ check: '+check);
		}
		
		//이메일 중복여부
		$.ajax({
			url:"checkEmail",
			data:{email:emailVal},
			datatype:"json",
			type:"POST",
			async:false
		}).done(function(data){
			let json = (new Function('return'+data))();
			if(json[0].count=='1'){
				emailHelp.html('이미 사용중인 이메일입니다. 다른 이메일로 시도해주세요');
				email.val('');
				email.focus();
				check = false;
				console.log('email 중복됨/ check: '+check);
			}else if(json[0].count=='0'){
				check = true;
				console.log('email 사용가능/ check: '+check);
			}
		}).fail(function(){
			alert('email check fail');
		});		
		
		if(check){
			 $.ajax({
				url: "checkJoin",
				data:{email:emailVal, pwd:pwdVal},
				datatype:"json",
				type:"POST",
				async:false
			}).done(function(data){
				let json = (new Function('return'+data))();
				if(json[0].res=='1'){
				alert('회원가입 성공!\r\n로그인 화면으로 이동합니다');
				location.href= 'login';					
				}else if(json[0].res=='0'){
					alert('관리자에게 문의하세요');
				}
			}).fail(function(){
				alert('join fail');
			});			
		}		
	});//회원가입버튼	

</script>
</html>