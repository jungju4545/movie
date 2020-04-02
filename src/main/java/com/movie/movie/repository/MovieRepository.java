package com.movie.movie.repository;

import java.util.List;

import com.movie.movie.model.Bill;
import com.movie.movie.model.MovieSeat;
import com.movie.movie.model.Place;
import com.movie.movie.model.Screen;
import com.movie.movie.model.User;

public interface MovieRepository {
	List<MovieSeat> findAll(MovieSeat seat);
	void save(User user);
	User login(User user);
	/**
	 * 해당 지역에 대한 지점들 출력하는 쿼리
	 */
	 List<Place>findPlace(String type);
	 
	 /**
	  * 지점에 대한 상영가능한 영화 출력하는 쿼리
	  * */
	 List<Screen>findMovie(String placeId);
	 String findMovieTitle(String movieId);
	 /**
	  * 지점과 상영가능한 영화의 데이터를 받고 상영가능한 시간 출력하기
	  * */
	 List<Screen> findTime(String placeId, String movieId);
	 /**
	  * 예약할려는 좌석 출력
	  * */
	 List<MovieSeat> findColSeat();
	 List<MovieSeat> findRowSeat();
	 
	 /**
	  * 결제창에 출력할 쿼리
	  * */
	 List<Screen> findInfo(String placeId, String movieId); 
	 
	 /**
	  * /payment/payment_table 에서 같이 넘길 seatId
	  * */
	 List<MovieSeat> findSeatId(String col_seat,String row_seat);
	 
	 /**
	  * insert bill
	  * */
	 void saveBill(Bill bill);
	 /**
	  *결제 결과 출력
	  **/
	  List<Bill> findAllBill(String userId,String movieId,String placeId,String theaterId,String seatId,String startDate,String endDate,String price);
}
