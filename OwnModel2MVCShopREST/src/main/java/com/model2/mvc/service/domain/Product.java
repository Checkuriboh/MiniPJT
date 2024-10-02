package com.model2.mvc.service.domain;

import java.sql.Date;
import java.util.Properties;

import com.model2.mvc.common.util.StringUtil;

public class Product {

	private int prodNo;
	private String prodName;
	private String prodDetail;
	private String manuDate;
	private int price;
	private String fileName;
	private Date regDate;
	private String proTranCode;
	// null:�Ǹ��� 1:�ǸſϷ� 2:����� 3:��ۿϷ�
	private String proTranCodeString;
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	private String regDateString;
	// JSON ==> Domain Object  Binding�� ���� �߰��� �κ�

	
	public Product() {
	}

	public String getProTranCode() {
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) {
		this.proTranCode = StringUtil.trim(proTranCode);
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = StringUtil.toDateStr(manuDate, 8);
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
		// JSON ==> Domain Object  Binding�� ���� �߰��� �κ�
		this.regDateString = StringUtil.toDateStr(manuDate, 10);
	}

	// Override
	public String toString() {
		return "ProductVO : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[proTranCode]" + proTranCode;
	}

	
	// null:�Ǹ��� 1:�ǸſϷ� 2:����� 3:��ۿϷ�
	public String getProTranCodeString() 
	{
		if (this.proTranCode == null){
			return "�Ǹ���";
		}
		
		Properties ptcStr = new Properties();
		ptcStr.setProperty("1", "�ǸſϷ�");
		ptcStr.setProperty("2", "�����");
		ptcStr.setProperty("3", "��ۿϷ�");
		
		return ptcStr.getProperty(proTranCode, "-");
	}
	
	public void setProTranCodeString(String proTranCodeString) {
		this.proTranCodeString = proTranCodeString;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding�� ���� �߰��� �κ�
	public String getRegDateString() {
		return regDateString;
	}
	
	public void setRegDateString(String regDateString) {
		this.regDateString = regDateString;
	}
	
}
