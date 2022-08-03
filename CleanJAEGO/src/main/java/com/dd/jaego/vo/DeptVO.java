package com.dd.jaego.vo;

import org.springframework.stereotype.Component;

//�뀒�뒪�듃 vo �엯�땲�떎 李멸퀬�븯�꽭�슂
@Component
public class DeptVO {
	
	private int deptno;
	private String dname;
	private String loc;
	
	public DeptVO() {
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
	
}
