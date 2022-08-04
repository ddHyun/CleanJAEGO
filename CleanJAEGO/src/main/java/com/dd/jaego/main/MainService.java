package com.dd.jaego.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dd.jaego.mapper.MainMapper;
import com.dd.jaego.vo.UserVO;

@Service
public class MainService {
	
	@Autowired
	MainMapper mainMapper;

	//회원목록 가져오기
	public UserVO showUserList() {
		UserVO uVO = mainMapper.showUserList();
		return uVO;
	}

}
