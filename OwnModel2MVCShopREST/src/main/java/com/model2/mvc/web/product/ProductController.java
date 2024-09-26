package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> ��ǰ���� Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	private int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 3}")
	private int pageSize;
	
	
	///Constructor
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> ��ǰ���� �߰� �������� �̵�
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception
	{
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}

	//==> ��ǰ���� �߰� B/L ����
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( @ModelAttribute("product") Product product ) throws Exception
	{
		System.out.println("/product/addProduct : POST");
		
		productService.addProduct(product);

		return "redirect:/product/listProduct?menu=manage";
	}

	//==> ��ǰ���� Ȯ�� �������� �̵�
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct( 	@RequestParam("prodNo") int prodNo,
								Model model ) throws Exception
	{
		System.out.println("/product/getProduct : GET");

		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}

	//==> ��ǰ���� ���� �������� �̵�
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
	public String updateProduct( 	@RequestParam("prodNo") int prodNo,
									Model model ) throws Exception
	{
		System.out.println("/product/updateProduct : GET");

		Product product = productService.getProduct(prodNo);

		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}

	//==> ��ǰ���� ���� B/L ����
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public String updateProduct( @ModelAttribute("product") Product product ) throws Exception
	{
		System.out.println("/product/updateProduct : POST");

		productService.updateProduct(product);

		return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=ok";
	}

	//==> ��ǰ��� �˻� �� Ȯ�� �������� �̵�
	@RequestMapping( value="listProduct" )
	public String listProduct( 	@ModelAttribute("search") Search search, 
								Model model ) throws Exception
	{
		System.out.println("/product/listProduct : GET / POST");
		
		if (search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/product/listProduct.jsp";
	}
	
}