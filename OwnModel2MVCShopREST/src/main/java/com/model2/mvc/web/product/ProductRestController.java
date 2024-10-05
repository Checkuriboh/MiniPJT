package com.model2.mvc.web.product;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;


//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	// 이미지 파일 참조 dirPath
	@Value("#{commonProperties['file.dir'] ?: 'C:/uploadFiles/'}")
	private String fileDir;
	
	
	///Constructor
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> 상품번호를 받아 상품정보 검색 및 반환
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception
	{
		System.out.println("/product/json/getProduct : GET");
		
		return productService.getProduct(prodNo);
	}
	
	//==> <img src=""> 상품 이미지 반환
	@RequestMapping( value="json/getImageFile/{fileName:.+}", method=RequestMethod.GET )
	public ResponseEntity<Resource> getImageFile( @PathVariable String fileName ) throws Exception
	{
		System.out.println("/product/json/getImageFile : GET");
		
        try {
            // 파일 시스템에서 이미지를 찾기 위한 경로 설정
            Path imagePath = Paths.get(fileDir + fileName);
            Resource resource = (Resource) new UrlResource(imagePath.toUri());

            // 이미지가 존재하는지 확인
            if ( !resource.exists() ) {
            	// 이미지가 없으면 404 error
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            // 이미지 파일의 Content-Type 추출 (JPEG, PNG 등)
            String contentType = Files.probeContentType(imagePath);
            
            // 이미지 데이터를 ResponseEntity로 반환
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType)) // Content-Type 설정
                    .body(resource); // 이미지 리소스 반환

        } catch (Exception e) {
        	// 예상 외 상황 500 error
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
}