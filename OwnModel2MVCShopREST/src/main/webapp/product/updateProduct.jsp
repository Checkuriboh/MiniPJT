<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>상품정보수정</title>

	<!-- 참조 : http://getbootstrap.com/css/ 참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Date-Picker Plugin -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
	
	
	<!-- //////////////////////// CSS //////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
    </style>
    
	<!-- //////////////////// JavaScript //////////////////// -->
	<script type="text/javascript">
	
		//Form 유효성 검증
		function fncUpdateProduct()
		{
			var name = $(".form-control[name='prodName']").val();
			var detail = $(".form-control[name='prodDetail']").val();
			var manuDate = $(".form-control[name='manuDate']").val();
			var price = $(".form-control[name='price']").val();
		
			if ( name == null || name.length < 1 ) {
				alert("상품명은 반드시 입력하여야 합니다.");
				return;
			}
			if ( detail == null || detail.length < 1 ) {
				alert("상품상세정보는 반드시 입력하여야 합니다.");
				return;
			}
			if ( manuDate == null || manuDate.length < 1 ) {
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if ( price == null || price.length < 1 ) {
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}
			else if ( isNaN(Number(price)) ) {
				alert("가격에는 숫자만 입력하셔야 합니다.");
				return;
			}
	
			$("form").attr("method", "POST")
					 .attr("enctype", "multipart/form-data")
					 .attr("action", "/product/updateProduct")
					 .submit();
		}
		
		//==> Event 발생 처리
		$(function() {
			
			//==> "수정" Event 연결
			$( "button.btn-primary" ).bind("click" , function() {
				fncUpdateProduct();
			});
			
			//==> "취소" Event 처리 및 연결
			$( "form-group a[href='#']" ).bind("click" , function() {
				$("form")[0].reset();
			});

			//==> 제조일자 달력 버튼 클릭 Event
			$("#dateBtn").datepicker({
				format: 'yyyy-mm-dd',
		        endDate: '0d',
		        autoclose: true,
		        todayHighlight: true
			})	// 버튼으로 날짜 선택 시 text에 적용
			.bind("changeDate", function(date) {
				$(".form-control[name='manuDate']").val(date.format(0, "yyyy-mm-dd"));
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
			<h3 class="text-info">상품정보수정</h3>
	    </div>
	    
		<!-- form Start ////////////////////////////////////////// -->
		<form class="form-horizontal">
		
			<!-- 상품번호 -->
			<input type="hidden" name="prodNo" value="${product.prodNo}"/>
		
			<!-- 상품명 -->
			<div class="form-group">
				<label for="prodName" class="col-sm-2 control-label">상품명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="prodName" 
							placeholder="상품명" value="${product.prodName}">
				</div>
			</div>
			
			<hr/>
			
			<!-- 상품상세정보 -->
			<div class="form-group">
				<label for="prodDetail" class="col-sm-2 control-label">상품상세정보</label>
				<div class="col-sm-6">
    				<textarea class="form-control" name="prodDetail" rows="3" 
    						placeholder="상품상세정보">${product.prodDetail}</textarea>
				</div>
			</div>
			
			<hr/>
			
			<!-- 제조일자 -->			
			<div class="form-group">
				<label for="manuDate" class="col-sm-2 control-label">제조일자</label>
				<div class="col-sm-3">
				    <div class="input-group">
				      	<input type="text" class="form-control" name="manuDate" 
				      			placeholder="YYYY-MM-DD or yyyyMMdd" value="${product.manuDate}">
				      	<span class="input-group-btn" data-date-end-date="0d">
				        	<button class="btn btn-default" type="button" id="dateBtn">
								<i class="glyphicon glyphicon-calendar"></i>
							</button>
				      	</span>
			    	</div>
				</div>
		    </div>
		    
		    <hr/>
		
			<!-- 가격 -->
			<div class="form-group">
				<label for="price" class="col-sm-2 control-label">가격</label>
				<div class="col-sm-3">
					<div class="input-group">
					  	<input type="text" class="form-control" name="price" value="${product.price}">
		      			<div class="input-group-addon">￦</div>
					</div>
				</div>
			</div>
		    
		    <hr/>

		    <!-- 상품이미지 -->
			<div class="form-group">
			    <label for="fileData" class="col-sm-2 control-label">상품이미지</label>
			    <div class="col-sm-3">
				    <input type="file" name="fileData">
					<img src="/product/json/getImageFile/${product.fileName}" alt="..." 
							class="img-rounded" style="margin-top:10px; margin-right:10px;">
				</div>
			</div>
		    
		    <hr/>
		    
			<!-- 등록/취소 결정 -->
		  	<div class="form-group">
			    <div class="col-sm-offset-4 col-sm-4 text-center">
			      <button type="button" class="btn btn-primary">수&nbsp;정</button>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
			    </div>
		  	</div>
			
		</form>
		<!-- form end ////////////////////////////////////////// -->
		
 	</div>
 	<!-- 화면구성 div end ////////////////////////////////////// -->

</body>

</html>