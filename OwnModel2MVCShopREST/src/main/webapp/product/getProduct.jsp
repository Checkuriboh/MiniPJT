<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>상품상세조회</title>

	<!-- 참조 : http://getbootstrap.com/css/ 참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- //////////////////////// CSS //////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
    </style>
	
	<!-- //////////////////// JavaScript //////////////////// -->
	<script type="text/javascript">

		//==> Event 발생 처리
		$(function() {

			//==> "구매" Event 처리 및 연결
			$( "button.btn.btn-primary" ).bind("click" , function() {
				self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
			});
			
			//==> "확인" Event 처리 및 연결
			$( "a[href='#']" ).bind("click" , function() {
				history.go(-1);
			});
		
		});
		
	</script>

</head>


<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->
	
	<!-- 화면구성 div Start ///////////////////////////////////// -->
	<div class="container">
	
		<div class="page-header">
			<h3 class=" text-info">상품상세조회</h3>
	    </div>
	
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<img src="/product/json/getImageFile/${product.fileName}"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}&nbsp;원</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<hr/>
		
		<!-- 구매/이전 결정 -->
		<form class="form-horizontal">
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<c:if test="${ (product.proTranCode == null ) && (user.role == 'user') }">
						<button type="button" class="btn btn-primary">구&nbsp;매</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					<a class="btn btn-primary btn" href="#" role="button">확&nbsp;인</a>
				</div>
			</div>
		</form>
		
 	</div>
 	<!-- 화면구성 div end ////////////////////////////////////// -->

</body>

</html>