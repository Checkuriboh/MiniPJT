package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

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
								HttpServletRequest request ) throws Exception
	{
		System.out.println("/product/addProduct : POST");

		
		if (FileUpload.isMultipartContent(request))
		{
			String tempDir = "C:\\Users\\bitcamp\\git\\MiniPJT\\OwnModel2MVCShopREST\\src\\main\\webapp\\images\\uploadFiles\\";
			//String tempDir2 = "/uploadFiles/";

			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(tempDir);
			// setSizeThreshold의 크기를 벗어나면 지정 위치에 임시 저장
			fileUpload.setSizeMax(1024 * 1024 * 10); // 최대 100MB
			fileUpload.setSizeThreshold(1024 * 100); // 100KB 까지는 메모리 저장
			
			if (request.getContentLength() < fileUpload.getSizeMax())
			{
				List<FileItem> fileItemList = fileUpload.parseRequest(request);
				for (FileItem fileItem : fileItemList) 
				{
					if (fileItem.isFormField()) // file 아닌 parameter
					{
						if (fileItem.getFieldName().equals("manuDate")) {
							product.setManuDate(fileItem.getString("euc-kr"));
						}
						else if (fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
						}
						else if (fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
						}
						else if (fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						}
					}
					else // 파일
					{
						if (fileItem.getSize() > 0) 
						{
							int idx = fileItem.getName().lastIndexOf("\\");
							if (idx == -1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx + 1);
							product.setFileName(fileName);
							
							try {
								File uploadedFile = new File(tempDir, fileName);
								fileItem.write(uploadedFile);
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
						else {
							product.setFileName("../../images/empty.GIF");
						}
					}
				} //for end
				productService.addProduct(product);
			}
			else // request.getContentLength() >= fileUpload.getSizeMax()
			{
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("<script>alert(올리신 파일 용량이 1MB 보다 큰 " + overSize + "MB 입니다.);history.back();</script>");
			}
		}
		else {
			System.out.println("인코딩이 multipart/form-data가 아님");
		}

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
									HttpServletRequest request ) throws Exception
	{
		System.out.println("/product/updateProduct : POST");
		
		
		if (FileUpload.isMultipartContent(request))
		{
			String tempDir = "C:\\Users\\bitcamp\\git\\MiniPJT\\OwnModel2MVCShopREST\\src\\main\\webapp\\images\\uploadFiles\\";
			//String tempDir2 = "/uploadFiles/";

			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(tempDir);
			// setSizeThreshold의 크기를 벗어나면 지정 위치에 임시 저장
			fileUpload.setSizeMax(1024 * 1024 * 10); // 최대 100MB
			fileUpload.setSizeThreshold(1024 * 100); // 100KB 까지는 메모리 저장
			
			if (request.getContentLength() < fileUpload.getSizeMax())
			{
				List<FileItem> fileItemList = fileUpload.parseRequest(request);
				for (FileItem fileItem : fileItemList) 
				{
					if (fileItem.isFormField()) // file 아닌 parameter
					{
						if (fileItem.getFieldName().equals("manuDate")) {
							product.setManuDate(fileItem.getString("euc-kr"));
						}
						else if (fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
						}
						else if (fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
						}
						else if (fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						}
						else if (fileItem.getFieldName().equals("prodNo")) {
							product.setProdNo(Integer.parseInt(fileItem.getString("euc-kr")));
						}
					}
					else // 파일
					{
						if (fileItem.getSize() > 0) 
						{
							int idx = fileItem.getName().lastIndexOf("\\");
							if (idx == -1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx + 1);
							product.setFileName(fileName);
							
							try {
								File uploadedFile = new File(tempDir, fileName);
								fileItem.write(uploadedFile);
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
						else {
							product.setFileName("../../images/empty.GIF");
						}
					}
				} //for end
				productService.updateProduct(product);
			}
			else // request.getContentLength() >= fileUpload.getSizeMax()
			{
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("<script>alert(올리신 파일 용량이 1MB 보다 큰 " + overSize + "MB 입니다.);history.back();</script>");
			}
		}
		else {
			System.out.println("인코딩이 multipart/form-data가 아님");
		}

		return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=ok";
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