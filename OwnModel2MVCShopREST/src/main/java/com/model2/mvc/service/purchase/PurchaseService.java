package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {

	public Purchase addPurchase(Purchase purchase) throws Exception;
	
	public Purchase getPurchase(int tranNo) throws Exception;

	// 구매자거만 보기
	public Map<String,Object> getPurchaseList(Search search, String buyerId) throws Exception;
	
	// 전체보기?
	public Map<String,Object> getSaleList(Search search) throws Exception;
	
	public Purchase updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
}
