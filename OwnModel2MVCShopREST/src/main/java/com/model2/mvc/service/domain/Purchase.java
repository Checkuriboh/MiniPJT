package com.model2.mvc.service.domain;

import java.sql.Date;
import java.util.Properties;

import com.model2.mvc.common.util.StringUtil;

public class Purchase {

	private int tranNo;
	private Product purchaseProd;
	private User buyer;
	private String paymentOption;
	private String receiverName;
	private String receiverPhone;
	private String divyAddr;
	private String divyRequest;
	private String tranCode;
	private Date orderDate;
	private String divyDate;
	// 1:현금구매 2:신용구매
	private String paymentOptionString;

	//////////////////////////////////////////////////////////////////////////////////////////////
	private String orderDateString;
	// JSON ==> Domain Object  Binding을 위해 추가된 부분
	
	
	public Purchase(){
	}
	
	public User getBuyer() {
		return buyer;
	}
	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}
	public String getDivyAddr() {
		return divyAddr;
	}
	public void setDivyAddr(String divyAddr) {
		this.divyAddr = divyAddr;
	}
	public String getDivyDate() {
		return divyDate;
	}
	public void setDivyDate(String divyDate) {
		this.divyDate = StringUtil.toDateStr(divyDate, 10);
	}
	public String getDivyRequest() {
		return divyRequest;
	}
	public void setDivyRequest(String divyRequest) {
		this.divyRequest = divyRequest;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
		// JSON ==> Domain Object  Binding을 위해 추가된 부분
		this.orderDateString = StringUtil.toDateStr(orderDate, 10);
	}
	public String getPaymentOption() {
		return paymentOption;
	}
	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption.trim();
	}
	public Product getPurchaseProd() {
		return purchaseProd;
	}
	public void setPurchaseProd(Product purchaseProd) {
		this.purchaseProd = purchaseProd;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverPhone() {
		return receiverPhone;
	}
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}
	public String getTranCode() {
		return tranCode;
	}
	public void setTranCode(String tranCode) {
		this.tranCode = tranCode.trim();
	}
	public int getTranNo() {
		return tranNo;
	}
	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}
	
	@Override
	public String toString() {
		return "PurchaseVO [buyer=" + buyer + ", divyAddr=" + divyAddr
				+ ", divyDate=" + divyDate + ", divyRequest=" + divyRequest
				+ ", orderDate=" + orderDate + ", paymentOption="
				+ paymentOption + ", purchaseProd=" + purchaseProd
				+ ", receiverName=" + receiverName + ", receiverPhone="
				+ receiverPhone + ", tranCode=" + tranCode + ", tranNo="
				+ tranNo + "]";
	}
	

	// 1:현금구매 2:신용구매
	public String getPaymentOptionString()
	{
		Properties payStr = new Properties();
		payStr.setProperty("1", "현금구매");
		payStr.setProperty("2", "신용구매");
		
		return payStr.getProperty(this.paymentOption, "-");
	}
	
	public void setPaymentOptionString(String paymentOptionString) {
		this.paymentOptionString = paymentOptionString;
	}

	/////////////////////////////////////////////////////////////////////////////////////////
	// JSON ==> Domain Object  Binding을 위해 추가된 부분
	public String getOrderDateString() {
		return orderDateString;
	}

	public void setOrderDateString(String orderDateString) {
		this.orderDateString = orderDateString;
	}
	
}
