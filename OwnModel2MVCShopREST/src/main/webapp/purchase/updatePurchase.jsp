<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>구매상품정보수정</title>

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

	<script type="text/javascript" src="../javascript/calendar.js"></script>
	<script type="text/javascript">
		
		function fncUpdatePurchase() {
			document.updatePurchase.submit();
		}
	
	</script>
	
</head>

<body>

	<!-- ToolBar Start ///////////////////////////////////// -->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////// -->

<form name="updatePurchase" method="post" action="/purchase/updatePurchase">

<input type="hidden" name="tranNo" value="${purchase.tranNo}">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매정보수정</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="300" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" width="299">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105"> ${purchase.purchaseProd.prodNo} </td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			구매자아이디 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"> ${purchase.buyer.userId} </td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20">
				<option value="1" ${ purchase.paymentOption=='1' ? 'selected' : '' } >현금구매</option>
				<option value="2" ${ purchase.paymentOption=='2' ? 'selected' : '' } >신용구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" 
						value="${purchase.receiverName}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" 
						value="${purchase.receiverPhone}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="divyAddr" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" 
						value="${purchase.divyAddr}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input	type="text" name="divyRequest" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20"
						value="${purchase.divyRequest}"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">배송희망일</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input 	type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20"
						value="${purchase.divyDate}"/>
			<img 	src="../images/ct_icon_date.gif" width="15" height="15"	
						onclick="show_calendar('document.updatePurchase.divyDate', document.updatePurchase.divyDate.value)"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a href="javascript:fncUpdatePurchase();">수정</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a href="javascript:resetData();">취소</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>