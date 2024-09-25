package com.model2.mvc.service.domain;

import java.sql.Date;
import java.util.Properties;

import com.model2.mvc.common.util.DateUtil;

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

	public Product() {
	}

	public String getProTranCode() {
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode.trim();
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
		this.manuDate = DateUtil.toDateStr(manuDate, 8);
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
	}

	// Override
	public String toString() {
		return "ProductVO : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[proTranCode]" + proTranCode;
	}
	
	public String getProTranCodeStr()
	{
		Properties ptcStr = new Properties();
		ptcStr.setProperty("1", "���ſϷ�");
		ptcStr.setProperty("2", "�����");
		ptcStr.setProperty("3", "��ۿϷ�"); // ��� ����
		
		if (this.getProTranCode() == null) {
			return "�Ǹ���";
		}
		else {
			return ptcStr.getProperty(this.getProTranCode(), "-");
		}
	}
	
}
