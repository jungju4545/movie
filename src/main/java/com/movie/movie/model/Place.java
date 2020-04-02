package com.movie.movie.model;

import java.util.List;

import lombok.Data;

@Data
public class Place {
private int id;
private String pName;
private String type;
private List<Movie>movies;
}
