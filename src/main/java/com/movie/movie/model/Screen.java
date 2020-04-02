package com.movie.movie.model;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.boot.autoconfigure.AutoConfigureOrder;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AutoConfigureOrder
public class Screen {
private int id;
private String movieId;
private String placeId;
private String theaterId;
//private String seatId 추가할것
private String startDate;
private String endDate;
private Timestamp dateTime;
private List<Movie> movies;
private List<Place> places;
//private List<MovieSeat>seats;
}
