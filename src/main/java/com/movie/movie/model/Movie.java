package com.movie.movie.model;

import java.util.List;

import org.springframework.boot.autoconfigure.AutoConfigureOrder;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AutoConfigureOrder
public class Movie {
private int id;
private String title;
private String image;
private String runningTime;
private String genre;
private List<Screen> screens;
}
