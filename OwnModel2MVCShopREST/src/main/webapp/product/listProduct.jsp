<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>상품목록조회</title>

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

		//==> pageNavigator 연동
		function fncPageUp(currentPage) {
			fncGetProductList(currentPage);
		}
		
		//==> 검색 / 페이징
		function fncGetProductList(currentPage)
		{		 
			if ( $(".form-control[name='searchCondition']").val() == "0" )
			{
				if ( isNaN(Number( $(".form-control[name='searchKeyword']").val() )) )
				{
					alert("상품번호에는 숫자만 입력하셔야 합니다.");
					return;
				}
			}

			var startPrice = $(".form-control[name='startSearchRange']");
			var endPrice = $(".form-control[name='endSearchRange']");

			if ( $( "input[aria-label='price']" ).is(":checked") &&
				 ( (startPrice.val() != "") || (endPrice.val() != "") ) )
			{
				if ( isNaN( Number(startPrice.val()) ) ||
					 isNaN( Number( endPrice.val() ) )	)
				{
					alert("상품가격에는 숫자만 입력하셔야 합니다.");
					return;
				}
				else if ( (startPrice.val() < 0) || (endPrice.val() < 0) ) 
				{
					alert("상품가격은 0보다 작을 수 없습니다.");
					return;
				}
				else if ( ( Number(startPrice.val()) > Number(endPrice.val()) ) &&
						  ( (startPrice.val() != "") && (endPrice.val() != "") ) )
				{
					alert("최대금액은 최소금액보다 작을 수 없습니다.");
					return;
				}
			}
			else 
			{
				startPrice.val("");
				endPrice.val("");
			}
			
			$("#currentPage").val(currentPage)
			
			$("form").attr("method", "POST")
					 .attr("action", "/product/listProduct?menu=${param.menu}")
					 .submit();
		}
		
		//==> 검색,상품확인,구매,배경색 Event 처리
		$(function() {
			
			//==> 검색
			$( "button.btn.btn-default" ).bind("click", function() {
				fncGetProductList(1);
			});

			//==> 가격 범위 검색 on/off
			$( "input[aria-label='price']" ).bind('change', function() {

				if ($(this).is(":checked")) {
					$(this).parent().siblings(".form-control").attr("readonly", false);
				} 
				else {
					$(this).parent().siblings(".form-control").attr("readonly", true);
				}
			});
			
			//==> 가격 범위 검색 초기화
			$(function() {
			
				var priceRange = $( "input[aria-label='price']" );
				var startPrice = $(".form-control[name='startSearchRange']");
				var endPrice = $(".form-control[name='endSearchRange']");
			
				if ( (startPrice.val() == "") && (endPrice.val() == "") ) 
				{
					priceRange.attr("checked", false);
					startPrice.val("").attr("readonly", true);
					endPrice.val("").attr("readonly", true);
				}
				else 
				{
					priceRange.attr("checked", true);
					startPrice.attr("readonly", false);
					endPrice.attr("readonly", false);
				}
			});
			
			/* 
			//==> 검색 설정 변경 Event 발생 시 입력 창 변경
			$( "select[name='searchCondition']" ).bind("change", function() {
				
				if ( $(this).val() == '2' ) 
				{
					$("span:has(input[name='searchKeyword'])").css("display", "none");
					$("span:contains('~')").css("display", "inline-block");
				}
				else
				{
					$("span:has(input[name='searchKeyword'])").css("display", "inline-block");
					$("span:contains('~')").css("display", "none");
				}
				
			}); 
			*/
			
			
			//==> manage 일 때 구매된 상품명 click Event
			if ( ${ param.menu == 'manage' } ) 
			{
				$( "tr:has( span:not(:contains('판매중')) ) td:nth-child(2)" ).bind("click", function() {
					
					var prodNo = $(this).siblings(":last").children("i").attr("id");
					self.location = "/product/getProduct?menu=search&prodNo="+prodNo;	
					
				}).css("color", "blue");
				//==> click event 적용된 상품명 색 변경
			}
			
			//==> '판매중' 상품명 click Event 연결 및 처리
			//$( ".ct_list_pop:has(span:contains('판매중')) td:nth-child(3)" ).bind("click", function() {
			$( "tr:has(span:contains('판매중')) td:nth-child(2)" ).bind("click", function() {
					
				var prodNo = $(this).siblings(':last').children("i").attr("id");
				
				if ( ${ param.menu == 'manage' } ) 
				{
					self.location = "/product/updateProduct?menu=manage&prodNo="+prodNo;
				}
				else if ( ${ param.menu == 'search' } )
				{
					self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
				}
			
			}).css("color", "red"); 
			//==> click event 적용된 상품명 색 변경
			
			//==> (click:상세정보) 색 변경
			//$("h7").css("color" , "red");
			
			
			//==> 배송하기 click Event -> 상품상태 변경(배송중)
			$( "tr > td > a" ).css("color", "red").bind("click", function() {

				var prodNo = $(this).parent().next().children("i").attr("id");
				var thisProd = $(this);
				
				//self.location = "/purchase/updateTranCodeByProd?tranCode=2&prodNo="+prodNo;
				$.ajax(
						{
							url : "/purchase/json/updateTranCodeByProd/2/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(data , status) {
								
								if (data === false) {
									alert("배송 처리중 오류 발생");
									return;
								}
								
								alert( prodNo + "번 상품 \n배송 요청 완료" );
								thisProd.prev().text("배송중");
								thisProd.text("");
								
							}, 
							error : function() {
								alert("배송 요청 실패");
							}
						}
				);
				// ajax end
			});
			
			
			//==> 간략정보 클릭 시 상세정보 출력
			//$( ".ct_list_pop td:nth-child(1)" ).bind("click", function() {
			$( "td:nth-child(6) > i" ).bind("click", function() {
			
				var prodNo = $(this).attr("id");
				
				$.ajax(
						{
							url : "/product/json/getProduct/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								var displayValue = "<h6>"
													+"상품명 : "+JSONData.prodName+"<br>"
													+"상세정보 : "+JSONData.prodDetail+"<br>"
													+"제조일 : "+JSONData.manuDate+"<br>"
													+"가 격 : "+JSONData.price+"<br>"
													+"등록일 : "+JSONData.regDateString+"<br>"
													+"</h6>";

								var thisProd = $( "i[id='"+prodNo+"']" );
								
								if (thisProd.html() != displayValue) 
								{
									$("h6").remove();
									thisProd.html(displayValue);
								}
								else {
									thisProd.html("");
								}
								
							}
						}
				);
				// ajax end
			});
			
			//==> 짝수번째 row 배경색 변경			
			//$( ".ct_list_pop:odd" ).css("background-color" , "whitesmoke");
			
		});

