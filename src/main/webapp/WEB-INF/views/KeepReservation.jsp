<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  
 
   <!--body부분 부트스트렙-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <style>
   
    .col{
      width: 100%;
    
    }
    ul.link-list >a>li.local{
      padding: 12px 18px;
    }
  .group-top{
    background-color:black;
    color: white;
  }
  .group-top>h4{
    color: white;
    text-align: center;
  }
  
</style>
</head>

<body>
  <div id="wrapper">
   <%@include file="include/nav.jsp" %>

    <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>예매하기</h2>
            </div>
          </div>
          <div class="span8">
            
          </div>
        </div>
      </div>
    </section>

    <div class="container-fluid">
     <br><br>
      <div class="row" style="height: 100%; margin: 20px;">
        
        <!--지역선택하기-->
        <div class="col" style="background-color:#F5F5F5; font-size: large; padding: 0px; height: 700px;">
        <div class="group-top">
         <h4>영화관</h4>
        </div>
        <div calss ="row1" style="display:flex; margin-top: -20px; height: 95.7%;">
        <div calss="area" style="width: 50%; ">
          <ul class="link-list">
            <a href="#"><li class="local" value="1">서울</li></a>
            <a href="#"><li class="local" value="2">경기/인천</li></a>
            <a href="#"><li class="local" value="3">충청/대전</li></a>
            <a href="#"><li class="local" value="4">전라/광주</li></a>
            <a href="#"><li class="local" value="5">경북/대구</li></a>
            <a href="#"><li class="local" value="6">경남/부산/울산</li></a>
            <a href="#"><li class="local" value="7">강원</li></a>
            <a href="#"><li class="local" value="8">제주</li></a>
           
          </ul>
        </div>
        <!-- 지역>> ajax처리하기. -->
        <div calss="place" style="width: 50%; height: 100%;  background-color: white; ">
          <ul class="link-list" id="place" style="overflow: auto; height: 100%;">
           
            <div class="placeList">
           
            
            </div>
          </ul>
        </div>

      </div>
        </div>

        <!--영화선택하기-->
        <div class="col" style="background-color:#F5F5F5;font-size: large ;padding: 0px; height: 710px;">
          <div class="group-top">
            <h4>영화선택</h4>
           </div>
         
            <div class="movies" >
            <ul class="link-list" id="movie" style="overflow: auto; height: 635px; position: relative;">
            
            <div class="movieList">
              
              </div>
            </ul>
          </div>
          
        </div>
        
        <div class="col" style="background-color:#F5F5F5;font-size: large;padding: 0px;">
          <div class="group-top">
            <h4>today</h4>
           </div>
           <!--달력-->
           <div>
            여기는 달력넣는 곳
           </div>

           <!--상영시간-->
          
           <ul class="link-list" id="time" style="display:flex">
           <div class="timeList">
            <li>
              <button type="button" class="btn btn-default">Default</button>
            </li>
            </div>
          </ul>
        <input type="submit" class="submit" value="결제">
        </div>
        
      </div>
     
    </div>
  </div>
    <%@include file="include/footer.jsp" %>

</body>
<script>
$(".local").click(function(){
	//클릭한 로컬클래스의 value값 가지고 오기
var classVal=$(this).val();
type = classVal;

$.ajax({
	method:"get",
	url:"place?type="+type,
	dataType:'json',
	success:function(data){
	    $(".placeList").remove();
		$newPlaceList=$("<div class='placeList'></div>")
		$("#place.link-list").append($newPlaceList)
	    for(let place of data){
	    	let $placeList=$(
	    	    	//각 지점마다 링크 걸어놓기
	    	    	"<a href='#'><li class='placeDetail' value='"+place.id+"' >"+place.pname+"</li></a>"
	    	    	);
	    	$newPlaceList.append($placeList);
		    }
		},
	erroe:function(data){
		alert("error")
		}
	});
});
/* ajax로 만들어진 element를 클릭할때 발생하는 이벤트 만드는 법 
 * ajax로 placeDetail클래스를 만들어서 $(".placeDetail").click()이렇게 했는데 안됨...
 $(document).on('click', '.placeDetail', function(){}); 이렇게 하니깐 되네...
 */
/*절대 아이디로 하지말것! 한번밖에 안됨...*/
$(document).on('click', '.placeDetail', function(){
	var classValue = $(this).val();
	placeId=classValue;

	$.ajax({
		method:"get",
		url:"movie/place?placeId="+placeId,
		dataType:'json',
		success:function(data){
			  $(".movieList").remove();
				$newMovieList=$("<div class='movieList'></div>")
				$("#movie.link-list").append($newMovieList)
			    for(let list of data){
			    	let $moiveList=$(
			    	    	//각 지점마다 링크 걸어놓기
			    	    	"<a href='#'><li class='movieDetail' value='"+list.movieId+"' >"+list.movies[0].title+"</li></a>"
			    	    	);
			    	$newMovieList.append($moiveList);
				    }
			
			},
		error:function(data){
			console.log("error");
			}
		});

	/* placeId,movieId를 받아 sreen의 startDate,endDate출력하기 */
	$(document).on('click','.movieDetail',function(){

		var movieId = $(this).val();
/*영화 클릭시 상영시간 출력 ajax시작 */
	$.ajax({
		method:"get",
		url:"place/screen?placeId="+placeId+"&movieId="+movieId,
		dateType:"json",
		success:function(data){
			$(".timeList").remove();
			$newTimeList=$("<div class='timeList'></div>");
			$("#time.link-list").append($newTimeList);
			for(let list of data){
				$timeList = $(
						"<li>"+
              "<button type='button' class='btn btn-default'>"+list.startDate+"~"+list.endDate+"</button>"+
            "</li>"		
					);
				$newTimeList.append($timeList);
				}
			},
		error:function(data){
			alert("error");
			}
		});
	

	/* 상영시간 JQuery start */
	$(document).on('click','.btn btn-default',function(){
		var date = $(this).val
	console.log("placeId : "+placeId);
	console.log("movieId : "+movieId);
	console.log("date : "+date);
	
		});
	
	/* 상영시간 JQuery end */
	
		
    /* ajax끝 */

    /* placeId, movieId, startDate,endDate 다 받아서 seat로 넘어가기. */
    
    
		});
	/* placeId,movieId를 받아 sreen의 startDate,endDate출력하기 끝 */
});
/* placeDetail 끝 */

</script>

</html>
