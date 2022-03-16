<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    
    <!-- reset CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />

    <!-- index/css -->
    <link rel="stylesheet" href="/resources/css/admin/productReg.css">  
    
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
<style type="text/css">
.wrap {
  padding: 60px;
}
.btn_section {
  margin: 40px 0;
}
#insertBtn {
  color : black;
  border-color: black;
}
#insertBtn:active {
  color : white;
  background-color: green !important;
  border-color: green !important;
}
#insertBtn:hover {
  color : white;
  background-color: green !important;
  border-color: green !important;
}
#cancelBtn {
  color : black;
  border-color: black;
}
#cancelBtn:active {
  color : white;
  background-color: red !important;
  border-color: red !important;
}
#cancelBtn:hover {
  color : white;
  background-color: red !important;
  border-color: red !important;
}
    </style>
    
<title>상품 등록</title>
</head>
<body>
<!-- header -->
<%@include file="../includes/admin/header.jsp" %>

<!-- content -->
<div class="content" style="display: flex;" >
  <%@include file="../includes/admin/admin_menu.jsp" %>

    <div class="wrap">
      <div class="productReg_wrap">
        <form id="productReg_form" method="POST" enctype="multipart/form-data">
          <div class="col-md-7 col-lg-8 content_wrap">
            <div class="row g-3">
          <div class="title">
            <h3>상품 등록하기</h3>
          </div>
          <hr>
          
          
          <!-- <div class="inputArea">
           <label for="product_img">이미지</label>
           <input type="file" id="product_img" name="file" />
           <div class="select_img"><img src="" /></div>
          </div> -->
          
          <div class="form_sectioin_img">
            <input type="file" multiple id="fileItem" name='uploadFile' style="height: 30px;">
          </div>
          
          
          <div class="form_section_pname">
            <div class="col-12 form_section_title">
              <label for="productNo" class="form-label">상품명</label>
            </div>
            <div class="input-group has-validation form_section_content">
              <input class="form-control" type="text" name="productName" placeholder="상품명을 입력해주세요.">
              <span class="warn_productName">상품명을 입력해주세요.</span>
            </div>
          </div>
          
          <div class="form_section_category">
            <div class="col-12 form_section_title">
              <label for="productNo" class="form-label">카테고리</label>
            </div>
            <div class="form_section_content">
              <div class="cate_wrap">
    				<span>대분류</span>
    				<select class="form-control cate1">
    					<option selected value="none">&nbsp;▼ 선택</option>
    				</select>
    			</div>
    			<div class="cate_wrap">
    				<span>중분류</span>
    				<select class="form-control cate2">
    					<option selected value="none">&nbsp;▼ 선택</option>
    				</select>
    			</div>
    			<div class="cate_wrap">
    				<span>소분류</span>
    				<select class="form-control cate3" name="cateCode">
    					<option selected value="none">&nbsp;▼ 선택</option>
    				</select>
    			</div> 
              <span class="warn_category">카테고리를 선택해주세요.</span>
            </div>
          </div>
          
          <div class="form_section_price">
            <div class="col-12 form_section_title">
              <label for="proudctPrice" class="form-label">가격</label>
            </div>
            <div class="form_section_content">
              <input class="form-control" type="number" name="productPrice" placeholder="가격을 입력해주세요.">
              <span class="warn_price">가격을 입력해주세요.</span>
            </div>
          </div>
          
          <div class="form_section_amount">
            <div class="col-12 form_section_title">
              <label for="productAmount" class="form-label">수량</label>
            </div>
            <div class="form_section_content">
              <input class="form-control" type="number" name="productAmount" min="0" placeholder="수량을 입력해주세요.">
              <span class="warn_amount">수량을 입력해주세요.</span>
            </div>
          </div>
          
          <div class="form_section_prointro">
            <div class="col-12 form_section_title">
              <label for="productIntro" class="form-label">상품소개</label>
            </div>
            <div class="form_section_content">
              <textarea class="form-control" rows="10" cols="50" style="resize: none;" name="productIntro" placeholder="상품소개를 입력해주세요."></textarea>
              <span class="warn_proIntro">상품소개를 입력해주세요.</span>
            </div>
          </div>
          
          <hr style="margin-top: 40px;">
          
        </div>
      </div>
    </form>
    </div>
    
    
    <div class="btn_section">
      <button type="button" id="cancelBtn" class="btn btn-outline-primary me-2 cancel_btn">취소</button>
      <button type="button" id="insertBtn" class="btn btn-outline-primary me-2 insert_btn">등록</button>
    </div>
  </div>
