package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 Controller
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

	// 이미지 파일 참조 dirPath
	@Value("#{commonProperties['file.dir'] ?: 'C:/uploadFiles/'}")
	private String fileDir;
	
	
	///Constructor
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> 상품정보 추가 페이지로 이동
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception
	{
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	//==> 상품정보 추가 B/L 수행
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( 	@ModelAttribute("product") Product product,
								@RequestParam("fileData") MultipartFile fileData ) throws Exception
	{
		System.out.println("/product/addProduct : POST");

		// 업로드 된 파일이 존재하면 저장
		if ( !fileData.isEmpty() ) 
		{
			// 파일 이름으로 랜덤한 ID 부여
			String fileName = UUID.randomUUID().toString() + "." + fileData.getContentType().substring(6);
					
			try {
				// 파일 저장 + 성공 시 상품에 파일 이름 저장
				fileData.transferTo(new File(fileDir, fileName));
				product.setFileName(fileName);
				
			} catch (IOException e) {
				// 파일 저장 실패 시 빈 파일 저장
				product.setFileName("empty.GIF");
				e.printStackTrace();
			}
		}
		else { // 업로드 된 파일이 없으면 빈 파일 저장
			product.setFileName("empty.GIF");
//			product.setFileName("../../images/empty.GIF");
		}
		
		// 상품 정보 추가 B/L 수행
		productService.addProduct(product);

		return "redirect:/product/listProduct?menu=manage";
	}

	//==> 상품정보 확인 페이지로 이동
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct( 	@RequestParam("prodNo") int prodNo,
								Model model ) throws Exception
	{
		System.out.println("/product/getProduct : GET");

		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}

	//==> 상품정보 수정 페이지로 이동
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
	public String updateProduct( 	@RequestParam("prodNo") int prodNo,
									Model model ) throws Exception
	{
		System.out.println("/product/updateProduct : GET");

		Product product = productService.getProduct(prodNo);

		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}

	//==> 상품정보 수정 B/L 수행
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public String updateProduct( 	@ModelAttribute("product") Product product,
									@RequestParam("fileData") MultipartFile fileData ) throws Exception
	{
		System.out.println("/product/updateProduct : POST");
		
		// 업로드 된 파일이 존재하면 저장
		if ( !fileData.isEmpty() ) 
		{
			// 파일 이름으로 랜덤한 ID 부여
			String fileName = UUID.randomUUID().toString() + "." + fileData.getContentType().substring(6);
			
			try {
				// 파일 저장 + 성공 시 상품에 파일 이름 저장
				fileData.transferTo(new File(fileDir, fileName));
				product.setFileName(fileName);
				
			} catch (IOException e) {
				// 파일 저장 실패 시 빈 파일 저장
				product.setFileName("empty.GIF");
				e.printStackTrace();
			}
		}
		else { // 업로드 된 파일이 없으면 빈 파일 저장
			product.setFileName("empty.GIF");
//			product.setFileName("../../images/empty.GIF");
		}
		
		// 상품 정보 갱신 B/L 수행
		productService.updateProduct(product);

		return "redirect:/product/getProduct?prodNo=" + product.getProdNo();
	}
	
	//==> 상품목록 검색 후 확인 페이지로 이동
	@RequestMapping( value="listProduct" )
	public String listProduct( 	@ModelAttribute("search") Search search, 
								Model model ) throws Exception
	{
		System.out.println("/product/listProduct : GET / POST");
		
		if (search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/product/listProduct.jsp";
	}
	
}