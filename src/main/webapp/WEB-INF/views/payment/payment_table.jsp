<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    
    <title>Payment</title>
    <meta charset="utf-8">

    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='/css/payment_a.css'>
    <style>
        table, td{
            
        }
        table{
            border-collapse: collapse;
            width: 60%;
            height: 800px;
            
        }
        
    </style>
    <script src="/js/all_a.min.js"></script> 

</head>
<body>
<form action="/success" method="post">
    <table style="margin-left: auto; margin-right: auto;">
        <tr class="line1">
            <td>예매정보</td>
            <td>결제수단</td>
            <td>결제하기</td>
        </tr>
        <tr class="line2">
            <td width = "270px"><img src="img/movie_imgs/movie-img1.png" alt="대체텍스트" width="90%" height="80%">
            </td>
            <td bgcolor="#a0a0a0">
                <strong>최종 결제수단</strong>
                <br>
                <br>
                    <button><span class="fa-stack fa-2x" ><i class="far fa-credit-card"></i><br><div style="font-size: 15px;">신용카드</div></span></button>
                    <button><span class="fa-stack fa-2x" ><i class="far fa-credit-card"></i><br><div style="font-size: 15px;">간편결제</div></span></button>

				
            </td>
            <td rowspan="2"></td>
        </tr>
        <tr class="line3">
            <div class="text1">
            <!-- Screen에 movies,places는 리스트의 형태로 내가 설정했기 때문에 데이터를 출력할때도 그 형식에 맞춰서 출력할것 -->
            <td><strong>&nbsp;&nbsp;영화제목 : ${info[0].movies[0].title}</strong><br></div>
             <input type ="hidden" name="movieId" value="${info[0].movieId}">
                &nbsp;&nbsp;영화관 : ${info[0].places[0].PName}  9관 <br>
                <input type ="hidden" name="placeId" value="${info[0].placeId}">
                &nbsp;&nbsp;구매자 : ${user.userId}<br>
                <input type ="hidden" name="userId" value="${user.id}">
                <!-- seatId만 input으로 넘길것. -->
                <c:forEach var="i" begin="0" end="${fn:length(rowSeat)-1}">
                ${rowSeat[i]}${colSeat[i]}
                <input type="hidden" name="seatId" value="${seatId[0].id}">
                <input type="hidden" name="theaterId" value="${info[0].theaterId}">
                </c:forEach>
                
                <br>
                &nbsp;&nbsp;일시  2020-02-24(월) ${startDate}~${endDate}<br>
                <input type="hidden" name="startDate" value="${startDate}">
                <input type="hidden" name="endDate" value="${endDate}">
                &nbsp;&nbsp;인원  성인${count}
                
            </td>
            <td rowspan="4" bgcolor="#a0a0a0">
        
                    
            </td>
            <br>
            
        </tr>
        <tr class="line4"> 
            <td rowspan="3"></td>
            <td bgcolor="#392f31">상품금액 : ${price}원</td>
            <input type="hidden" name="price" value="${price}">
        </tr>
        <tr class="line4"bgcolor="#392f31">
            <td>결제금액: ${price}원</td>
        </tr>
        <tr class="line4" bgcolor="red">
            <td> <div class="solidButton2"><a href="#"><input type="submit" value="결제하기"></a></div></td>
        </tr>
    </table>
    </form>
</body>
</html>