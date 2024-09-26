package com.model2.mvc.web.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
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
	
	//==> 회원 ID를 받아 회원 정보 검색 및 반환
	@RequestMapping(value="json/getUser/{userId}", method=RequestMethod.GET)
	public User getUser( @PathVariable String userId ) throws Exception
	{
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	//==> 회원정보(ID,password)를 받아 로그인 
	@RequestMapping(value="json/login", method=RequestMethod.POST)
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
	
}