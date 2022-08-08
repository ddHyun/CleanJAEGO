package com.dd.jaego.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dd.jaego.main.MainService;
import com.dd.jaego.vo.UserVO;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@RequestMapping(value= {"/", "/main"})
	public String mainPage(Model model) {
		ArrayList<UserVO> list = new ArrayList<UserVO>();
		UserVO uVO = mainService.showUserList();
		model.addAttribute("vo", uVO);
		
		return "main";
	}
	
	//로그인페이지로 이동
	@RequestMapping(value="/login")
	public String loginPage() {
		return "login";
	}
	
	//로그인하기
	//return으로 jsp가 아닌 데이터 형태 그대로 되돌려보낼 때 기재하기 
	@ResponseBody
	@RequestMapping(value="/checkLogin", method=RequestMethod.POST)
	public void checkLogin(UserVO vo) {
		System.out.println("email: "+vo.getEmail());
		System.out.println("pwd: "+vo.getPwd());
	}
}
