package com.dd.jaego.controller;

import java.time.LocalDate;

import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dd.jaego.main.ItemService;
import com.dd.jaego.main.MainService;
import com.dd.jaego.vo.ItemVO;
import com.dd.jaego.vo.UserVO;


@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	HttpSession session;
	
	ArrayList<UserVO> userList;
	ArrayList<ItemVO> itemList;
	List<String> categoryList;
	static String categoryName = "nothing";
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	//메인페이지로 이동
	@RequestMapping(value= {"/","/main"})
	public String mainPage(Model model) {
		itemList = new ArrayList<ItemVO>();
		//DB에 해당이메일의 재고목록 유무 확인
		String result = checkItemIdx();
		if(result.equals("0")) {//이메일O 목록X
			System.out.println("이메일O 목록X");			
		}else if(result.equals("noSession")) {//로그인 안된 상태
			System.out.println("로그인 안된 상태");
			ItemVO itemVO1 = new ItemVO(0, "골든커리", 4, "-", "2022-08-17", "curry.jpg");
			ItemVO itemVO2 = new ItemVO(1, "콘통조림", 5, "-", "2024-05-30", "corn.png");
			ItemVO itemVO3 = new ItemVO(2, "파스타/푸실리", 1, "-", "2022-08-16", "pasta.jpg");
			ItemVO itemVO4 = new ItemVO(3, "부침가루", 2, "-", "-", "flour.jpg");
			itemList.add(itemVO1);
			itemList.add(itemVO2);
			itemList.add(itemVO3);
			itemList.add(itemVO4);
		}else {//이메일O 목록O
			itemList = showitemList();	
			categoryList = itemService.getCategory((String)session.getAttribute("sessionEmail"));
			model.addAttribute("categoryList", categoryList);
		}	
		
		long dateGap = 0;
		String resultGap = "";
		
		for (int i = 0; i < itemList.size(); i++) {
			if(!itemList.get(i).getExpiry_date().equals("-")) {
				LocalDate now = LocalDate.now();
				String dateExpiry1 = itemList.get(i).getExpiry_date();
				LocalDate dateExpiry2 = LocalDate.parse(dateExpiry1, DateTimeFormatter.ISO_DATE);
				dateGap = ChronoUnit.DAYS.between(now, dateExpiry2);
				itemList.get(i).setDateGap(dateGap);
			}else {				
				dateGap = 100000000;
				itemList.get(i).setDateGap(dateGap);
			}
		}			
		model.addAttribute("resultGap", resultGap);//유통기한과 현재날짜 차이
		model.addAttribute("itemList", itemList);
		model.addAttribute("dbResult", result); //재고유무확인
		session.setAttribute("categoryName", categoryName);
		logger.info("==========mainPage==========");
		System.out.println("categoryName: "+categoryName);
		
		return "main";
	}
	
	//로그인페이지로 이동
	@RequestMapping(value="/login")
	public String goLoginPage() {
		logger.info("==========loginPage==========");
		return "login";
	}
	
	//로그아웃(로그인페이지로 이동)
	@RequestMapping("/logout")
	public String logout() {
		logger.info("==========logout==========");
		session.invalidate();
		categoryName = "nothing";
		return "login";
	}
	
	//회원가입 페이지로 이동
	@RequestMapping("/join")
	public String goJoinPage() {
		logger.info("==========joinPage==========");
		return "join";
	}	
	
	//선택한 카테고리 목록 화면에 띄우기
	@RequestMapping(value="/showCategoryItems")
	public String showCategoryItems(String category, Model model) {
		String email = (String)session.getAttribute("sessionEmail");
		categoryList = itemService.getCategory(email);
		
		String allList = "no";
		
		int categoryNum=0; //카테고리 목록 중 선택한 카테고리명과 동일한 위치 찾기용 변수
		if(!category.equals("전체재고")) {
			for (int i = 0; i < categoryList.size(); i++) {
				if(categoryList.get(i).equals(category)) {
					categoryNum = i;
					categoryName = category;
				}
			}			
		}else {//전체재고 네비바 선택시
			itemList = itemService.showItemList(email);
			allList = "yes";
			categoryName = "everything";
		}
		session.setAttribute("categoryName", categoryName);
		System.out.println("전체목록선택유무: "+allList);
		System.out.println("categoryName: "+categoryName);
		
		//선택한 카테고리명으로 DB조회 후 세부내용 가져오기
		ItemVO itemVO = new ItemVO();
		String selectedCategory = categoryList.get(categoryNum);
		itemVO.setCategory(selectedCategory);
		itemVO.setEmail(email);
		List<ItemVO> categoryItems = itemService.showCategoryItems(itemVO); 
		model.addAttribute("categoryItems", categoryItems);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("itemList", itemList);
		model.addAttribute("allList", allList);
		
		return "main";
	}
	
	//전체회원목록 가져오기
	public ArrayList<UserVO> showuserList(){
		userList = new ArrayList<UserVO>();
		//DB에서 회원목록 가져오기
		userList = mainService.showUserList();
		
		return userList;
	}
	
	//DB에 해당아이디에 저장된 목록 유무 확인(0: 목록없음 / 1>: 목록 있음)
	public String checkItemIdx() {
		String email = (String)session.getAttribute("sessionEmail");
		String result = "";
		
		if(email!=null) {
			int resultNum = itemService.checkItemList(email);
			result = ""+resultNum;
			System.out.println("로그인 아이디: "+email+"/ DB재고목록 : "+resultNum);
		}else {
			result = "noSession";
			System.out.println("재고목록유무확인 : "+result);
		}
		
		return result;
	}
	
	//전체재고목록 가져오기
	public ArrayList<ItemVO> showitemList(){
		String email = (String)session.getAttribute("sessionEmail");
		itemList = itemService.showItemList(email);			

		return itemList;
	}
	
	//선택목록 삭제하기
	@ResponseBody
	@RequestMapping(value="/deleteItem", method=RequestMethod.POST)
	public String deleteItem(int idx) {
		String email = (String)session.getAttribute("sessionEmail");
		ItemVO itemVO = new ItemVO();
		int resultNum = 0; //db삭제여부 확인용 변수
		
		itemVO.setEmail(email);
		itemVO.setIdx(idx);
		resultNum = itemService.deleteItem(itemVO);
		
		String result = String.format("[{'resultNum':'%d'}]", resultNum);
		return result;
	}
	
	//로그인하기
	//return으로 jsp가 아닌 데이터 형태 그대로 되돌려보낼 때 기재하기 
	@ResponseBody
	@RequestMapping(value="/checkLogin", method=RequestMethod.POST)
	public String login(UserVO vo) {
		
		userList = showuserList();
		
		String email = vo.getEmail();
		String pwd = vo.getPwd();
		int count = 0; //정보 일치항목 유무 확인용 변수
		int idx; //이메일 일치 인덱스
		
		for (int i = 0; i < userList.size(); i++) {
			if(userList.get(i).getEmail().equals(email)) {
				count++; //이메일 일치시 count 1
				idx = i;
				if(userList.get(idx).getPwd().equals(pwd)) {
					count++; //비밀번호까지 일치시 count 2
					//session에 로그인정보 저장
					session.setAttribute("sessionEmail", userList.get(idx).getEmail());
				}
			}
		}//for
		String result = String.format("[{'count':'%d'}]", count);
		
		return result;
	}
	
	//이메일중복체크
	@ResponseBody
	@RequestMapping(value="/checkEmail", method=RequestMethod.POST)
	public String checkEmail(String email) {
		//전체목록
		userList = showuserList();
		int count = 0;
		
		for (int i = 0; i < userList.size(); i++) {
			if(userList.get(i).getEmail().equals(email)) {
				count++;//겹치는 이메일 존재시 count : 1
			}
		}
		
		String result = String.format("[{'count':'%s'}]", ""+count);
		return result;
	}
	
	//회원가입
	@ResponseBody
	@RequestMapping(value="/checkJoin", method=RequestMethod.POST)
	public String join(UserVO vo) {
		
		int res = 0; //DB에 저장됐는지 확인용 변수
		//회원추가
		res = mainService.insertUser(vo);
		
		String result = String.format("[{'res':'%s'}]", ""+res);
		
		return result;
	}
	
}
