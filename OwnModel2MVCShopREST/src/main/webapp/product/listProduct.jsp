<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
	<meta charset="EUC-KR">
	<title>상품 목록조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">	

		//==> pageNavigator 연동
		function fncPageUp(currentPage) {
			fncGetProductList(currentPage);
		}

		//==> 검색 / 페이징
		function fncGetProductList(currentPage)
		{	
			if ( isNaN(Number( $(".ct_input_g[name='searchKeyword']").val() )) )
			{
				if ($(".ct_input_g[name='searchCondition']").val() == "0")
				{
					alert("상품번호에는 숫자만 입력하셔야 합니다.");
					return;
				}
				if ($(".ct_input_g[name='searchCondition']").val() == "2")
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
			
			//==> (menu=search) 상품번호 클릭 Event -> 상품정보 확인/수정
			$( ".ct_list_pop td:nth-child(4)" ).bind('click', function() {
				
				var prodNo = $(this).parent().children(":first").val();
				
				if ( ${ param.menu == 'search' } )
				{
					self.location = "/product/getProduct?menu=search&prodNo="+prodNo;
				}
				else if ( ${ param.menu == 'manage' } ) 
				{
					self.location = "/product/updateProduct?menu=manage&prodNo="+prodNo;
				}
				
			});
			
			//==> 상품번호 + click 주석 색 변경
			$( ".ct_list_pop td:nth-child(4) , h7" ).css("color" , "red");

			//==> 짝수번째 row 배경색 변경			
			$( ".ct_list_pop:odd" ).css("background-color" , "whitesmoke");
			
			//==> 배송하기 click Event -> 상품상태 변경(배송중)
			$( ".ct_list_pop a" ).bind('click', function() {
				var prodNo = $(this).parent().parent().children(":first").val();
				self.location = "/purchase/updateTranCodeByProd?tranCode=2&prodNo="+prodNo;
			});
			
		});

</script>

</head>

<body bgcolor="#ffffff" text="#000000" style="margin:10px;">

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
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px" >
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? 'selected' : ''}>상품번호</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? 'selected' : ''}>상품명</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? 'selected' : ''}>상품가격</option>
			</select>				
			<input 	type="text" name="searchKeyword"  value="${search.searchKeyword}" 
					class="ct_input_g" style="width:200px; height:19px" >
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
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		
		<tr class="ct_list_pop">
			<input type="hidden" name="prodNo" value="${product.prodNo}">
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
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
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