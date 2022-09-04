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
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">카테고리</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" id="allItems">전체재고</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <!-- 카테고리 목록이 있을 경우 불러오기 -->
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
                
		<!----------------------------------- 로그인 되어있으면서 저장된 재고목록도 있는 경우 ----------------------------------->
           		  <%-- <c:if test="${sessionEmail ne null && dbResult ne '0' && dbResult ne 'noSession' }">
                  <c:forEach var="item" items="${itemList }" varStatus="status">
                    <div class="col mb-5">
                        <div class="card h-100">
                        	<c:if test="${item.stock le 1 || item.dateGap le 3}">
                        		<div class="badge bg-dark text-white position-absolute" style="top: 12.8rem; right: 0.5rem">임박!!</div>
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
                                    	<span style="color:#cf565c">총재고 : ${item.stock }개</span><br>
                                    </c:when>
                                    <c:otherwise>총재고 : ${item.stock }개<br></c:otherwise>
                                    </c:choose>
                                    <!-- Manufacture date -->
                                    	제조일자 : ${item.manufacture_date }<br>
                                    <!-- Expiry date -->
                                    <c:choose>
                                    <c:when test="${item.dateGap le 3}">
                                    	<span style="color:#cf565c">유통기한 : ${item.expiry_date }</span>
                                    </c:when>
                                    <c:otherwise>유통기한 : ${item.expiry_date }</c:otherwise>
                                    </c:choose>  
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                              <div class="text-center">
                                	<a class="btn btn-outline-dark mt-auto" onclick="showDetail(${item.idx})">수정하기</a>&nbsp;&nbsp;
                                	<a class="btn btn-outline-dark mt-auto" onclick="deleteItem(${item.idx})">삭제하기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                   </c:forEach>
                   
                   <!-- 기존목록 열거 후 등록하기 section -->
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
                                    	관리할 제품을<br>등록해주세요<br>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="detail2">등록하기</a></div>
                            </div>
                        </div>
                     </div>
                   </c:if> --%>
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   <c:choose>
                   <c:when test="${sessionEmail ne null && dbResult ne '0' && dbResult ne 'noSession' }">
                   <c:choose>
                   <c:when test="${allList eq 'no'}">
                  <c:forEach var="item" items="${categoryItems}" varStatus="status">
                    <div class="col mb-5">
                        <div class="card h-100">
                        	<c:if test="${item.stock le 1 || item.dateGap le 3}">
                        		<div class="badge bg-dark text-white position-absolute" style="top: 12.8rem; right: 0.5rem">임박!!</div>
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
                                    	<span style="color:#cf565c">총재고 : ${item.stock }개</span><br>
                                    </c:when>
                                    <c:otherwise>총재고 : ${item.stock }개<br></c:otherwise>
                                    </c:choose>
                                    <!-- Manufacture date -->
                                    	제조일자 : ${item.manufacture_date }<br>
                                    <!-- Expiry date -->
                                    <c:choose>
                                    <c:when test="${item.dateGap le 3}">
                                    	<span style="color:#cf565c">유통기한 : ${item.expiry_date }</span>
                                    </c:when>
                                    <c:otherwise>유통기한 : ${item.expiry_date }</c:otherwise>
                                    </c:choose>  
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                              <div class="text-center">
                                	<a class="btn btn-outline-dark mt-auto" onclick="showDetail(${item.idx})">수정하기</a>&nbsp;&nbsp;
                                	<a class="btn btn-outline-dark mt-auto" onclick="deleteItem(${item.idx})">삭제하기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                   </c:forEach>
                   </c:when>
                   <c:when test="${allList eq 'yes' || sessionScope.categoryName eq 'nothing' || sessionScope.categoryName eq 'everything'}">
                  <c:forEach var="item" items="${itemList}" varStatus="status">
                    <div class="col mb-5">
                        <div class="card h-100">
                        	<c:if test="${item.stock le 1 || item.dateGap le 3}">
                        		<div class="badge bg-dark text-white position-absolute" style="top: 12.8rem; right: 0.5rem">임박!!</div>
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
                                    	<span style="color:#cf565c">총재고 : ${item.stock }개</span><br>
                                    </c:when>
                                    <c:otherwise>총재고 : ${item.stock }개<br></c:otherwise>
                                    </c:choose>
                                    <!-- Manufacture date -->
                                    	제조일자 : ${item.manufacture_date }<br>
                                    <!-- Expiry date -->
                                    <c:choose>
                                    <c:when test="${item.dateGap le 3}">
                                    	<span style="color:#cf565c">유통기한 : ${item.expiry_date }</span>
                                    </c:when>
                                    <c:otherwise>유통기한 : ${item.expiry_date }</c:otherwise>
                                    </c:choose>  
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                              <div class="text-center">
                                	<a class="btn btn-outline-dark mt-auto" onclick="showDetail(${item.idx})">수정하기</a>&nbsp;&nbsp;
                                	<a class="btn btn-outline-dark mt-auto" onclick="deleteItem(${item.idx})">삭제하기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                   </c:forEach>
                   </c:when>
                   </c:choose>
                   <!-- 기존목록 열거 후 등록하기 section -->
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
                                    	관리할 제품을<br>등록해주세요<br>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="detail2">등록하기</a></div>
                            </div>
                        </div>
                     </div>
                   </c:when>
                   </c:choose>
                   
                   
                   
                  
                   
                   
                   
                   
                   
                   
		<!----------------------------------- 로그인 상태가 아닌 경우/기본화면 ----------------------------------->                 
                   <c:if test="${empty sessionEmail}">
                   <c:forEach var="item" items="${itemList }">
                    <div class="col mb-5">
                        <div class="card h-100"> 
                        	<!-- 총재고가 1 이하이거나 (유통기한-현재날짜)가 3일 이하일 때 임박 띄우기 -->
                        	<c:if test="${item.stock le 1 || item.dateGap le 3}">
                        		<div class="badge bg-dark text-white position-absolute" style="top: 12.8rem; right: 0.5rem">임박!!</div>
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
                                    	<span style="color:#cf565c">총재고 : ${item.stock }개</span><br>
                                    </c:when>
                                    <c:otherwise>총재고 : ${item.stock }개<br></c:otherwise>
                                    </c:choose>                                    	
                                    <!-- Manufacture date -->
                                    	제조일자 : ${item.manufacture_date }<br>                                    	
                                    <!-- Expiry date -->
                                   	<c:choose>
                                    <c:when test="${item.dateGap le 3}">
                                    	<span style="color:#cf565c">유통기한 : ${item.expiry_date }</span>
                                    </c:when>
                                    <c:otherwise>유통기한 : ${item.expiry_date }</c:otherwise>
                                    </c:choose>                                      		  
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" id="sampleBtn${item.idx}">수정하기</a></div>
                            </div>
                        </div>
                    </div>
                   </c:forEach>
                   </c:if>
		<!----------------------------------- 로그인은 되어있지만 저장된 재고목록이 없는 경우 ----------------------------------->                   
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
                                    	관리할 제품을<br>등록해주세요<br>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="detail2">등록하기</a></div>
                            </div>
                        </div>
                     </div>
                   </c:if>
                    <!-- <div class="col mb-5">
                        <div class="card h-100">
                            Sale badge
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..."/>
                            Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                    Product name
                                    <h5 class="fw-bolder">Special Item</h5>
                                    Product reviews
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    Product price
                                    <span class="text-muted text-decoration-line-through">$20.00</span>
                                    $18.00
                                </div>
                            </div>
                            Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            Sale badge
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                    Product name
                                    <h5 class="fw-bolder">Sale Item</h5>
                                    Product price
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    $25.00
                                </div>
                            </div>
                            Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                    Product name
                                    <h5 class="fw-bolder">Popular Item</h5>
                                    Product reviews
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    Product price
                                    $40.00
                                </div>
                            </div>
                            Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            Sale badge
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                    Product name
                                    <h5 class="fw-bolder">Sale Item</h5>
                                    Product price
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    $25.00
                                </div>
                            </div>
                            Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                    Product name
                                    <h5 class="fw-bolder">Fancy Product</h5>
                                    Product price
                                    $120.00 - $280.00
                                </div>
                            </div>
                            Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            Sale badge
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                    Product name
                                    <h5 class="fw-bolder">Special Item</h5>
                                    Product reviews
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    Product price
                                    <span class="text-muted text-decoration-line-through">$20.00</span>
                                    $18.00
                                </div>
                            </div>
                            Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                    Product name
                                    <h5 class="fw-bolder">Popular Item</h5>
                                    Product reviews
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    Product price
                                    $40.00
                                </div>
                            </div>
                            Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div> -->
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
		}else{
			$('#navLoginBtn').hide();
			let categoryName = "${sessionScope.categoryName}";
			console.log(categoryName);
		}		
	});
	
	//로그인페이지로 이동
	$('#navLoginBtn').click(function(){
		location.href = 'login';
	});
	
	//로그인 후 이용가능 문구 띄우기
	//반복문 안의 onclick은 id 다르게 해서 동작하게 하기
	$("a[id^='sampleBtn']").on('click', function(e){
		alert('로그인 후 이용가능합니다');
	});	

	//선택된 카테고리별 제품 띄우기
	function showCategoryItems(index) {
		//카테고리 목록별 아이디에 index부여 후 text 가져오기
		var category = $('#categoryIdx'+index).text();
		
		location.href = 'showCategoryItems?category='+category;
	}
	
	//전체재고 클릭 시 모든제품 목록 띄우기
	$('#allItems').on('click', function(){
		var category = $(this).text();
		location.href = 'showCategoryItems?category='+category;
	});
	
	//수정하기
	function showDetail(index) {
		location.href='detail?idx='+index;
	}	
	
	//삭제하기
	function deleteItem(index) {
		if(!confirm('삭제하시겠습니까?')){
			return;
		}else{//선택목록 삭제하기
			$.ajax({
				url:'deleteItem',
				data:{'idx':index},
				datatype:'json',
				type:'post'				
			}).done(function(data){
				let json = (new Function('return'+data))();
				if(json[0].resultNum=='1'){
					alert('삭제되었습니다');
					location.href = 'main';					
				}else{
					alert('다시 시도해 주세요');
					return;
				}
			}).fail(function(){
				alert('fail');
			});
		}
	}	
	
</script>
</html>