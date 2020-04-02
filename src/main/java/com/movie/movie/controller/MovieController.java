package com.movie.movie.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.movie.movie.model.Bill;
import com.movie.movie.model.MovieSeat;
import com.movie.movie.model.Place;
import com.movie.movie.model.Screen;
import com.movie.movie.model.User;
import com.movie.movie.repository.MovieRepository;

@Controller
public class MovieController {

	@Autowired
	private MovieRepository mr;
	
	/**
	 * 각 지역에 대한 지점
	 * */
	@GetMapping("/place")
	public @ResponseBody List<Place> test(@RequestParam("type")String type,Model model) {
		List<Place>places =mr.findPlace(type);
		//jsp에서 data형태로 날아감s
		return places;
	}
	
	/**
	 * screen 뿌리기
	 * */
	@GetMapping("movie/place")
	public@ResponseBody List<Screen> screen(@RequestParam("placeId")String placeId){
		List<Screen>screens=mr.findMovie(placeId);
		return screens;
	}
	/**
	 * 각 영화에 대한 상영가능한 시간 뿌리기(startDate,endDate)
	 * */
	@GetMapping("place/screen")
	public @ResponseBody List<Screen> time(
			@RequestParam("placeId") String placeId,
			@RequestParam("movieId") String movieId
			){
//		System.out.println(placeId);
//		System.out.println(movieId);
		List<Screen> times=mr.findTime(placeId, movieId);
//		System.out.println(times);
		return times;
	}
	
	/**
	 * 좌석 출력하기
	 * */
	@GetMapping("/seat")
	public String seat(Model model,
			@RequestParam String movieId,
			@RequestParam String placeId,
			@RequestParam String startDate,
			@RequestParam String endDate
			) {
		//reservation에서 placeId,movieId,startDate,endDate 다 가져와보자
//		System.out.println(movieId);
//		System.out.println(placeId);
//		System.out.println(startDate);
//		System.out.println(endDate);
		
		model.addAttribute("placeId",placeId);
		model.addAttribute("movieId",movieId);
		model.addAttribute("startDate",startDate);
		model.addAttribute("endDate",endDate);
		List<MovieSeat>colSeat=mr.findColSeat();
		List<MovieSeat> rowSeat = mr.findRowSeat();
		model.addAttribute("colSeat",colSeat);
		model.addAttribute("rowSeat",rowSeat);
		return "seat";
	}
	
	
	
	@GetMapping("/home")
	public String test() {
		return"/index";
	}
	
	
	/**
	 * 좌석선택하면 결제창으로 넘어가기
	 * 그곳에 있는 value값 전부 가지고 오기
	 * 결제창에 전부 출력해서 보여줘야함
	 * */
	@PostMapping("/payment/payment_table")
	public String payment(
			Model model,
			@RequestParam("movieId") String movieId,
			@RequestParam("placeId") String placeId,
			@RequestParam String startDate,
			@RequestParam String endDate,
			@RequestParam String row_seat,
			@RequestParam String col_seat,
			@RequestParam String price,
			@RequestParam String count
			) {
		/**
		 * 영화제목, 지점, 상영관 정보가 필요함.
		 * 레파지토리에 placeId,movieId 순서로 작성을 했기 때문에 이 순서를 따르시오...근데 왜??
		 * List<Screen> findInfo(String placeId, String movieId); 
		 * */
		List<Screen>Screen=mr.findInfo(placeId,movieId);
		System.out.println(Screen);
		System.out.println(placeId);
		System.out.println(movieId);
		model.addAttribute("info",Screen);
		model.addAttribute("placeId",placeId);
		model.addAttribute("movieId",movieId);
		model.addAttribute("startDate",startDate);
		model.addAttribute("endDate",endDate);
		model.addAttribute("price",price);
		model.addAttribute("count", count);
		String[] rowSeat =row_seat.split(",");
		String[] colSeat =col_seat.split(",");
		model.addAttribute("rowSeat",rowSeat);
		model.addAttribute("colSeat",colSeat);
//		System.out.println(price);
//		System.out.println(count);
		System.out.println(row_seat);// A,B,C,D 이런식으로 출력됨
		System.out.println(col_seat);
		for (int i = 0; i < colSeat.length; i++) {
			System.out.println(rowSeat[i]+" : "+colSeat[i]);
			List<MovieSeat> seatId = mr.findSeatId(rowSeat[i],colSeat[i]);
			model.addAttribute("seatId",seatId);
		}
		// mr.findByplaceId >> 지점
		// mr.findBymovieId >> 영화이름
		// mr.seat
		return"/payment/payment_table";
	}
	
	
	
	
	/**
	 * 회원가입
	 * */
	@PostMapping("user/join")
	public String join(User user) {
		mr.save(user);
		return "redirect:/home";
	}
	
