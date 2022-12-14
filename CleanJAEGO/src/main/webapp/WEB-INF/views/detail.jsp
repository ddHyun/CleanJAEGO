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
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">????????????</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" id="allItems">????????????</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <!-- ???????????? ????????? ?????? ?????? ???????????? -->
                                <c:if test="${not empty categoryList}">
                                <c:forEach var="category" items="${categoryList}" varStatus="status">
                                	<li><a class="dropdown-item" id="categoryIdx${status.index}" onclick="showCategoryItems(${status.index})">${category}</a></li>
                                </c:forEach>
                                	<li><hr class="dropdown-divider" /></li>
                                </c:if>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="button" id="navLoginBtn">
                        	<i class="bi bi-box-arrow-in-right"></i>
                            	?????????
                        </button>
                        <button class="btn btn-outline-dark" type="button" id="navLogoutBtn" onclick="location.href='logout'">
                        	<i class="bi bi-box-arrow-left"></i>
                            	????????????
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">????????????</h1>
                    <p class="lead fw-normal text-white-50 mb-0">????????? ????????????</p>
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
                        <c:if test="${not empty itemVO.idx}">
                        	<input type="hidden" value="${itemVO.idx}" name="idx">
                        </c:if>
                          <div class="row">
                            <div class="col-md-6 col-sm-12" align="center">
                            <div>
                            	<!-- ??????????????? ?????? ????????? ????????? ?????? ????????? -->
                            	<a data-toggle="tooltip" title="????????? ??????????????? ??????!">
                            		<!-- ????????? -->
                            		<c:choose>
	                            		<c:when test="${not empty itemVO.idx}">
	                            		<c:choose>
			                            	<c:when test="${itemVO.filename != 'noImage.png'}">
					                            <img width="50%" height="100%" id="itemImg" src="${pageContext.request.contextPath}/resources/upload/${itemVO.foldername}/${itemVO.filename}" alt="..." />
			                            	</c:when>
			                            	<c:otherwise>
			                            		<img width="50%" height="100%" id="itemImg" src="${pageContext.request.contextPath}/resources/upload/${itemVO.filename}" alt="..." />
			                            	</c:otherwise>
			                            </c:choose>
			                            </c:when>
		                            	<%-- <c:when test="${empty itemVO.idx}"> --%>
		                            	<c:otherwise>
		                            		<img width="50%" height="100%" id="itemImg" />
		                            	</c:otherwise>
		                            	<%-- </c:when> --%>
		                            </c:choose>
                            	</a>
                            </div>
                            <div id="file-area">
                            	<input type="file" id="itemImg1" name="file" onchange="loadImg(this,1)">
                            </div>
                            </div>
                            <div class="col-md-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                              <!-- category ???????????? ?????? ?????? input??????  -->
                                <input type="hidden" id="categoryInput" name="categoryInput">
                                <select name="itemCategory" id="categorySelect">
                                    <!-- DB??? ?????? ???????????? ?????? ???????????? -->
                                    <c:forEach var="category" items="${categoryList}">
                                    	<c:choose>
                                    		<c:when test="${category eq itemVO.category}">
		                                    	<option value="${itemVO.category}" selected="selected">${itemVO.category}</option>
                                    		</c:when>
                                    		<c:otherwise><option value="${category}">${category}</option></c:otherwise>
                                    	</c:choose>                                    	
                                    </c:forEach>
                                    	<!-- ?????????????????? ?????? ?????? && ???????????? ?????? ?????????  -->
                                    	<c:choose>
                                    		
                                    	<c:when test="${empty itemVO.idx && res eq 0 }">
                                    		<option value="noName">??????</option>
                                    	</c:when>
                                    	</c:choose>
                                    	<option value="newCategory">[???????????? ??????]</option>
                                </select>
                              </fieldset>
                            </div>
                            <input type="hidden" value="${itemVO.idx}">
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>?????????</strong><small style="color:#cf565c">(????????????)</small>
                                <input type="text" value="${itemVO.item_name}" id="nameInput" name="item_name" maxlength="20" required>
                              </fieldset>
                            </div>
                              <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>?????????</strong><small style="color:#cf565c">(????????????)</small>
                                <input type="number" value="${itemVO.stock}" id="stockInput" name="stock" required>
                              </fieldset>
                            </div>
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                              	&nbsp;&nbsp;<strong>????????????</strong>
                              	<c:choose>
                              		<c:when test="${itemVO.manufacture_date ne '-'}">
		                              	<input type="date" value="${itemVO.manufacture_date}" id="manufactureDateInput" name="manufacture_date">
                              		</c:when>
                              		<c:otherwise>
                              			<input type="date" value="" id="manufactureDateInput" name="manufacture_date">
                              		</c:otherwise>
                              	</c:choose>
                            </fieldset>
                            </div>
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                              	&nbsp;&nbsp;<strong>????????????</strong>
                              	<c:choose>
                              		<c:when test="${itemVO.expiry_date ne '-'}">
		                              	<input type="date" value="${itemVO.expiry_date}" id="expiryDateInput" name="expiry_date">
                              		</c:when>
                              		<c:otherwise>
                              			<input type="date" value="" id="expiryDateInput" name="expiry_date">
                              		</c:otherwise>
                              	</c:choose>
                            </fieldset>
                            </div>
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>??????</strong>
                                <input type="text" value="${itemVO.price}" id="priceInput" name="price">
                              </fieldset>
                            </div>                           
                            <div class="col-lg-6 col-sm-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>?????????</strong>
                                <input type="text" value="${itemVO.store}" id="storeInput" name="store">
                              </fieldset>
                            </div>          
                            
                            <div class="col-lg-12" style="margin-top:10px">
                              <fieldset>
                                &nbsp;&nbsp;<strong>??????</strong><textarea name="memo" rows="3" id="memoText">${itemVO.memo}</textarea>
                              </fieldset>
                            </div>
                            <div class="col-lg-12" style="margin-top:10px">
                              <fieldset>
                              <c:choose>
	                              <c:when test="${not empty itemVO.idx}">
	                                	<button type="button" id="modifyBtn" class="main-button-icon"
	                                	style="background-color:#cf565c; border-color:#cf565c">????????????</button>
	                              </c:when>
	                              <c:otherwise>
	                                	<button type="button" id="registerBtn" class="main-button-icon"
	                                	style="background-color:#cf565c; border-color:#cf565c">????????????</button>
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
		
		//??????????????? ?????? ????????? ????????? ?????? ?????????
		$('[data-toggle="tooltip"]').tooltip();
		
		$('#file-area').hide();
		$('#file-area').css('cursor', 'pointer');
		//??????????????? ???????????? ??????????????? ??? ?????????
		$('#itemImg').click(function(){
			$('#itemImg1').click();
		});
	});
	
	//??????????????? ????????????
	function loadImg(inputFile, num) {
		if(inputFile.files.length==1){
			let reader = new FileReader();
			reader.readAsDataURL(inputFile.files[0]);
			reader.onload = function(e){
				$('#itemImg').attr('src', e.target.result);
			}
		}else{
			$('#itemImg').attr('src', null);
		}
	}
	
	//???????????? ????????????
	$('#categorySelect').change(function(){
		if($(this).val()=='newCategory'){
			let newCatagoryName = prompt('????????? ?????????????????? ??????????????????', '').trim();
			let option = '<option value="'+newCatagoryName+'">'+newCatagoryName+'</option>';
			//???????????? ?????? ??? ?????? ????????????
			$('#categorySelect option:eq(0)').before(option);
			//????????? option????????? ????????? ????????????
			$(this).val(newCatagoryName).attr('selected', 'selected');
		}
	});
	
	
	//????????? ??????????????? ?????? ?????????
	function showCategoryItems(index) {
		//???????????? ????????? ???????????? index?????? ??? text ????????????
		var category = $('#categoryIdx'+index).text();
		location.href = 'showCategoryItems?category='+category;
	}
	
	//???????????? ?????? ??? ???????????? ?????? ?????????
	$('#allItems').on('click', function(){
		var category = $(this).text();
		location.href = 'showCategoryItems?category='+category;
	});
	
	
	$('#modifyBtn').click(function(e){
		validateItem();
		/* let?????? ?????? ????????? */
		var form = $('#contact')[0];
		let formData = new FormData(form);		
		$.ajax({
			url:'modifyItem',
			data:formData,
			type:'post',
			contentType:false,
			processData:false
		}).done(function(data){
			let json = (new Function('return'+data))();
			if(json[0].result=='0'){
				alert('????????? ????????? ????????????.');
				return false;
			}else if(json[0].result=='1'){
				alert('????????? ?????????????????????.');
				location.href = 'main';
			}
		});
	});
	
	//???????????? ?????? ????????? select option??? input??? ??????
	$('#registerBtn').click(function(){		
		validateItem();
		var form = $('#contact')[0];
		let formData = new FormData(form);
		$.ajax({
			url:'registerItem',
			data:formData,
			type:'post',
			contentType:false,
			processData:false
		}).done(function(data){
			let json = (new Function('return'+data))();
			if(json[0].result=='1'){
				alert('?????????????????????');
				location.href = 'main';
			}
		});
	});
	
	//????????? ??????	
	function validateItem() {
		let categoryText = $('#categorySelect option:selected').text();
		$('#categoryInput').val(categoryText);
		
		let item_nameVal = $.trim($('#nameInput').val());
		let stockVal = $.trim($('#stockInput').val());
		let manufacture_dateVal = $.trim($('#manufactureDateInput').val());
		let expiry_dateVal = $.trim($('#expiryDateInput').val());
		let priceVal = $.trim($('#priceInput').val());		
		let storeVal = $.trim($('#storeInput').val());
		let memoVal = $.trim($('#memoText').val());
		
		if(item_nameVal==''){
			alert('???????????? ??????????????????');
			return false;
		}
		if(stockVal==''){
			alert('????????? ????????? ??????????????????');
			return false;
		} 
		if(!/[0-9]/g.test(stockVal)){
			alert('????????? ?????? ???????????????');
			$('#stockInput').val('');
			$('#stockInput').focus();
			return false;
		}	
	}
	
	
</script>
</html>