<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>���ż���</title>
</head>

<body>

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td> ${purchase.purchaseProd.prodNo} </td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td> ${purchase.buyer.userId} </td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
			<c:if test="${ purchase.paymentOption == '1' }"> ���ݱ��� </c:if>
			<c:if test="${ purchase.paymentOption == '2' }"> �ſ뱸�� </c:if>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td> ${purchase.receiverName} </td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td> ${purchase.receiverPhone} </td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td> ${purchase.divyAddr} </td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td> ${purchase.divyRequest} </td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
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
						<a href="/purchase/listPurchase">Ȯ��</a>
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
