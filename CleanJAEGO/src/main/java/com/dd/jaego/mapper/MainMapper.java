package com.dd.jaego.mapper;

import java.util.List;

//import org.apache.ibatis.annotations.Mapper;
//import org.apache.ibatis.annotations.Select;

import com.dd.jaego.vo.DeptVO;

//@Mapper
public interface MainMapper {
	
	public List<DeptVO> deptList(); 
	
//	@Select("SELECT * FROM DEPT")
	public List<DeptVO> dept();
}
