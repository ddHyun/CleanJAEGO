package com.dd.jaego.vo;

import org.springframework.stereotype.Component;

@Component
public class UserVO {
	private String email, pwd;
	
	public UserVO() {}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}	
}
