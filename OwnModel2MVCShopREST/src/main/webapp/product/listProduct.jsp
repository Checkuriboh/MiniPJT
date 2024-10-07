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
	
	<!-- Bootstrap Dropdown Hover CSS -->
   	<link href="/css/animate.min.css" rel="stylesheet">
   	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!-- ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
    </style>

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">	

		//==> pageNavigator 연동
		function fncPageUp(currentPage) {
			fncGetProductList(currentPage);
		}
		
		//==> 검색 / 페이징
		function fncGetProductList(currentPage)
		{	
			if ( $(".ct_input_g[name='searchCondition']").val() == "0" )
			{
				if ( isNaN(Number( $(".ct_input_g[name='searchKeyword']").val() )) )
				{
					alert("상품번호에는 숫자만 입력하셔야 합니다.");
					return;
				}
			}

			if ( $(".ct_input_g[name='searchCondition']").val() == "2" )
			{
				if ( isNaN(Number( $(".ct_input_g[name='endSearchRange']").val() ))	 ||
					 isNaN(Number( $(".ct_input_g[name='startSearchRange']").val() ))	)
				{
					alert("상품가격에는 숫자만 입력하셔야 합니다.");
					return;
				}
			}
			
			$("#currentPage").val(currentPage)
			
			$("form").attr("method", "POST")
					 .attr("action", "/product/listProduct?menu=${param.menu}")
					 .submit();
		}
		
		//==> 검색,상품확인,구매,배경색 Event 처리
		$(function() {
			
			//==> 검색
			$( "td.ct_btn01:contains('검색')" ).bind("click", function() {
				fncGetProductList(1);
			});
			
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

			
			//==> No 클릭 시 상세정보 출력
			$( ".ct_list_pop td:nth-child(1)" ).bind("click", function() {
				
				var prodNo = $(this).parent().next().children("td").attr("id");
				
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
								
								var displayValue = "<h3>"
													+"&nbsp; 상품명 : "+JSONData.prodName+"<br>"
													+"&nbsp; 상세정보 : "+JSONData.prodDetail+"<br>"
													+"&nbsp; 제조일 : "+JSONData.manuDate+"<br>"
													+"&nbsp; 가 격 : "+JSONData.price+"<br>"
													+"&nbsp; 등록일 : "+JSONData.regDateString+"<br>"
													+"</h3>";

								var thisProd = $( "#"+prodNo+"" );
								
								if (thisProd.html() != displayValue) 
								{
									$("h3").remove();
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
			
			
			//==> manage 일 때 구매된 상품명 click Event
			if ( ${ param.menu == 'manage' } ) 
			{
				$( ".ct_list_pop:has(span:not(:contains('판매중'))) td:nth-child(3)" ).bind("click", function() {
					
					var prodNo = $(this).parent().next().children("td").attr("id");
					self.location = "/product/getProduct?menu=search&prodNo="+prodNo;	
					
				}).css("color", "blue");
			}
			
			//==> '판매중' 상품명 click Event 연결 및 처리
			$( ".ct_list_pop:has(span:contains('판매중')) td:nth-child(3)" ).bind("click", function() {
					
				var prodNo = $(this).parent().next().children("td").attr("id");

				if ( ${ param.menu == 'manage' } ) 
				{
					self.location = "/product/updateProduct?menu=manage&prodNo="+prodNo;
				}
				else if ( ${ param.menu == 'search' } )
				{
					self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
				}
			
			}).css("color", "red"); 
			//==> click 가능한 상품명 색 변경
			
			//==> (click:상세정보) 색 변경
			$("h7").css("color" , "red");
			
			
			//==> 배송하기 click Event -> 상품상태 변경(배송중)
			$( ".ct_list_pop a" ).css("color", "red").bind("click", function() {

				var prodNo = $(this).parent().parent().next().children("td").attr("id");
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
			
			
			//==> 짝수번째 row 배경색 변경			
			$( ".ct_list_pop:odd" ).css("background-color" , "whitesmoke");
			
		});

</script>

</head>

<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<c:if test="${ param.menu == 'manage' }">
							상품 관리
						</c:if>
						<c:if test="${ param.menu == 'search' }">
							상품 목록조회
						</c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="left">
			<select name="sortColumn" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.sortColumn && search.sortColumn==0 ? 'selected' : ''}>등록일</option>
				<option value="1" ${ ! empty search.sortColumn && search.sortColumn==1 ? 'selected' : ''}>상품명</option>
				<option value="2" ${ ! empty search.sortColumn && search.sortColumn==2 ? 'selected' : ''}>상품가격</option>
			</select>
			<select name="sortOrder" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.sortOrder && search.sortOrder==0 ? 'selected' : ''}>오름차순</option>
				<option value="1" ${ ! empty search.sortOrder && search.sortOrder==1 ? 'selected' : ''}>내림차순</option>
			</select>
		</td>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px" >
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? 'selected' : ''}>상품번호</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? 'selected' : ''}>상품명</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? 'selected' : ''}>상품가격</option>
			</select>
			
			<span style="display:${ ! empty search.searchCondition && search.searchCondition==2 ? 'none' : 'inline-block'};">
				<input type="text" name="searchKeyword" value="${search.searchKeyword}" 
						class="ct_input_g" style="width:200px; height:19px" />
			</span>
			
			<span style="display:${ ! empty search.searchCondition && search.searchCondition==2 ? 'inline-block' : 'none'}; 
						 width:200px;">
				<input type="text" name="startSearchRange" value="${search.startSearchRange}" 
						class="ct_input_g" style="width:90px; height:19px" /> ~ 
				<input type="text" name="endSearchRange" value="${search.endSearchRange}" 
						class="ct_input_g" style="width:90px; height:19px" />
			</span>
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
		
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			상품명<br> <h7>(click:상세정보)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="500">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		
		<tr class="ct_list_pop">
			<td align="center"> ${i} </td>
			<td></td>
			<td align="left">${product.prodName}</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>
			<td></td>
			<td align="left">
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
		</tr>
		
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1" id="${product.prodNo}"></td>
		</tr>
		
	</c:forEach>

</table>

<!-- 페이지 네비게이터 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<c:if test="${ resultPage.totalCount > 0 }">
				<jsp:include page="/common/pageNavigator.jsp"/>
			</c:if>
			
    	</td>
	</tr>
</table>
	
</form>

</body>

</html>