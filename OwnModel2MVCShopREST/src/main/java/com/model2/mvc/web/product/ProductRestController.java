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


//==> ��ǰ���� RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	// �̹��� ���� ���� dirPath
	@Value("#{commonProperties['file.dir'] ?: 'C:/uploadFiles/'}")
	private String fileDir;
	
	
	///Constructor
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> ��ǰ��ȣ�� �޾� ��ǰ���� �˻� �� ��ȯ
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception
	{
		System.out.println("/product/json/getProduct : GET");
		
		return productService.getProduct(prodNo);
	}
	
	//==> <img src=""> ��ǰ �̹��� ��ȯ
	@RequestMapping( value="json/getImageFile/{fileName:.+}", method=RequestMethod.GET )
	public ResponseEntity<Resource> getImageFile( @PathVariable String fileName ) throws Exception
	{
		System.out.println("/product/json/getImageFile : GET");
		
        try {
            // ���� �ý��ۿ��� �̹����� ã�� ���� ��� ����
            Path imagePath = Paths.get(fileDir + fileName);
            Resource resource = (Resource) new UrlResource(imagePath.toUri());

            // �̹����� �����ϴ��� Ȯ��
            if ( !resource.exists() ) {
            	// �̹����� ������ 404 error
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            // �̹��� ������ Content-Type ���� (JPEG, PNG ��)
            String contentType = Files.probeContentType(imagePath);
            
            // �̹��� �����͸� ResponseEntity�� ��ȯ
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType)) // Content-Type ����
                    .body(resource); // �̹��� ���ҽ� ��ȯ

        } catch (Exception e) {
        	// ���� �� ��Ȳ 500 error
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
}