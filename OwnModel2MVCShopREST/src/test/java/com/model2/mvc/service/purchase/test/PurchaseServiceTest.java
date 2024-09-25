package com.model2.mvc.service.purchase.test;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.UserService;

/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-aspect.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Test
	public void testAddPurchase() throws Exception 
	{
		Purchase purchase = new Purchase();

		Product product = productService.getProduct(10006);
		purchase.setPurchaseProd(product);
		
		User buyer = userService.getUser("user12");
		purchase.setBuyer(buyer);
		
		purchase.setPaymentOption("1");
		purchase.setReceiverName("testReciverName");
		purchase.setReceiverPhone("012-0120-1002");
		purchase.setDivyAddr("testDivyAddr");
		purchase.setDivyRequest("testDivyRequest");
		purchase.setTranCode("2");
		purchase.setDivyDate("2012-12-12");
		
		purchaseService.addPurchase(purchase);
		
		purchase = purchaseService.getPurchase(10000);

		//==> console Ȯ��
		System.out.println(purchase);
	}
	
	//@Test
	public void testGetPurchase() throws Exception 
	{		
		Purchase purchase = purchaseService.getPurchase(10003);

		System.out.println(purchase);
		
		Assert.assertEquals(10007, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user12", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("testReciverName", purchase.getReceiverName());
		Assert.assertEquals("012-0120-1002", purchase.getReceiverPhone());
		Assert.assertEquals("testDivyAddr", purchase.getDivyAddr());
		Assert.assertEquals("testDivyRequest", purchase.getDivyRequest());
		Assert.assertEquals("2", purchase.getTranCode());
		Assert.assertEquals("2012-12-12", purchase.getDivyDate());
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception
	{
		Purchase purchase = purchaseService.getPurchase(10001);
		Assert.assertNotNull(purchase);

		purchase.setPaymentOption("2");
		purchase.setReceiverName("changedReceiverName");
		purchase.setReceiverPhone("121-1212-1212");
		purchase.setDivyAddr("changedDivyAddr");
		purchase.setDivyRequest("changedDivyRequest");
		purchase.setDivyDate("1999-08-10");
		
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		Assert.assertNotNull(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("changedReceiverName", purchase.getReceiverName());
		Assert.assertEquals("121-1212-1212", purchase.getReceiverPhone());
		Assert.assertEquals("changedDivyAddr", purchase.getDivyAddr());
		Assert.assertEquals("changedDivyRequest", purchase.getDivyRequest());
		Assert.assertEquals("1999-08-10", purchase.getDivyDate());
		
		System.out.println(purchase);
	}
	
	//==>  �ּ��� Ǯ�� �����ϸ�....
	//@Test
	public void testGetPurchaseList() throws Exception
	{
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	}
	
	//@Test
	public void testUpdateTranCodeByTran() throws Exception
	{
		Purchase purchase = purchaseService.getPurchase(10000);
		Assert.assertNotNull(purchase);
		
		purchase.setTranCode("1");
		purchaseService.updateTranCode(purchase);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		Assert.assertNotNull(purchase);
		Assert.assertEquals("1", purchase.getTranCode());
		
		System.out.println(purchase);
	}

	//@Test
	public void testUpdateTranCodeByProd() throws Exception
	{
		Product product = productService.getProduct(10007);
		Assert.assertNotNull(product);
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		
		purchaseService.updateTranCode(purchase);
		
		purchase = purchaseService.getPurchase(10003);
		Assert.assertNotNull(purchase);
		Assert.assertEquals("1", purchase.getTranCode());
		
		System.out.println(purchase);
	}
	
}