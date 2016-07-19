<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String memberId =  request.getParameter("memberId");
	String memberPw =  request.getParameter("memberPw");
	
	System.out.println(memberId + " : memberId loginAction.jsp");
	System.out.println(memberPw + " : memberPw loginAction.jsp");

	Connection connection = null;
	PreparedStatement statement = null;
	ResultSet resultSet = null;
	
	try{
		String jdbcDriver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=UTF-8";
		String dbUser = "root";
		String dbPass = "java0000";
		Class.forName(jdbcDriver);
		connection = DriverManager.getConnection(url, dbUser, dbPass);
		System.out.println(connection + " : connection loginAction.jsp");
		
		String sql = "SELECT * FROM member WHERE member_id=? AND member_pw=?";
		statement = connection.prepareStatement(sql);
		statement.setString(1, memberId);
		statement.setString(2, memberPw);
		System.out.println(statement + " : statement loginAction.jsp");
		resultSet = statement.executeQuery();
		
		if(resultSet.next()) {
			System.out.println("로그인 성공");
			// 세션에 아이디값 저장
			System.out.println(resultSet.getInt("member_no") + " : member_no loginAction.jsp");
			System.out.println(resultSet.getString("member_id") + " : member_id loginAction.jsp");
			session.setAttribute("sessionMemberNo", resultSet.getInt("member_no"));
			session.setAttribute("sessionMemberId", resultSet.getString("member_id"));
		} else {
			System.out.println("로그인 실패");
		}
	} catch (Exception e) {
		
	} finally {
		if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
		if (statement != null) try { statement.close(); } catch(SQLException ex) {}
		
		//커넥션 종료
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
	}
	// 로그인 성공,실패에 상관없이 index.jsp로 이동
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>
</body>
</html>