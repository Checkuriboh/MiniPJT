<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	//==> pageNavigator 연동
	$(function() {
		
		// 이전 페이지 Unit
		$( "nav :not(.disabled) > [aria-label='Previous']" ).bind('click', function() {
			fncPageUp( ${ resultPage.beginUnitPage - 1 } );
		});
		
		// 페이지 번호 선택
		$( "nav [aria-label='Paging']" ).bind('click', function() {
			fncPageUp( $(this).text().trim() );
		});
		
		// 다음 페이지 Unit
		$( "nav :not(.disabled) > [aria-label='Next']" ).bind('click', function() {
			fncPageUp( ${ resultPage.beginUnitPage + resultPage.pageUnit } );
		});
		

		// 첫번째 페이지
		$( "nav .pager .previous" ).bind('click', function() {
			fncPageUp( 1 );
		});
		
		// 마지막 페이지
		$( "nav .pager .next" ).bind('click', function() {
			fncPageUp( ${resultPage.maxPage} );
		});
		
	});

</script>

<!-- pagination -->
<div class="container text-center">
		 
	<nav>
		<!-- 크기조절 : pagination-lg pagination-sm-->
		<ul class="pagination">
		    
			<!-- 좌측 -->
		    <li class="${ (resultPage.currentPage > resultPage.pageUnit) ? '' : 'disabled' }">
		        <span aria-label="Previous">&laquo;</span>
		   	</li>
		   	
		    <!-- 중앙 -->
			<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<li class="${ (resultPage.currentPage == i) ? 'active' : '' }">
				    <span aria-label="Paging">${ i }</span>
				</li>
			</c:forEach>
		    
			<!-- 우측 -->
		    <li class="${ (resultPage.endUnitPage < resultPage.maxPage) ? '' : 'disabled' }">
		        <span aria-label="Next">&raquo;</span>
		   	</li>

		</ul>
	</nav>
		
</div>

<!-- 첫번째/마지막 페이지 -->
<div class="container">
	<nav>
		<ul class="pager">
		
			<li class="previous">
		    	<a href="#">
					<span aria-hidden="true">&larr;</span> 
					Older
				</a>
			</li>
		     
		    <li class="next">
		    	<a href="#">
			    	Newer 
			    	<span aria-hidden="true">&rarr;</span>
		    	</a>
		    </li>
		    
		</ul>
	</nav>
</div>
