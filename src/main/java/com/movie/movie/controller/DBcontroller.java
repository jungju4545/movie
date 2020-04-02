package com.movie.movie.controller;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.List;

import javax.imageio.ImageIO;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.movie.movie.model.Movie;
import com.movie.movie.model.MovieSeat;
import com.movie.movie.model.Theater;
import com.movie.movie.repository.DBRepository;

@Controller
public class DBcontroller {
	
@Autowired
private DBRepository db;
//	여기는 DB에 자료를 넣는 컨트롤러 입니다.
	/**
	 * 좌석을 넣는 controller
	 * DB >> movie_seat
	 * */
	@GetMapping("/dbSeat")
	public String dbSeat(MovieSeat seat){
    
		for (char ch='A'; ch<='G'; ch++) {
			String col = Character.toString(ch);
			for (int i = 1; i <16; i++) {
				
				String row=Integer.toString(i);
				System.out.println(col+" , "+row);
				seat.setRow_seat(row);
				seat.setCol_seat(col);
				System.out.println(seat);
				db.save(seat);
			}
		}
		return "index";
	}
	/**
	 * 여기는 theater DB넣기
	 * (tName,seatId,createDate)
	 * seatId는 1~105까지,
	 * */
	@GetMapping("/DBtheater")
	public String dbTheater(Theater theater) {
		for (int i = 1; i < 5; i++) {
			String number=Integer.toString(i);
			String tName=number+"관";
			System.out.println(tName);
			for (int j = 1; j < 106; j++) {
				theater.setTName(tName);
				String seatId=Integer.toString(j);
				System.out.println(seatId);
				theater.setSeatId(seatId);
				db.saveTheater(theater);
			}
		}
		return"index";
	}
	
	
	/**
	 * 영화를 넣는 controller
	 * DB>>movie
	 * */
	@GetMapping("/dbMovie")
	public String dbMovie(Movie movie,Model model) {
		//영화사이트에서 크롤링 할거임. 상세정보 이미지 다 따올거다.
		int i=0;
		URL url = null;
		BufferedImage bi = null;
		try {
			/*여기는 이미지를 저장받는 코드*/
			Document doc = Jsoup.connect("https://movie.naver.com/movie/running/current.nhn").get();
			Elements contents = doc.select("#content > div.article > div:nth-child(1) > div.lst_wrap > ul > li");
			
			for (Element element : contents) {
				
				/**
				 * i=i+1;
				File outputFile = new File("C:/springTool/img/img"+i+".png");
				이거 안하면 파일이 저장할때마다 덮어씌어진다. for문 돌릴때마다 이름을 바꿔주는 것이다.
				 * */
				
				i=i+1;
				//File 안에 폴더위치와 저장할이미지 형식을 작성한다.
				//C:\springTool\springWork\movie\src\main\resources\static\img\movie_img
//				File outputFile = new File("C:/springTool/img/img"+i+".png");				
				File outputFile = new File("C:/springTool/springWork/movie/src/main/resources/static/img/movie_imgs/movie-img"+i+".png");

			
				String img=element.select("img").attr("src");
				url = new URL(img);
				bi= ImageIO.read(url); // url 읽음
				ImageIO.write(bi,"png",outputFile); 
				/*여기는 movie모델에 들어갈 DB넣는곳*/
				
				System.out.println( "영화제목(title) : "+element.select("img").attr("alt"));
				System.out.println("image(url) : "+element.select("img").attr("src"));
//				String img=element.select("img").attr("src");
				
//				System.out.println(element);
//				System.out.println(element.select("a"));
		
				String[] words = element.select("dd").text().split("\\|");
				// 타입 잘 확인할것
				System.out.println("러닝타임 : "+words[3]);
				movie.setTitle(element.select("img").attr("alt"));
				movie.setImage(element.select("img").attr("src"));
				movie.setRunningTime(words[3]);
			
				// 장르
				Elements elements = element.select("a");
				System.out.print("장르 : ");
				for (Element element2 : elements) {
					if(element2.attr("href").contains("genre")) {
						System.out.print(element2.text()+"  ");
						movie.setGenre(element2.text());
						break;
					}
				}
				System.out.println();
				
				db.saveMovie(movie);
				
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<Movie> movies = db.findAll(movie);
		model.addAttribute("movies",movies);
		return"test";
	}
	
}
