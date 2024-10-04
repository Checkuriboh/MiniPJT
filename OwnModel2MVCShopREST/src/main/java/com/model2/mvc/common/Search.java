package com.model2.mvc.common;


//==>����Ʈȭ���� �𵨸�(�߻�ȭ/ĸ��ȭ)�� Bean 
public class Search {
	
	///Field
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;
	//==> ����Ʈȭ�� currentPage�� �ش��ϴ� ȸ�������� ROWNUM ��� SELECT ���� �߰��� Field 
	//==> UserMapper.xml �� 
	//==> <select  id="getUserList"  parameterType="search"	resultMap="userSelectMap">
	//==> ����
	private int startRowNum;
	private int endRowNum;
	//==> ���� �˻��� Field
	private String startSearchRange;
	private String endSearchRange;
	//==> ��� ���Ŀ� Field
	private String sortColumn;
	private String sortOrder;
	
	
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
	
	//==> Select Query �� ROWNUM ������ �� 
	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize()+1;
	}
	//==> Select Query �� ROWNUM ���� ��
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}

	//==> ���� �˻��� Field get/set
	public String getStartSearchRange() {
		return startSearchRange;
	}
	public void setStartSearchRange(String startSearchRange) {
		this.startSearchRange = startSearchRange;
	}
	public String getEndSearchRange() {
		return endSearchRange;
	}
	public void setEndSearchRange(String endSearchRange) {
		this.endSearchRange = endSearchRange;
	}

	//==> ��� ���Ŀ� Field get/set
	public String getSortColumn() {
		return sortColumn;
	}
	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}
	public String getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
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