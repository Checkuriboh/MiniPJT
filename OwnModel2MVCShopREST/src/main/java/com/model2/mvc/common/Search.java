package com.model2.mvc.common;


//==>리스트화면을 모델링(추상화/캡슐화)한 Bean 
public class Search {
	
	///Field
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;
	//==> 리스트화면 currentPage에 해당하는 회원정보를 ROWNUM 사용 SELECT 위해 추가된 Field 
	//==> UserMapper.xml 의 
	//==> <select  id="getUserList"  parameterType="search"	resultMap="userSelectMap">
	//==> 참조
	private int startRowNum;
	private int endRowNum;
	//==> 범위 검색용 Field
	private int startSearchRange;
	private int endSearchRange;
	
	
	///Constructor
	public Search() {
	}
	
	
	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	//==> Select Query 시 ROWNUM 마지막 값 
	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize()+1;
	}
	//==> Select Query 시 ROWNUM 시작 값
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}

	//==> 범위 검색용 Field get/set
	public int getStartSearchRange() {
		return startSearchRange;
	}
	public void setStartSearchRange(int startSearchRange) {
		this.startSearchRange = startSearchRange;
	}
	public int getEndSearchRange() {
		return endSearchRange;
	}
	public void setEndSearchRange(int endSearchRange) {
		this.endSearchRange = endSearchRange;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Search [currentPage=");
		builder.append(currentPage);
		builder.append(", searchCondition=");
		builder.append(searchCondition);
		builder.append(", searchKeyword=");
		builder.append(searchKeyword);
		builder.append(", pageSize=");
		builder.append(pageSize);
		builder.append(", startRowNum=");
		builder.append(startRowNum);
		builder.append(", endRowNum=");
		builder.append(endRowNum);
		builder.append(", startSearchRange=");
		builder.append(startSearchRange);
		builder.append(", endSearchRange=");
		builder.append(endSearchRange);
		builder.append("]");
		return builder.toString();
	}

}