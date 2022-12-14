package com.dd.jaego.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.dd.jaego.vo.DeptVO;
import com.dd.jaego.vo.ItemVO;
import com.dd.jaego.vo.UserVO;

@Mapper
public interface MainMapper {
	
//	public List<DeptVO> deptList(); 

	//회원전체목록 가져오기
	@Select("select * from jguser")
	public ArrayList<UserVO> showUserList();

	//회원추가하기
	public int insertUser(UserVO vo);
	
//	//해당아이디에 저장된 목록유무 확인하기
//	public int checkItemList(String email);
//
//	//재고전체목록 가져오기
//	public ArrayList<ItemVO> showItemList(String email);
}
