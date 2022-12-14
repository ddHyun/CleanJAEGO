package com.dd.jaego.main;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dd.jaego.mapper.ItemMapper;
import com.dd.jaego.mapper.MainMapper;
import com.dd.jaego.vo.ItemVO;
import com.dd.jaego.vo.UserVO;

@Service
public class MainService {
	
	@Autowired
	MainMapper mainMapper;
	
	@Autowired
	ItemMapper itemMapper;

	//회원목록 가져오기
	public ArrayList<UserVO> showUserList() {
		ArrayList<UserVO> userList = mainMapper.showUserList();
		return userList;
	}

	//회원목록 추가하기
	public int insertUser(UserVO vo) {
		return mainMapper.insertUser(vo);
	}

	//해당아이디에 저장된 목록유무 확인하기
	public int checkItemList(String email) {
		int resultNum = itemMapper.checkItemList(email);
		return resultNum;
	}
	
	//재고목록 가져오기
	public ArrayList<ItemVO> showItemList(String email) {
		ArrayList<ItemVO> itemList = itemMapper.showItemList(email);
		return itemList;
	}
	

}
