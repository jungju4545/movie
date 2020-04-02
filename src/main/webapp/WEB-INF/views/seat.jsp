<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<style type="text/css">
.tg  {
border-collapse:collapse;border-spacing:0;
width:60%;
margin:auto;
text-align:center;
}
.tg th{font-family:Arial, sans-serif; width:20px; height:20px; font-size:15px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-0pky{border-color:inherit;text-align:center;vertical-align:top}
.choice{
/* unkown property name 이라는 것은 여기서 오타난거임 */
background:skyblue;
}
.number{
border-style: solid;
border-width:1px;
width:100px;
height:40px;
}

.price{
border-style: solid;
border-width:1px;
width:100px;
height:40px;
text-align:right;
}

</style>
<!-- 테이블 만들때 for문 돌려서 만들어보기 -->
<body>
  <div id="wrapper">
   <%@include file="include/nav.jsp" %>
   
<form action="/payment/payment_table" method="post">    
    <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Portfolio detail</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="#"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Portfolio</a><i class="icon-angle-right"></i></li>
              <li class="active">Portfolio detail</li>
            </ul>
          </div>
        </div>
      </div>
    </section>

   
      <div class="container">
      <div class="screen" style="text-align:center; background-color:black; color:white; margin-top:10px;">screen
      </div>
      <div class="number">
      <span class="ticket">인원 : </span>
      </div>
      
 <!-- 이중for문 돌리기 -->
 <table class="tg">
 <c:forEach var="colSeat" items="${colSeat}" >
  <tr>
   <c:forEach var="rowSeat" items="${rowSeat}" >
   <!-- style="cursor:pointer;" >> 커서포인트 만드는거. -->
  <th class="tg-0pky" style="cursor:pointer;"  value="${colSeat.col_seat}${rowSeat.row_seat}">${colSeat.col_seat}${rowSeat.row_seat}</th>
  </c:forEach>
   </tr>
  </c:forEach>
</table>
  <div class="price">
      <span class="ticketPrice"> : 원</span>
  </div>
  <div class="hidden">
  <input type ="hidden" name ="movieId" value="${movieId}"/>
  <input type ="hidden" name ="placeId" value="${placeId}"/>
  <!-- 여기에 seatId도 넣어야 할거 같은데.. -->
  <input type ="hidden" name ="startDate" value="${startDate}"/>
  <input type ="hidden" name ="endDate" value="${endDate}"/>
  <div class="countInfo" id="count">
  
  </div>
  </div>
  <input type="submit" value="결제" style="float:left;">
  </div>
  </form>
</div>
 
 <%@include file="include/footer.jsp" %>
</body>
<script>
/*
reservation에서 placeId, movieId, startDate,endDate데이터 모두 가지고 오기 
 */

$(document).on('click','.tg-0pky',function(){

	/* class value값 가져오는 방법 
	1. $(this).val();
	2. $(this).attr('value');
	하.. 왜 1번 방법으론 빈값이 넘어오는지 알수없네...
	*/
var classVal=$(this).attr('value');
	/* seatId값을 가져올 방법을 생각해보자 */
	console.log(classVal);
	let seat =classVal.split("")
	console.log("rowSeat : "+seat[0]);
	console.log("colSeat : "+seat[1]);
	/* toggleClass는 스위치 같은 개념이다. 선택한 곳에 클래스를 넣었다 뺄 수 있다. */
	$(this).toggleClass("choice");
	let count =$(".tg-0pky.choice").length;
	$(".countInfo").remove();
	$countInfo = $("<div class='countInfo'>"+
			"<input type='hidden' name='count' value='"+count+"'>"+
			"<input type='hidden' name='price' value='"+10000*count+"'>"+
			"</div>");
	$(".hidden").append($countInfo);
	$SeatInfo = $("<input type='hidden' name='row_seat' value='"+seat[0]+"'>"+
			"<input type='hidden' name='col_seat' value='"+seat[1]+"'>");
	$(".hidden").append($SeatInfo);
	console.log(count);
	$(".ticket").remove();
	$newTicket=$("<span class='ticket'>인원 : "+count+"명</span>");
	$(".number").append($newTicket);

	$(".ticketPrice").remove();
	$newTicketPrice=$("<span class='ticketPrice'>"+10000*count+" : 원</span>");
	$(".price").append($newTicketPrice);

	
});
</script>
</html>
