<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
	<meta charset="EUC-KR">
	<title>��ǰ �����ȸ</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">	

		//==> pageNavigator ����
		function fncPageUp(currentPage) {
			fncGetProductList(currentPage);
		}

		//==> �˻� / ����¡
		function fncGetProductList(currentPage)
		{	
			if ( isNaN(Number( $(".ct_input_g[name='searchKeyword']").val() )) )
			{
				if ($(".ct_input_g[name='searchCondition']").val() == "0")
				{
					alert("��ǰ��ȣ���� ���ڸ� �Է��ϼž� �մϴ�.");
					return;
				}
				if ($(".ct_input_g[name='searchCondition']").val() == "2")
				{
					alert("��ǰ���ݿ��� ���ڸ� �Է��ϼž� �մϴ�.");
					return;
				}
			}
			$("#currentPage").val(currentPage)
			
			$("form").attr("method", "POST")
					 .attr("action", "/product/listProduct?menu=${param.menu}")
					 .submit();
		}
		
		
		//==> �˻�,��ǰȮ��,����,���� Event ó��
		$(function() {
			
			//==> �˻�
			$( "td.ct_btn01:contains('�˻�')" ).bind("click", function() {
				fncGetProductList(1);
			});
			
			//==> (menu=search) ��ǰ��ȣ Ŭ�� Event -> ��ǰ���� Ȯ��/����
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
			
			//==> ��ǰ��ȣ + click �ּ� �� ����
			$( ".ct_list_pop td:nth-child(4) , h7" ).css("color" , "red");

			//==> ¦����° row ���� ����			
			$( ".ct_list_pop:odd" ).css("background-color" , "whitesmoke");
			
			//==> ����ϱ� click Event -> ��ǰ���� ����(�����)
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
							��ǰ ����
						</c:if>
						<c:if test="${ param.menu == 'search' }">
							��ǰ �����ȸ
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
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? 'selected' : ''}>��ǰ��ȣ</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? 'selected' : ''}>��ǰ��</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? 'selected' : ''}>��ǰ����</option>
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
						�˻�
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
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			��ǰ��<br> <h7>(click:������)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
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
						${ (empty product.proTranCode) ? '�Ǹ���' : '��� ����' }
					</c:if>
				</span>
				<a>
					${ (param.menu=='manage' && product.proTranCode=='1') ? '����ϱ�' : '' }
				</a>
			</td>
		</tr>
	
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
		
	</c:forEach>

</table>

<!-- ������ �׺������ -->
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