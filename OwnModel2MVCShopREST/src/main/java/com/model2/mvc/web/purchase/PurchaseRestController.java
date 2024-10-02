package com.model2.mvc.web.purchase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 상품관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
	///Constructor
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> 구매번호를 받아 구매정보 검색 및 반환
	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase( @PathVariable int tranNo ) throws Exception
	{
		System.out.println("/purchase/json/getPurchase : GET");
		
		return purchaseService.getPurchase(tranNo);
	}
	
}