<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				$('#memberId').blur(function() {		//아이디
					if($('#memberId').val() == '') {
						$('#memberIdHelper').text('아이디 입력');
					}
				});
				
				$('#memberPw').blur(function() {		//패스워드
					if($('#memberPw').val() == '') {
						$('#memberPwHelper').text('패스워드 입력');
					}
				});
				
				$('#loginBtn').click(function() {
					if($('#memberId').val() == '') {
						$('#memberIdHelper').text('아이디 입력');
					} else if($('#memberPw').val() == '') {
						$('#memberPwHelper').text('패스워드 입력');
					} else {
						$('#loginForm').submit();
					}
				});
			});
		</script>
	</head>
	<body>
	<h1>INDEX member 로그인</h1>
	<%
		//session영역에 저장되어있는 sessionMemberId에 담겨있는 값을 가져온다.
		Integer sessionMemberNo = (Integer)session.getAttribute("sessionMemberNo");
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
		
		System.out.println(sessionMemberNo + " : sessionMemberNo index.jsp");
		System.out.println(sessionMemberId + " : sessionMemberId index.jsp");
	
		if(sessionMemberId == null) { // 로그인이 안된 상태
	%>
			<form id="loginForm" action="<%=request.getContextPath()%>/member/loginAction.jsp">
				<table>
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" name="memberId" id="memberId"/>
							<span id="memberIdHelper"></span>
						</td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td>
							<input type="password" name="memberPw" id="memberPw"/>
							<span id="memberPwHelper"></span>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<input type="button" id="loginBtn" value="로그인"/>
						</td>
					</tr>
				</table>
			</form>
	<%		
		} else { // 로그인이 된 상태
	%>
			<%=sessionMemberId%>님 반갑습니다.
			<a href="<%=request.getContextPath()%>/member/memberOne.jsp">[회원정보]</a>
			<a href="<%=request.getContextPath()%>/member/logout.jsp">[로그아웃]</a>
			<a href="<%=request.getContextPath()%>/item/itemListAll.jsp">[상품보기]</a>
	<%		
		}
	%>
	</body>
</html>