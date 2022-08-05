package com.dd.jaego.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dd.jaego.main.MainService;
import com.dd.jaego.vo.UserVO;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@RequestMapping(value="/")
	public String mainPage(Model model) {
		ArrayList<UserVO> list = new ArrayList<UserVO>();
		UserVO uVO = mainService.showUserList();
		model.addAttribute("vo", uVO);
		
		return "main";
	}
	
	//로그인페이지로 이동
	@RequestMapping(value="login", method = RequestMethod.POST)
	public String loginPage() {
		return "login";
	}
}
