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
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}

</style>
<!-- 테이블 만들때 for문 돌려서 만들어보기 -->
<body>
  <div id="wrapper">
   <%@include file="include/nav.jsp" %>
   <h1> ${test[0].movies[0].title}</h1>
   <h1> ${test[0].places[0].PName}</h1>
 <%@include file="include/footer.jsp" %>
</body>

</html>
