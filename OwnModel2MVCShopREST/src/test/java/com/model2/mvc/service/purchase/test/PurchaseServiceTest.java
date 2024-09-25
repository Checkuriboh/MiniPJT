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
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-aspect.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
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

		//==> console 확인
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
		
		//==> API 확인
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("changedReceiverName", purchase.getReceiverName());
		Assert.assertEquals("121-1212-1212", purchase.getReceiverPhone());
		Assert.assertEquals("changedDivyAddr", purchase.getDivyAddr());
		Assert.assertEquals("changedDivyRequest", purchase.getDivyRequest());
		Assert.assertEquals("1999-08-10", purchase.getDivyDate());
		
		System.out.println(purchase);
	}
	
	//==>  주석을 풀고 실행하면....
	//@Test
	public void testGetPurchaseList() throws Exception
	{
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
		//==> console 확인
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