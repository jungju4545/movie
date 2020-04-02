
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>Page Title</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>

<link rel="stylesheet" href="fonts/icomoon/style_a.css">
<link rel="stylesheet" href="css/bootstrap_a.min.css">



<link rel="stylesheet" href="css/style_a.css">


</head>
<body>
	<div class="container">
		<div class="row align-items-center">
			<div class="col-lg-5">
				<div class="feature-car-rent-box-1">
					<h3>결제를 성공하였습니다</h3>
					<ul class="list-unstyled">
					
						<li><span>영화제목</span> <span class="spec">${bill[0].movie[0].title}</span></li>
						<li><span>상영일자</span> <span class="spec">${bill[0].startDate}~${bill[0].endDate}</span></li>
						<li><span>좌석번호</span> <span class="spec">${bill[0].seat[0].col_seat}${bill[0].seat[0].row_seat}</span></li>
						<li><span>예매일자</span> <span class="spec">2020-02-02</span>
						</li>
						<li><span>금액</span> <span class="spec">${bill[0].price}원</span></li>
					</ul>
					<div class="d-flex align-items-center bg-light p-3">
						<span></span> <a class="ml-auto btn btn-primary"
							href="contact.html">완료상영일자</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>