package com.dd.jaego.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.dd.jaego.vo.DeptVO;
import com.dd.jaego.vo.UserVO;

@Mapper
public interface MainMapper {
	
	public List<DeptVO> deptList(); 

	@Select("select * from jguser")
	public UserVO showUserList();
}