</script>

</head>

<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->

	<!-- 화면구성 div Start ///////////////////////////////////// -->
	<div class="container">
	
		<div class="page-header text-info">
			<h3>
				<c:if test="${ param.menu == 'manage' }">
					상품관리
				</c:if>
				<c:if test="${ param.menu == 'search' }">
					상품목록조회
				</c:if>
			</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
	    	<div class="col-md-5 text-left">
				<p class="text-primary">
		    		전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
		    	</p>
		    </div>
	    
		    <div class="col-md-7 text-right">
		    	<!-- 검색 form -->
				<form class="form-inline" name="detailForm">
				
					<!-- 정렬기준 -->
					<div class="form-group">
						<select class="form-control" name="sortColumn">
							<option value="0" ${ ! empty search.sortColumn && search.sortColumn==0 ? 'selected' : ''}>등록일</option>
							<option value="1" ${ ! empty search.sortColumn && search.sortColumn==1 ? 'selected' : ''}>상품명</option>
							<option value="2" ${ ! empty search.sortColumn && search.sortColumn==2 ? 'selected' : ''}>상품가격</option>
						</select>
				  	</div>
				  	<!-- 정렬순서 -->
					<div class="form-group">
						<select class="form-control" name="sortOrder">
							<option value="0" ${ ! empty search.sortOrder && search.sortOrder==0 ? 'selected' : ''}>오름차순</option>
							<option value="1" ${ ! empty search.sortOrder && search.sortOrder==1 ? 'selected' : ''}>내림차순</option>
						</select>
				  	</div>
					&nbsp;
						
					<!-- 검색기준 -->
					<div class="form-group">
						<select class="form-control" name="searchCondition">
							<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? 'selected' : ''}>상품번호</option>
							<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? 'selected' : ''}>상품명</option>
							<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? 'selected' : ''}>상품가격</option>
						</select>
				  	</div>
				  	<!-- 검색어 -->
					<div class="form-group" <%-- style="display:${ search.searchCondition==2 ? 'none' : 'inline-block'};" --%>>
						<label class="sr-only" for="searchKeyword">검색어</label>
						<input type="text" class="form-control" name="searchKeyword" placeholder="검색어"
								value="${ ! empty search.searchKeyword ? search.searchKeyword : '' }">
					</div>
					  	
					<!-- 검색 버튼 -->
					<button type="button" class="btn btn-default">검색</button>


					<!-- 가격 -->
					<div class="form-group text-right" style="margin:8px;">
						<div class="input-group col-md-10">
							<span class="input-group-addon">
								가격범위
								<input type="checkbox" aria-label="price">
							</span>
							<input type="text" class="form-control" name="startSearchRange"
									placeholder="최소금액" value="${search.startSearchRange}">
				      		<div class="input-group-addon"> ~ </div>
							<input type="text" class="form-control" name="endSearchRange"
									placeholder="최대금액" value="${search.endSearchRange}">
						</div>
					</div>
					
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					
				</form>
			</div>
			
	    </div>
	    <!-- table 위쪽 검색 end /////////////////////////////////////-->
		
	    <!-- table Start /////////////////////////////////////-->
      	<table class="table table-hover table-striped">
      
      		<thead>
				<tr>
		            <th align="center">No</th>
		            <th align="left">상품명</th>
		            <th align="left">가격</th>
		            <th align="left">등록일</th>
		            <th align="left">현재상태</th>
		            <th align="left">간략정보</th>
	          	</tr>
			</thead>
      
			<tbody>
				<!-- 상품 정보 목록 출력 -->
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					
					<tr>
					  	<td align="center">${ i }</td>
					  	<td align="left" title="Click : 상품정보 확인">
					  		${product.prodName}
					  	</td>
					  	<td align="left">${product.price}</td>
					  	<td align="left">${product.regDate}</td>
					  	<td>
							<span>
								<c:if test="${ param.menu=='manage' }">${product.proTranCodeString}</c:if>
								<c:if test="${ param.menu=='search' }">
									${ (empty product.proTranCode) ? '판매중' : '재고 없음' }
								</c:if>
							</span>
							<a>
								${ (param.menu=='manage' && product.proTranCode=='1') ? '배송하기' : '' }
							</a>
					  	</td>
					  	<td align="left">
					  		<i class="glyphicon glyphicon-ok" id="${product.prodNo}"></i>
					  		<input type="hidden" value="${product.prodNo}">
					  	</td>
					</tr>
					
				</c:forEach>
			</tbody>
			
      	</table>
		<!-- table End ///////////////////////////////////// -->
	  
	</div>
 	<!--  화면구성 div End ///////////////////////////////////// -->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator.jsp"/>
	<!-- PageNavigation End... -->

</body>

</html>