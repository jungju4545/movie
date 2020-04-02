package com.movie.movie.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Bill {
private int id;
private String userId;
private String movieId;
private String placeId;
private String theaterId;
private String seatId;
private String startDate;
private String endDate;
private String price;

// 결제 성공하면 insert 취소하면 remove
private int status;
private Timestamp createDate;
private Timestamp updateDate;
private List<User> user;
private List<Movie> movie;
private List<Place> place;
private List<MovieSeat> seat;
private List<Theater> theater;

}
