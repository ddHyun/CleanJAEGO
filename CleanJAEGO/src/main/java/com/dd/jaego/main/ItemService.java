package com.dd.jaego.main;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dd.jaego.mapper.ItemMapper;
import com.dd.jaego.mapper.MainMapper;
import com.dd.jaego.vo.ItemVO;
import com.dd.jaego.vo.UserVO;

@Service
public class ItemService {
	
	@Autowired
	ItemMapper itemMapper;

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

	//선택항목 삭제하기
	public int deleteItem(ItemVO itemVO) {
		return itemMapper.deleteItem(itemVO);
	}

	//선택항목 내용조회
	public ItemVO showDetail(ItemVO itemVO) {
		return itemMapper.showDetail(itemVO);
	}

	//모든카테고리 목록 가져오기
	public ArrayList<String> getCategory(String email) {
		return itemMapper.getCategory(email);
	}
	

}
