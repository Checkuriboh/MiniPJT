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
	// null:판매중 1:판매완료 2:배송중 3:배송완료
	private String proTranCodeString;
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	private String regDateString;
	// JSON ==> Domain Object  Binding을 위해 추가된 부분

	
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
		// JSON ==> Domain Object  Binding을 위해 추가된 부분
		this.regDateString = StringUtil.toDateStr(manuDate, 10);
	}

	// Override
	public String toString() {
		return "ProductVO : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[proTranCode]" + proTranCode;
	}

	
	// null:판매중 1:판매완료 2:배송중 3:배송완료
	public String getProTranCodeString() 
	{
		if (this.proTranCode == null){
			return "판매중";
		}
		
		Properties ptcStr = new Properties();
		ptcStr.setProperty("1", "판매완료");
		ptcStr.setProperty("2", "배송중");
		ptcStr.setProperty("3", "배송완료");
		
		return ptcStr.getProperty(proTranCode, "-");
	}
	
	public void setProTranCodeString(String proTranCodeString) {
		this.proTranCodeString = proTranCodeString;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding을 위해 추가된 부분
	public String getRegDateString() {
		return regDateString;
	}
	
	public void setRegDateString(String regDateString) {
		this.regDateString = regDateString;
	}
	
}
