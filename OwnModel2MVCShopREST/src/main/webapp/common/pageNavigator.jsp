<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	//==> pageNavigator ����
	$(function() {
		
		// ������ ��ȣ ����
		$("nav a").slice(2,-2).bind('click', function() {
			fncPageUp( $(this).text().trim() );
		})
		
		// ù��° ������
		$("nav a:first").bind('click', function() {
			fncPageUp( 1 );
		})
		
		// ������ ������
		$("nav a:last").bind('click', function() {
			fncPageUp( ${resultPage.maxPage} );
		})
		
		// ���� ������ Unit
		$("nav a").eq(1).bind('click', function() {
			fncPageUp( ${ resultPage.beginUnitPage - 1 } );
		})
		
		// ���� ������ Unit
		$("nav a").eq(-2).bind('click', function() {
			fncPageUp( ${ resultPage.beginUnitPage + resultPage.pageUnit } );
		})
		
	});

</script>

<nav>
	
	<a>&lt;&lt;</a>
	&nbsp;
	
	<c:if test="${ resultPage.beginUnitPage > resultPage.pageUnit }">
		<a>&lt;</a>
	</c:if>
	<c:if test="${ !(resultPage.beginUnitPage > resultPage.pageUnit) }">
		<a></a>&nbsp;
	</c:if>
	
	&nbsp;
	<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
		<a>
			${ (resultPage.currentPage == i) ? '<b>'  : '' }
				${i}
			${ (resultPage.currentPage == i) ? '</b>' : '' }
		</a>
	</c:forEach>
	&nbsp;
	
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
		<a>&gt;</a>
	</c:if>
	<c:if test="${ !(resultPage.endUnitPage < resultPage.maxPage) }">
		<a></a>&nbsp;
	</c:if>
	
	&nbsp;
	<a>&gt;&gt;</a>
	
</nav>
