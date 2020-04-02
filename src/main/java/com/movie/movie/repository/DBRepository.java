package com.movie.movie.repository;

import java.util.List;

import com.movie.movie.model.Movie;
import com.movie.movie.model.MovieSeat;
import com.movie.movie.model.Theater;

public interface DBRepository {
void save(MovieSeat seat);
void saveMovie(Movie movie);
List<Movie> findAll(Movie movie);
void saveTheater(Theater theater);
}
