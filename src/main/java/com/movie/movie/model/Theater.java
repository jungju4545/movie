package com.movie.movie.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Theater {
 private int id;
 // 1관부터 4관까지만 넣을예정
 private String tName;
 private String seatId;
 private List<MovieSeat> seats;
}