</div>  

  <script type="text/javascript">
  $(document).ready(function(){
      $('#insertBtn').click(function(){
    	  
    	  // 검사 통과 유무 변수
    	  let nameCheck = false; // 상품명
    	  let categoryCheck = false; // 상품 카테고리
    	  let priceCheck = false; // 상품 가격
    	  let amountCheck = false; // 상품 수량
    	  let introCheck = false; // 상품 소개
    	  
    	  // 입력값 변수
    	  let pName = $('input[name=productName]').val(); // 상품명
    	  let category = $('select[name=cateCode]').val(); // 상품 카테고리
    	  let price = $('input[name=productPrice]').val(); // 상품 가격
    	  let amount = $('input[name=productAmount]').val(); // 상품 수량
    	  let proIntro = $('textarea[name=productIntro]').val(); // 상품 소개
    	  
    	  // 상품명 공란 체크
    	  if(pName === ""){
    		  $('.warn_productName').css('display', 'block');
    		  nameCheck = false;
          } else{
              $('.warn_productName').css('display', 'none');
              nameCheck = true;
    	  }
    	  
    	  // 상품 카테고리 공란 체크
    	  if(category === "none"){
    		  $('.warn_category').css('display', 'block');
    		  categoryCheck = false;
          } else{
              $('.warn_category').css('display', 'none');
              categoryCheck = true;
    	  }
    	  
    	  // 상품 가격 공란 체크
    	  if(price === ""){
    		  $('.warn_price').css('display', 'block');
    		  priceCheck = false;
          } else{
              $('.warn_price').css('display', 'none');
              priceCheck = true;
    	  }
    	  
    	  // 상품 수량 공란 체크
    	  if(amount === ""){
    		  $('.warn_amount').css('display', 'block');
    		  amountCheck = false;
          } else{
              $('.warn_amount').css('display', 'none');
              amountCheck = true;
    	  }
    	  
    	  // 상품 소개 공란 체크
    	  if(proIntro === ""){
    		  $('.warn_proIntro').css('display', 'block');
    		  introCheck = false;
          } else{
              $('.warn_proIntro').css('display', 'none');
              introCheck = true;
    	  }
    	  
    	  if(nameCheck&&categoryCheck&&priceCheck&&amountCheck&&introCheck){
    			$('#productReg_form').attr("action", "/admin/productReg")
  	  	    	$('#productReg_form').submit();
    	  } else {
    		  return;
    	  }
    	  
    	
      }); // end insertBtn.click()
      
      $('#cancelBtn').click(function(){
    	  location = '/admin/productList'
      });
      
      
      
  }); // end document()
  
  // category
  // 서버로 부터 전달 받은 JSON 데이터를 javacsript가 바로 사용할 수 없음
  // JSON 데이터를 자바스크립트 객체로 변환해주어야 함.
  // 자바스크립트에서는 JSON 문자열 데이터를 자바크립트 객체로 변화해주는 메소드 제공
  let cateList = JSON.parse('${cateList}')
  
  // 등급에 맞게 분류하여 배열에 저장
  let cate1Array = new Array();
  let cate2Array = new Array();
  let cate3Array = new Array();
  let cate1Obj = new Object();
  let cate2Obj = new Object();
  let cate3Obj = new Object();
  
  let cateSelect1 = $(".cate1");		
  let cateSelect2 = $(".cate2");
  let cateSelect3 = $(".cate3");
  
  /* 카테고리 배열 초기화 메서드 */
	function makeCateArray(obj,array,cateList, tier){
		for(let i = 0; i < cateList.length; i++){
			if(cateList[i].tier === tier){
				obj = new Object();
				
				obj.cateName = cateList[i].cateName;
				obj.cateCode = cateList[i].cateCode;
				obj.cateParent = cateList[i].cateParent;
				
				array.push(obj);				
				
			}
		}
	}	
  
	/* 배열 초기화 */
	makeCateArray(cate1Obj,cate1Array,cateList,1);
	makeCateArray(cate2Obj,cate2Array,cateList,2);
	makeCateArray(cate3Obj,cate3Array,cateList,3);
	
	
	$(document).ready(function(){
		console.log(cate1Array);
		console.log(cate2Array);
		console.log(cate3Array);
	});
	
	
	 // 대분류
	for(let i = 0; i < cate1Array.length; i++){
		cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
	}
	 
	 
	// 중분류
	// 대분류의 옵션이 선택이 되었을 때 출력이 되도록 함
	// 대분류 옵션이 선택 되었을 때 실행하는 메서드
	$(cateSelect1).on("change",function(){
		// 대분류 선택 값을 가져오기
		// <option> 태그를 모두 지우고 다시 추가하는 이유는
		// 사용자가 대분류 선택해 다시 다른 대 분류를 선택했을 때
		// 기존의 <option> 태그를 없애기 위함
		
		// 대분류 선택 값을 가져오는 코드
		let selectVal1 = $(this).find("option:selected").val();	
		
		// 중분류 <option>태그를 지우고 기본적인 <option>태그를 추가하는 코드를 추가함.
		cateSelect2.children().remove();
		cateSelect2.append("<option value='none'>선택</option>");
		
		cateSelect3.children().remove();
		cateSelect3.append("<option value='none'>선택</option>");
		
		// 대분류 선택 값과 일치하는 'cateParent' 값을 가진 중분류 <option> 태그를 출력하는 코드를 추가
		for(let i = 0; i < cate2Array.length; i++){
			if(selectVal1 === cate2Array[i].cateParent){
				cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");	
			}
		}// for
	});
	
	// 소분류
	// 중분류와 동일한 형태의 코드를 작성해야 함
	// 소분류 <option> 태그가 출력되어야 할 시점은
	// 중분류를 선택했을 때.
	$(cateSelect2).on("change",function(){
		// 중분류의 선택 값을 가져오는 코드를 추가
		let selectVal2 = $(this).find("option:selected").val();
		
		// 소분류 <option> 태그를 모두 지우고, 기본 <option> 태그를 추가하는 코드
		// 대분류가 변경되었을 때도 소분류가 초기화 되도록 코드
		// 중분류 <option> 태그를 출력하는 메서드(대분류가 변경되었을 때 동작)에 아래의 코드
		cateSelect3.children().remove();
		cateSelect3.append("<option value='none'>선택</option>");		
		
		// 소분류 <option>을 출력하는 코드
		for(let i = 0; i < cate3Array.length; i++){
			if(selectVal2 === cate3Array[i].cateParent){
				cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");	
			}
		}// for		
		
	});
	
   /* 이미지 업로드 */
   $("input[type='file']").on("change", function(e){
       alert("동작");
   });
	 

  </script>
  
</body>
<!-- footer -->
<%@include file="../includes/admin/footer.jsp" %>
</html>







