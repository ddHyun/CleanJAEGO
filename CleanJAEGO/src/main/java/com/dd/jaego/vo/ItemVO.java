package com.dd.jaego.vo;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class ItemVO {
	private int idx, stock;
	private long dateGap; //dateGap: 임박알림을 위한 날짜차이 저장용 변수
	private String email, category, item_name, manufacture_date, expiry_date,
					price, store, filename, memo, foldername; //foldername : 파일을 폴더별로 저장할 때 사용
	
	private MultipartFile file; //업로드 사진	
	
	public ItemVO() {}	
	
	public ItemVO(int idx, String item_name, int stock, String manufacture_date, String expiry_date, String filename) {
		this.idx = idx;
		this.stock = stock;
		this.item_name = item_name;
		this.manufacture_date = manufacture_date;
		this.expiry_date = expiry_date;
		this.filename = filename;
	}

	public String getMemo() {
		return memo;
	}
	
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getManufacture_date() {
		return manufacture_date;
	}
	public void setManufacture_date(String manufacture_date) {
		this.manufacture_date = manufacture_date;
	}
	public String getExpiry_date() {
		return expiry_date;
	}
	public void setExpiry_date(String expiry_date) {
		this.expiry_date = expiry_date;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getStore() {
		return store;
	}
	public void setStore(String store) {
		this.store = store;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public long getDateGap() {
		return dateGap;
	}
	public void setDateGap(long dateGap) {
		this.dateGap = dateGap;
	}		
	public String getFoldername() {
		return foldername;
	}
	public void setFoldername(String foldername) {
		this.foldername = foldername;
	}
}
