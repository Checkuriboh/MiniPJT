<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>구매목록조회</title>

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
    
	<script type="text/javascript">
	
		//==> pageNavigator 연동
		function fncPageUp(currentPage) {
			fncGetPurchaseList(currentPage);
		}
		
		function fncGetPurchaseList(currentPage) {
			$("#currentPage").val(currentPage)
			document.detailForm.submit();
		}
	
	</script>

</head>

<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="13" >전체 ${resultPage.totalCount} 건수, 현재 ${search.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">정보수정</td>
	</tr>
	<tr>
		<td colspan="13" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		
		<tr class="ct_list_pop">
			<td align="center">
				${i}
			</td>
			<td></td>
			<td align="left">
				<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">
					${purchase.tranNo}
				</a>
			</td>
			<td></td>
			<td align="left">
				<a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo}&menu=ok">
					${purchase.purchaseProd.prodName}
				</a>
			</td>
			<td></td>
			<td align="left"> ${purchase.receiverName} </td>
			<td></td>
			<td align="left"> ${purchase.receiverPhone} </td>
			<td></td>
			<td align="left">현재 ${purchase.purchaseProd.proTranCodeString} 상태 입니다.</td>
			<td></td>
			<td align="left">
				<c:if test="${ purchase.tranCode == '2' }">
					<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">
						물건도착
					</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="13" bgcolor="D6D7D6" height="1"></td>
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

</div>

</body>
</html>
