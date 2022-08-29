package com.dd.jaego.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.function.Function;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	public String goDetail2Page() {
		logger.info("==========detail2Page==========");
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
		vo.setCategory(category);
		vo.setEmail((String)session.getAttribute("sessionEmail"));
		
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
		
		int res = itemService.insertItem(vo);	
		String result = String.format("[{'result':'%d'}]", res);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/modifyItem", method=RequestMethod.POST)
	public String modifyItem(ItemVO vo) {
		vo.setEmail((String)session.getAttribute("sessionEmail"));
		ItemVO dbVO = itemService.showDetail(vo);
		if(dbVO.getItem_name().equals(vo.getItem_name())) {
			System.out.println("변동없음");
		}else {
			System.out.println("item_name: "+vo.getItem_name());
		}
		return "re";
	}
}
