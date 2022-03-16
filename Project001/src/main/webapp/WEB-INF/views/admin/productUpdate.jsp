<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
    
    <!-- reset CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />

    <!-- index/css -->
    <link rel="stylesheet" href="/resources/css/admin/productReg.css"> 
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>${product.productName }</title>
</head>
<body>
<!-- header -->
<%@include file="../includes/admin/header.jsp" %>

<!-- content -->
<div class="content" style="display: flex;">
  <%@include file="../includes/admin/admin_menu.jsp" %>
  
  <%-- <div class="wrapper">
    <div class="wrap">
      <form id="productUpdate_form" action="/admin/productUpdate" method="post">
        <input type="hidden" name="page" value="${page }">
        <div class="wrap_num">
          <span>상품 번호 : ${product.productNo }</span>
          <input type="hidden" name="productNo" value="${product.productNo }">
        </div>
        <div class="wrap_name">
          <span>상품명</span>
          <input type="text" name="productName" value="${product.productName }">
        </div>
        <div class="wrap_category">
          <span>카테고리</span>
            <select name="productCategory">
              <option value="none" selected>=== 선택 ===</option>
              <option value="FINE FRAGRANCES">FINE FRAGRANCES</option>
              <option value="HOME CREATIONS">HOME CREATIONS</option>
              <option value="BODY - HAIR - FACE">BODY - HAIR - FACE</option>
              <option value="GROOMING">GROOMING</option>
            </select>
        </div>
        <div class="wrap_price">
          <span>가격</span>
          <input type="number" name="productPrice" value="${product.productPrice }"> 원
        </div>
        <div class="wrap_amount">
          <span>수량</span>
          <input type="number" name="productAmount" value="${product.productAmount }"> 개
        </div>
        <div>
          <fmt:formatDate value="${product.productRegDate }" 
            pattern="yyyy년MM월dd일 HH시mm분ss초" var="productRegDate"/>
          <span>작성일 : ${productRegDate }</span>
        </div>
        <div class="wrap_prointro">
          <span>상품 소개</span><br>
          <textarea rows="20" cols="40" style="resize: none;" name="productIntro">${product.productIntro }</textarea>
        </div>
        <div>
          <input type="submit" class="btn_update" value="수정">
          <a href="productDetail?productNo=${product.productNo }&page=${pageMaker.criteria.page}"><input type="button" value="취소"></a>
        </div>
      </form>
    </div>
  </div> --%>
  
   <div class="wrapper">
    <div class="wrap">
      <form id="productUpdate_form" action="/admin/productUpdate" method="post" enctype="multipart/form-data">
        <div class="col-md-7 col-lg-8 content_wrap">
          <div class="row g-3">
            <div class="product_name">
              <h3>${product.productName }</h3>
            </div>
            
            
            <div class="col-12">
              <label for="productImg" class="form-label">상품 이미지</label>
              <input type="file" id="productImg" name="file" />
              <div class="input-group has-validation select_img">
                <img width="50%" src="/resources${product.productImg }">
                <input type="hidden" name="productImg" value="${product.productImg }" />
              </div>
            </div>
            
      
            <div class="col-12">
              <label for="productNo" class="form-label">상품 번호</label>
              <div class="input-group has-validation">
                <input class="form-control" id="productNo" value="${product.productNo }" readonly="readonly" name="productNo">
              </div>
            </div>
      
            <div class="col-12">
              <label for="productName" class="form-label">상품명</label>
              <input class="form-control" id="productName" value="${product.productName }" name="productName">
            </div>
      
            <div class="col-12">
              <label for="productCategory" class="form-label">카테고리</label>
              <input class="form-control" id="productCategory" value="${product.cateCode }" readonly="readonly" name="cateCode">
            </div>
      
            <div class="col-12">
              <label for="proudctPrice" class="form-label">가격</label>
              <input class="form-control" id="productPrice" value="<fmt:formatNumber value="${product.productPrice}"/>" name="productPrice">
            </div>
            
            <div class="col-12">
              <label for="productAmount" class="form-label">수량</label>
              <input class="form-control" id="productPrice" value="<fmt:formatNumber value="${product.productAmount }"/>" name="productAmount">
            </div>
            
            <div class="col-12">
              <label for="productRegDate" class="form-label">등록 날짜</label>
              <fmt:formatDate value="${product.productRegDate }" 
                pattern="yyyy년MM월dd일 HH시mm분ss초" var="productRegDate"/>
              <input class="form-control" id="productPrice" value="${productRegDate }" readonly="readonly">
            </div>
            
            <div class="col-12">
              <label for="productIntro" class="form-label">상품 소개</label>
              <textarea class="form-control" rows="10" cols="50" style="resize: none;" name="productIntro">${product.productIntro }</textarea >
            </div>
      
          </div>
      
        <div class="detail_btn">
          <button type="submit" id="btn_update" class="btn_update btn btn-outline-primary me-2 ">수정</button>
          <a href="productDetail?productNo=${product.productNo }&page=${pageMaker.criteria.page}"><button type="button" id="btn_del" class="btn btn-outline-primary me-2">삭제</button></a>
        </div>
        
      </div>
    </form>
    </div>
  </div>
  
  
</div>

<script type="text/javascript">

/* 이미지 관련 start */
$("#product_img").change(function(){
if(this.files && this.files[0]) {
 var reader = new FileReader;
 reader.onload = function(data) {
  $(".select_img img").attr("src", data.target.result).width(500);        
 }
 reader.readAsDataURL(this.files[0]);
}
});
/* End */

</script>

<!-- footer -->
<%@include file="../includes/admin/footer.jsp" %>
</body>
</html>

















