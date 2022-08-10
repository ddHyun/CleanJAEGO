package com.dd.jaego.main;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dd.jaego.mapper.MainMapper;
import com.dd.jaego.vo.UserVO;

@Service
public class MainService {
	
	@Autowired
	MainMapper mainMapper;

	//회원목록 가져오기
	public ArrayList<UserVO> showUserList() {
		ArrayList<UserVO> userList = mainMapper.showUserList();
		return userList;
	}

	//회원목록 추가하기
	public int insertUser(UserVO vo) {
		return mainMapper.insertUser(vo);
	}

}
