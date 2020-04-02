package com.movie.movie.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MovieSeat {

	private int id;
	private String row_seat;
	private String col_seat;
	private Timestamp createDate;
}