	/**
	 * 로그인
	 * */
	@PostMapping("user/login")
	public String login(User user,HttpSession session) {
		User userState = mr.login(user);
		System.out.println(userState);
		if(userState != null) {
			System.out.println("login Success");
			session.setAttribute("user", userState);
			return "redirect:/home";
		}else {
			System.out.println("login Fail");
			return "redirect:/home";
		}
		
	}
	
	/**
	 * reservation
	 * 가지고 와야 하는 데이터  >> user, 만약 로그인 안했으면 로그인부터 먼저 하도록
	 * 뿌려야 하는 데이터 >> place, movie
	 * */
	@GetMapping("/reservation")
	public String reservation(User user,HttpSession session) {
		
		Object userValue=session.getAttribute("user");
		System.out.println("value : "+userValue);
		if(userValue!=null) {
			return"/reservation";
		}else {
		
		return"redirect:/home";	
		}
		
	}
	
	/**
	 * 여기는 결제를 눌렀을때 넘어가는 창
	 * bill 모델 만들어서 클릭으로 가져온 데이터 모두 넣을 수 있도록(insert)
	 * */
	@PostMapping("/success")
	public String success(Bill bill, Model model) {
		System.out.println(bill);
		String userId=bill.getUserId();
		String movieId=bill.getMovieId();
		String placeId=bill.getPlaceId();
		String theaterId=bill.getTheaterId();
		String seatId=bill.getSeatId();
		String startDate=bill.getStartDate();
		String endDate = bill.getEndDate();
		String price = bill.getPrice();
		int status = 1;
		/**
		 * 좌석이 2개 이상일때 DB에는 1,2이렇게 들어간다.
		 * 좌석의 갯수만큼 split으로 쪼갠 후 for문 돌려서 DB에 하나하나씩 집어넣어야 한다.
		 * */
		bill.setUserId(userId);
		bill.setMovieId(movieId);
		bill.setPlaceId(placeId);
		bill.setTheaterId(theaterId );
		bill.setSeatId(seatId );
		bill.setStartDate(startDate );
		bill.setEndDate(endDate );
		bill.setPrice( price);
		bill.setStatus(status);
		mr.saveBill(bill);
		
		List<Bill>selectBill=mr.findAllBill(userId,movieId,placeId,theaterId,seatId,startDate,endDate,price);
		System.out.println(selectBill);
		model.addAttribute("bill",selectBill);
		return "/payment/payment_success";
	}
	
	/**
	 * 여기는 테스트용
	 * */
	@GetMapping("/test")
	public String test(Model model) {
		String placeId="1";
		String movieId="2";
		List<Screen> Screen=mr.findInfo(placeId, movieId);
		System.out.println(Screen);
		model.addAttribute("test",Screen);
		return "test";
	}
	
	
	
	@GetMapping("/11")
	public String test3() {
		return"/payment/payment_cancel";
	}
	@GetMapping("/success")
	public String test4() {
		return"/payment/payment_success";
	}

	@GetMapping("/refund")
	public String test6() {
		return"/payment/refund";
	}
	@GetMapping("/detail")
	public String test7() {
		return"/userdetail";
	}
}
