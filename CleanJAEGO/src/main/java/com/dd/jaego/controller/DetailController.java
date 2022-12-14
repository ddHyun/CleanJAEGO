package com.dd.jaego.controller;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dd.jaego.main.ItemService;
import com.dd.jaego.main.MainService;
import com.dd.jaego.vo.ItemVO;

@Controller
public class DetailController {

	@Autowired
	MainService mainService;
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;

	private static final Logger logger = LoggerFactory.getLogger(DetailController.class);
	
	//등록하기 페이지로 이동
	@RequestMapping("/detail2")
	public String goDetail2Page(Model model) {
		logger.info("==========detail2Page==========");
		String email = (String)session.getAttribute("sessionEmail");
		int res = itemService.checkItemList(email);
		if(res!=0) { //등록하기 페이지 내 기존 카테고리 목록이 있다면 불러오기
			List<String> categoryList1 = itemService.getCategory(email);
			model.addAttribute("categoryList", categoryList1);
		}
		model.addAttribute("res", res);
		return "detail";
	}
	
	//수정하기 페이지로 이동
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public String goDetailPage(int idx, Model model) {
		logger.info("==========detailPage==========");
		String email = (String)session.getAttribute("sessionEmail");
		ItemVO itemVO = new ItemVO();
		itemVO.setEmail(email);
		itemVO.setIdx(idx);
		
		//선택항목 내용조회
		ItemVO itemVO2 = itemService.showDetail(itemVO);	
		//모든카테고리 목록 가져오기
		ArrayList<String> categoryList = itemService.getCategory(email);
		
		model.addAttribute("itemVO", itemVO2);
		model.addAttribute("categoryList", categoryList);
		return "detail";
	}		

	//제품 등록하기
	@ResponseBody
	@RequestMapping(value="/registerItem", method=RequestMethod.POST)
	public String registerItem(ItemVO vo, @RequestParam("categoryInput")String category) throws Exception{
		
		//파일 저장위치 설정
		setFilename(vo);
		
		vo.setCategory(category);
		vo.setEmail((String)session.getAttribute("sessionEmail"));
		
		//입력시 공백은 '-'로 저장하기
		makeNotNull(vo);
		
		//DB에 제품내용 저장하기
		int res = itemService.insertItem(vo);	
		String result = String.format("[{'result':'%d'}]", res);
		return result;
	}
	
	//제품내용 수정하기
	@ResponseBody
	@RequestMapping(value="/modifyItem", method=RequestMethod.POST)
	public String modifyItem(ItemVO vo, @RequestParam("categoryInput")String category) throws Exception{
		
		vo.setEmail((String)session.getAttribute("sessionEmail"));
		vo.setCategory(category);		
		
		//idx에 해당하는 제품정보 가져오기
		ItemVO dbVO = itemService.showDetail(vo);
		
		//입력칸 공백시 '-'로 저장하기
		makeNotNull(vo);
		
		boolean check = false;//db에 저장된 내용과 수정페이지에 적힌 내용의 일치 유무 확인용 변수
		
		if(!dbVO.getCategory().equals(vo.getCategory())) {
			check = true; //내용이 바꼈으면 true
		}
		if(!dbVO.getItem_name().equals(vo.getItem_name())) {
			check = true;
		}
		if(dbVO.getStock()!=vo.getStock()) {
			check = true;
		}
		if(!dbVO.getManufacture_date().equals(vo.getManufacture_date())) {
			check = true;
		}
		if(!dbVO.getExpiry_date().equals(vo.getExpiry_date())) {
			check = true;
		}
		if(!dbVO.getPrice().equals(vo.getPrice())) {
			check = true;
		}
		if(!dbVO.getStore().equals(vo.getStore())) {
			check = true;
		}
		if(!dbVO.getMemo().equals(vo.getMemo())) {
			check = true;
		}
		
		//수정페이지 내 이미지파일명 가져오기
		MultipartFile file = vo.getFile();
		String imgFilename = file.getOriginalFilename();
		
		if(imgFilename.equals("")) { //이미지파일 변경 없을 경우
			vo.setFilename(dbVO.getFilename());
			vo.setFoldername(dbVO.getFoldername());
		}else { //이미지파일 변경시
			setFilename(vo);
		}

		if(!dbVO.getFilename().equals(vo.getFilename())) {
			check=true;
		}
		
		int res = 0; //
		if(check) { //DB에 수정내용 저장하기
			res = itemService.updateItemInfo(vo);
		}
		
		String result = String.format("[{'result':'%d'}]", res);
		
		return result;
	}
	
	//입력칸 공백 채우기
	public void makeNotNull(ItemVO vo) {
		if(vo.getManufacture_date().equals("")) {
			vo.setManufacture_date("-");
		}
		if(vo.getExpiry_date().equals("")) {
			vo.setExpiry_date("-");
		}
		if(vo.getMemo().equals("")) {
			vo.setMemo("-");
		}
		if(vo.getStore().equals("")) {
			vo.setStore("-");
		}
		if(vo.getPrice().equals("")) {
			vo.setPrice("-");
		}
	}	
	
	//파일 경로설정 및 vo에 저장하기
	public void setFilename(ItemVO vo) throws Exception {
		String currDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));//현재날짜
		String webPath = "/resources/upload/"; //절대경로
		String savePath = request.getSession().getServletContext().getRealPath(webPath);//상대경로
		
		String filename = "noImage.png";
		MultipartFile file = vo.getFile();
		
		if(!file.isEmpty()) {
			//업로드된 실제파일명
			filename = file.getOriginalFilename();
			File saveFile = new File(savePath+currDate, filename);//파일을 날짜별로 그룹지어 보관하기
			if(!saveFile.exists()) {//upload폴더가 없으면 생성 
				saveFile.mkdirs();
			}else {
				//파일명 중복방지
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath+currDate, filename);
			}
			//파일을 복사해서 전송하기
			file.transferTo(saveFile);
		}
		vo.setFilename(filename);
		vo.setFoldername(currDate);
	}
}