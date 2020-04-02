package com.movie.movie.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class User {
private int id;
private String name;
private String userId;
private String password;
private Timestamp createTime;
}
