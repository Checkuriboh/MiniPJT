package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	///Constructor
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> ȸ�� ID�� �޾� ȸ�� ���� �˻� �� ��ȯ
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception
	{
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	//==> ȸ������(ID,password)�� �޾� �α��� 
	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login( 	@RequestBody User user,
						HttpSession session ) throws Exception
	{
		System.out.println("/user/json/login : POST");
		
		//Business Logic
		System.out.println(":: " + user);
		User dbUser = userService.getUser(user.getUserId());
		
		if ( dbUser.getPassword().equals(user.getPassword()) )
		{
			session.setAttribute("user", dbUser);
			return dbUser;
		}
		
		return null;
	}
	
	//==> �α׾ƿ�
	@RequestMapping( value="json/logout", method=RequestMethod.GET )
	public boolean logout( HttpSession session ) throws Exception
	{
		System.out.println("/user/json/logout : GET");
		
		session.removeAttribute("user");
		
		if (session.getAttribute("user") == null) {
			return true;
		}
		else {
			return false;
		}
	}
	
	//==> �˻������� �޾� ��ǰ��� �˻� �� ��ȯ
	@RequestMapping( value="json/listUser", method=RequestMethod.POST )
	public Map<String, Object> listUser( @RequestBody Search search ) throws Exception
	{
		System.out.println("/user/json/listUser : POST");
		
		// Business logic ����
		Map<String, Object> map = userService.getUserList(search);
		
		return map;
	}
	
}