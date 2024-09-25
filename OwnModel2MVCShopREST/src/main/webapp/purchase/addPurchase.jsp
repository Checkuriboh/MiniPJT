<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매성공</title>
</head>

<body>

다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td> ${purchase.purchaseProd.prodNo} </td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td> ${purchase.buyer.userId} </td>
		<td></td>
	</tr>
	<tr>
		<td>구매방법</td>
		<td>
			<c:if test="${ purchase.paymentOption == '1' }"> 현금구매 </c:if>
			<c:if test="${ purchase.paymentOption == '2' }"> 신용구매 </c:if>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자이름</td>
		<td> ${purchase.receiverName} </td>
		<td></td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td> ${purchase.receiverPhone} </td>
		<td></td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td> ${purchase.divyAddr} </td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td> ${purchase.divyRequest} </td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td> ${purchase.divyDate} </td>
		<td></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="/purchase/listPurchase">확인</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>
