<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<script type="text/javascript">

function fncPageUp(pageNum)
{
	document.detailForm.action = "${param.hrefUrl}&currentPage=" + pageNum;
	fncDetailFormSubmit();
}

</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
		
			<a href="javascript:fncPageUp(1);">&lt;&lt;</a>
			&nbsp;
			<c:if test="${ resultPage.beginUnitPage > resultPage.pageUnit }">
				<a href="javascript:fncPageUp(${ resultPage.beginUnitPage - resultPage.pageUnit });">&lt;</a>
			</c:if>
			${ resultPage.beginUnitPage > resultPage.pageUnit ? '' : '&nbsp;' }
			
			&nbsp;
			<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<a href="javascript:fncPageUp(${i});">
					${ resultPage.currentPage==i ? '<b>' : '' }
						${i}
					${ resultPage.currentPage==i ? '</b>' : '' }
				</a>
			</c:forEach>
			&nbsp;
			
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<a href="javascript:fncPageUp(${ resultPage.beginUnitPage + resultPage.pageUnit });">&gt;</a>
			</c:if>
			${ resultPage.endUnitPage < resultPage.maxPage ? '' : '&nbsp;' }
			&nbsp;
			<a href="javascript:fncPageUp(${resultPage.maxPage});">&gt;&gt;</a>
			
    	</td>
	</tr>
</table>

</html>
