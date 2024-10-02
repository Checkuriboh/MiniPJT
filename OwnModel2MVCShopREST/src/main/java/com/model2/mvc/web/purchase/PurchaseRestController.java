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
	
	//==> 판매상태 수정 B/L 수행
	@RequestMapping( value="json/updateTranCode/{tranCode}/{tranNo}", method=RequestMethod.GET )
	public boolean updateTranCode( 	@PathVariable String tranCode ,
									@PathVariable int tranNo ) throws Exception
	{
		System.out.println("/purchase/json/updateTranCode : GET");

		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		purchase = purchaseService.getPurchase(tranNo);
		if ( tranCode.equals(purchase.getTranCode()) ) {
			return true;
		}
		else {
			return false;
		}
	}

	//==> 판매상태 수정 B/L 수행 (상품정보에서 접근 시)
	@RequestMapping( value="json/updateTranCodeByProd/{tranCode}/{prodNo}", method=RequestMethod.GET )
	public boolean updateTranCodeByProd( 	@PathVariable String tranCode,
											@PathVariable int prodNo ) throws Exception
	{
		System.out.println("/purchase/json/updateTranCodeByProd : GET");

		Product product = new Product();
		product.setProdNo(prodNo);
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);

		purchaseService.updateTranCode(purchase);
		
		product = productService.getProduct(prodNo);
		if ( tranCode.equals(product.getProTranCode()) ) {
			return true;
		}
		else {
			return false;
		}
	}
	
}