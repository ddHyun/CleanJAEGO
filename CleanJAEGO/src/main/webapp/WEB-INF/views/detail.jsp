<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!-- Additional CSS Files -->
<link rel="stylesheet" href="resources/css/templatemo-klassy-cafe.css">
<link rel="stylesheet" href="resources/css/owl-carousel.css">
<link rel="stylesheet" href="resources/css/lightbox.css">
</head>
<style>
@media (min-width: 576px) {
  img{
  	height: 154.66px;
  	object-fit: contain;
  }
}
@media (min-width: 768px) {
   img{
  	height: 137.33px;
  	object-fit: contain;
  }
}
  @media (min-width: 992px) {
 img{
  	height: 178.66px;
  	object-fit: contain;
  }
}
  @media (min-width: 1200px) {
 img{
  	height: 178.66px;
  	object-fit: contain;
  }  
  .tooltip-inner{
  	background:#cf565c;
  }  
}
</style>

<body>		
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!">CleanJAEGO</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="main">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">카테고리</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#!">All Products</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="#!">Popular Items</a></li>
                                <li><a class="dropdown-item" href="#!">New Arrivals</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="button" id="navLoginBtn">
                        	<i class="bi bi-box-arrow-in-right"></i>
                            	로그인
                        </button>
                        <button class="btn btn-outline-dark" type="button" id="navLogoutBtn" onclick="location.href='logout'">
                        	<i class="bi bi-box-arrow-left"></i>
                            	로그아웃
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
           <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			 <div class="col-lg-6" style="width:100%">
                    <div class="contact-form">
                        <form id="contact" action="" method="post" enctype="multipart/form-data">
                          <div class="row">
                            <div class="col-md-6 col-sm-12" align="center">
                            <div>
                            	<!-- 이미지태그 위에 마우스 올리면 문구 띄우기 -->
                            	<a data-toggle="tooltip" title="사진을 등록하려면 클릭!">
                            		<!-- 이미지 -->
                            		<img width="50%" height="100%" id="itemImg">
                            	</a>
                            </div>
                            <div id="file-area">
                            	<input type="file" id="itemImg1" onchange="loadImg(this,1)">
                            </div>
                            </div>
                            <div class="col-md-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                <select name="itemCategory" id="categorySelect">
                                    <c:forEach var="category" items="${categoryList}">
                                    	<c:choose>
                                    		<c:when test="${category eq itemVO.category}">
		                                    	<option value="${itemVO.category}" selected="selected">${itemVO.category}</option>
                                    		</c:when>
                                    		<c:otherwise><option value="${category}">${category}</option></c:otherwise>
                                    	</c:choose>                                    	
                                    </c:forEach>
                                    	<option value="noName">기본</option>
                                    	<option value="newCategory">[카테고리 추가]</option>
                                </select>
                              </fieldset>
                            </div>
                            <input type="hidden" value="${itemVO.idx}">
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>제품명</strong><small style="color:#cf565c">(필수입력)</small>
                                <input type="text" value="${itemVO.item_name}" id="nameInput">
                              </fieldset>
                            </div>
                              <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>총재고</strong><small style="color:#cf565c">(필수입력)</small>
                                <input type="text" value="${itemVO.stock}" id="stockInput">
                              </fieldset>
                            </div>
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                              	&nbsp;&nbsp;<strong>제조일자</strong><input type="date" value="${itemVO.manufacture_date}" id="manufactureDateInput">
                            </fieldset>
                            </div>
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                              	&nbsp;&nbsp;<strong>유통기한</strong><input type="date" value="${itemVO.expiry_date}" id="expiryDateInput">
                            </fieldset>
                            </div>
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>가격</strong><input type="text" value="${itemVO.price}" id="priceInput">
                              </fieldset>
                            </div>                           
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>구매처</strong><input type="text" value="${itemVO.store}" id="storeInput">
                              </fieldset>
                            </div>          
                            
                            <div class="col-lg-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>메모</strong><textarea name="memo" rows="3" id="memoText">${itemVO.memo}</textarea>
                              </fieldset>
                            </div>
                            <div class="col-lg-12" style="margin-top:10px">
                              <fieldset>
                              <c:choose>
	                              <c:when test="${not empty itemVO.idx}">
	                                	<button type="button" id="modifyBtn" class="main-button-icon" 
	                                	style="background-color:#cf565c; border-color:#cf565c">수정하기</button>
	                              </c:when>
	                              <c:otherwise>
	                                	<button type="button" id="registerBtn" class="main-button-icon" 
	                                	style="background-color:#cf565c; border-color:#cf565c">등록하기</button>
	                              </c:otherwise>
                              </c:choose>
                              </fieldset>
                            </div>
                          </div>
                        </form>
                    </div>
                </div>
                </div>
          </div>
        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark" style="margin-top:0px">
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
		let sessionEmail = "${sessionScope.sessionEmail}";
		if(sessionEmail == '' || sessionEmail == 'none'){
			$('#navLogoutBtn').hide();
		}else{
			$('#navLoginBtn').hide();
		}
		
		//이미지태그 위에 마우스 올리면 문구 띄우기
		$('[data-toggle="tooltip"]').tooltip();
		
		$('#file-area').hide();
		$('#file-area').css('cursor', 'pointer');
		//이미지영역 클릭하면 파일업로드 창 띄우기
		$('#itemImg').click(function(){
			$('#itemImg1').click();
		});
	});
	
	//이미지파일 미리보기
	function loadImg(inputFile, num) {
		if(inputFile.files.length==1){
			let reader = new FileReader();
			reader.readAsDataURL(inputFile.files[0]);
			reader.onload = function(e){
				$('#itemImg').attr('src', e.target.result);
				console.log(e.target.result);
			}
		}else{
			$('#itemImg').attr('src', null);
		}
	}
	
	//카테고리 추가하기
	$('#categorySelect').change(function(){
		if($(this).val()=='newCategory'){
			let newCatagoryName = prompt('추가할 카테고리명을 입력해주세요', '').trim();
			let option = '<option value="'+newCatagoryName+'">'+newCatagoryName+'</option>';
			//카테고리 목록 맨 위에 추가하기
			$('#categorySelect option:eq(0)').before(option);
			//추가된 option값으로 화면에 표시하기
			$(this).val(newCatagoryName).attr('selected', 'selected');
		}
	});
	
	//제품 등록하기
	$('#registerBtn').click(function(){
		let filename;
		let category = $('#categorySelect option:selected').text();
		let item_name = $.trim($('#nameInput').val());
		let email = "${sessionScope.sessionEmail}";
		let manufacture_date = $.trim($('#manufactureDateInput').val());
		let expiry_date = $.trim($('#expiryDateInput').val());
		let stock = $.trim($('#stockInput').val());
		let price = $.trim($('#priceInput').val());		
		let store = $.trim($('#storeInput').val());
		let memo = $.trim($('#memoText').val());
		
		if(item_name==''){
			alert('제품명을 입력해주세요');
			return false;
		}
		if(stock==''){
			alert('총재고 수량을 입력해주세요');
			return false;
		}
		if(!/[0-9]/g.test(stock)){
			alert('숫자만 입력 가능합니다');
			$('#stockInput').val('');
			$('#stockInput').focus();
			return false;
		}
		//미입력시 '-'로 저장하기
		if(manufacture_date==''){
			manufacture_date = '-';
		}
		if(expiry_date==''){
			expiry_date = '-';
		}
		if(price==''){
			price = '-';
		}
		if(store==''){
			store = '-';
		}
		if(memo==''){
			memo = '-';
		}
		
		alert('카테고리 : '+category+'\r\n제품명 : '+item_name+'\r\n이메일 : '+email
				+'\r\n제조일자 : '+manufacture_date+'\r\n유통기한 : '+expiry_date
				+'\r\n총재고 : '+stock+'\r\n가격 : '+price+'\r\n구매처 : '+store+'\r\n메모 : '+memo);
	});
	
</script>
</html>