<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				$('#adminId').blur(function() {		//아이디
					if($('#adminId').val() == '') {
						$('#adminIdHelper').text('아이디 입력');
					}
				});
				
				$('#adminPw').blur(function() {		//패스워드
					if($('#adminPw').val() == '') {
						$('#adminPwHelper').text('패스워드 입력');
					}
				});
				
				$('#loginBtn').click(function() {
					if($('#adminId').val() == '') {
						$('#adminIdHelper').text('아이디 입력');
					} else if($('#adminPw').val() == '') {
						$('#adminPwHelper').text('패스워드 입력');
					} else {
						$('#loginForm').submit();
					}
				});
			});
		</script>
		
	</head>
	<body>
	<%
	//session영역에 저장되어있는 sesessionAdminId를 가져온다.
	String sessionAdminId = (String)session.getAttribute("sessionAdminId");
	System.out.println(sessionAdminId + " : sessionAdminId adminIndex.jsp");
	
	if(sessionAdminId == null) { // 로그인이 안된 상태
	%>
		<h1>admin 로그인</h1>
		<form id="loginForm" action="<%=request.getContextPath()%>/admin/member/adminLoginAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="adminId" id="adminId"/>
						<span id="adminIdHelper"></span>
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<input type="password" name="adminPw" id="adminPw"/>
						<span id="adminPwHelper"></span>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input type="button" id="loginBtn" value="로그인"/>
					</td>
				</tr>
			</table>
		</form>
		
		<div>
				<a href="<%=request.getContextPath()%>/index.jsp">일반회원으로 로그인하기</a>
		</div>
		
	<%		
	} else { // 로그인이 된 상태
	%>
		<ol>
			<li><a href="<%=request.getContextPath()%>/admin/member/adminLogout.jsp">로그아웃</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/item/itemListAll.jsp">상품관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/orders/ordersListAll.jsp">주문관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/member/memberListAll.jsp">회원관리</a></li>
		</ol>
	<%		
	}
	%>
	</body>
</html>