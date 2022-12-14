<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<style>
.categoryTitle{
	color: #cf565c;
	font-weight: bold;
	font-size: 2rem;
	display: block;
	text-align: center;
	margin-bottom: 1rem;
}
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
}
</style>

<body>		
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="">CleanJAEGO</a>
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
        	<span class="categoryTitle">
        	<c:choose>
        		<c:when test="${sessionScope.categoryName ne 'nothing' && sessionScope.categoryName ne 'everything' }">
        			[${sessionScope.categoryName}]
        		</c:when>
        		<c:otherwise>[????????????]</c:otherwise>
        	</c:choose> 
        	</span>   
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                
		<!----------------------------------- ????????? ?????????????????? ????????? ??????????????? ?????? ?????? ----------------------------------->           		                     
                   <!-- ???????????? ?????????????????? ??????????????? ???????????? ?????? categoryItems??? ??????, ????????????(nothing)?????? ????????????(everything)??? itemList??? ?????? ?????? -->
                   <c:choose>
                   <c:when test="${sessionEmail ne null && dbResult ne '0' && dbResult ne 'noSession' }">
                   <c:choose>
                   <c:when test="${sessionScope.categoryName ne 'nothing' && sessionScope.categoryName ne 'everything'}">
                  <c:forEach var="item" items="${categoryItems}" varStatus="status">
                    <div class="col mb-5">
                        <div class="card h-100">
                        	<c:if test="${item.stock le 1 || item.dateGap le 3}">
                        		<div class="badge bg-dark text-white position-absolute" style="top: 12.8rem; right: 0.5rem">??????!!</div>
                        	</c:if>
                            <!-- Product image-->
                            <c:choose>
                            	<c:when test="${item.filename ne 'noImage.png'}">
		                            <img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/${item.foldername}/${item.filename}" alt="..." />
                            	</c:when>
                            	<c:otherwise>
                            		<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/${item.filename}" alt="..." />
                            	</c:otherwise>
                            </c:choose>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${item.item_name}</h5>
                                    <!-- Stock -->
                                    <c:choose>
                                    <c:when test="${item.stock le 1}">
                                    	<span style="color:#cf565c">????????? : ${item.stock }???</span><br>
                                    </c:when>
                                    <c:otherwise>????????? : ${item.stock }???<br></c:otherwise>
                                    </c:choose>
                                    <!-- Manufacture date -->
                                    	???????????? : ${item.manufacture_date }<br>
                                    <!-- Expiry date -->
                                    <c:choose>
                                    <c:when test="${item.dateGap le 3}">
                                    	<span style="color:#cf565c">???????????? : ${item.expiry_date }</span>
                                    </c:when>
                                    <c:otherwise>???????????? : ${item.expiry_date }</c:otherwise>
                                    </c:choose>  
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                              <div class="text-center">
                                	<a class="btn btn-outline-dark mt-auto" onclick="showDetail(${item.idx})">????????????</a>&nbsp;&nbsp;
                                	<a class="btn btn-outline-dark mt-auto" onclick="deleteItem(${item.idx})">????????????</a>
                                </div>
                            </div>
                        </div>
                    </div>
                   </c:forEach>
                   </c:when>
                   
                   <c:otherwise>
                  <c:forEach var="item" items="${itemList}" varStatus="status">
                    <div class="col mb-5">
                        <div class="card h-100">
                        	<c:if test="${item.stock le 1 || item.dateGap le 3}">
                        		<div class="badge bg-dark text-white position-absolute" style="top: 12.8rem; right: 0.5rem">??????!!</div>
                        	</c:if>
                            <!-- Product image-->
                            <c:choose>
                            	<c:when test="${item.filename ne 'noImage.png'}">
		                            <img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/${item.foldername}/${item.filename}" alt="..." />
                            	</c:when>
                            	<c:otherwise>
                            		<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/${item.filename}" alt="..." />
                            	</c:otherwise>
                            </c:choose>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${item.item_name}</h5>
                                    <!-- Stock -->
                                    <c:choose>
                                    <c:when test="${item.stock le 1}">
                                    	<span style="color:#cf565c">????????? : ${item.stock }???</span><br>
                                    </c:when>
                                    <c:otherwise>????????? : ${item.stock }???<br></c:otherwise>
                                    </c:choose>
                                    <!-- Manufacture date -->
                                    	???????????? : ${item.manufacture_date }<br>
                                    <!-- Expiry date -->
                                    <c:choose>
                                    <c:when test="${item.dateGap le 3}">
                                    	<span style="color:#cf565c">???????????? : ${item.expiry_date }</span>
                                    </c:when>
                                    <c:otherwise>???????????? : ${item.expiry_date }</c:otherwise>
                                    </c:choose>  
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                              <div class="text-center">
                                	<a class="btn btn-outline-dark mt-auto" onclick="showDetail(${item.idx})">????????????</a>&nbsp;&nbsp;
                                	<a class="btn btn-outline-dark mt-auto" onclick="deleteItem(${item.idx})">????????????</a>
                                </div>
                            </div>
                        </div>
                    </div>
                   </c:forEach>
                   </c:otherwise>
                   </c:choose>

                   <!-- ???????????? ?????? ??? ???????????? section -->
                   <div class="col mb-5">
                   		<div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/noImage.png" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder"></h5>
                                    <!-- Stock -->
                                    	<br>
                                    <!-- Manufacture date -->
                                    	????????? ?????????<br>??????????????????<br>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                               <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="detail2">????????????</a></div>
                            </div>
                        </div>
                     </div>
                   </c:when>
                   </c:choose>
                   
                   
                   
                  
                   
                   
                   
                   
                   
                   
		<!----------------------------------- ????????? ????????? ?????? ??????/???????????? ----------------------------------->                 
                   <c:if test="${empty sessionEmail}">
                   <c:forEach var="item" items="${itemList }">
                    <div class="col mb-5">
                        <div class="card h-100"> 
                        	<!-- ???????????? 1 ??????????????? (????????????-????????????)??? 3??? ????????? ??? ?????? ????????? -->
                        	<c:if test="${item.stock le 1 || item.dateGap le 3}">
                        		<div class="badge bg-dark text-white position-absolute" style="top: 12.8rem; right: 0.5rem">??????!!</div>
                        	</c:if>                       
                            <!-- Product image-->
                            <img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/sample/${item.filename}" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${item.item_name}</h5>
                                    <!-- Stock -->
                                    <c:choose>
                                    <c:when test="${item.stock le 1}">
                                    	<span style="color:#cf565c">????????? : ${item.stock }???</span><br>
                                    </c:when>
                                    <c:otherwise>????????? : ${item.stock }???<br></c:otherwise>
                                    </c:choose>                                    	
                                    <!-- Manufacture date -->
                                    	???????????? : ${item.manufacture_date }<br>                                    	
                                    <!-- Expiry date -->
                                   	<c:choose>
                                    <c:when test="${item.dateGap le 3}">
                                    	<span style="color:#cf565c">???????????? : ${item.expiry_date }</span>
                                    </c:when>
                                    <c:otherwise>???????????? : ${item.expiry_date }</c:otherwise>
                                    </c:choose>                                      		  
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" id="sampleBtn${item.idx}">????????????</a></div>
                            </div>
                        </div>
                    </div>
                   </c:forEach>
                   </c:if>
		<!----------------------------------- ???????????? ??????????????? ????????? ??????????????? ?????? ?????? ----------------------------------->                   
                   <c:if test="${sessionEmail ne null && dbResult eq '0'}">                   
                    <div class="col mb-5">
                   		<div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/noImage.png" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder"></h5>
                                    <!-- Stock -->
                                    	<br>
                                    <!-- Manufacture date -->
                                    	????????? ?????????<br>??????????????????<br>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="detail2">????????????</a></div>
                            </div>
                        </div>
                     </div>
                   </c:if>
                    
                </div>
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
		let sessionEmail = "${sessionScope.sessionEmail}";
		if(sessionEmail == '' || sessionEmail == 'none'){
			$('#navLogoutBtn').hide();
		}else{ //????????? ????????? ??????
			$('#navLoginBtn').hide();
			let categoryName = "${sessionScope.categoryName}";
			console.log(categoryName);
		}		
	});
	
	//????????????????????? ??????
	$('#navLoginBtn').click(function(){
		location.href = 'login';
	});
	
	//????????? ??? ???????????? ?????? ?????????
	//????????? ?????? onclick??? id ????????? ?????? ???????????? ??????
	$("a[id^='sampleBtn']").on('click', function(e){
		alert('????????? ??? ?????????????????????');
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
	
	//????????????
	function showDetail(index) {
		location.href='detail?idx='+index;
	}	
	
	//????????????
	function deleteItem(index) {
		if(!confirm('?????????????????????????')){
			return;
		}else{//???????????? ????????????
			$.ajax({
				url:'deleteItem',
				data:{'idx':index},
				datatype:'json',
				type:'post'				
			}).done(function(data){
				let json = (new Function('return'+data))();
				if(json[0].resultNum=='1'){
					alert('?????????????????????');
					location.href = 'main';					
				}else{
					alert('?????? ????????? ?????????');
					return;
				}
			}).fail(function(){
				alert('fail');
			});
		}
	}	
	
</script>
</html>