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
	String adminId =  request.getParameter("adminId");
	String adminPw =  request.getParameter("adminPw");
	
	System.out.println(adminId + " : adminId adminLoginAction.jsp");
	System.out.println(adminPw + " : adminPw adminLoginAction.jsp");
	
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
		System.out.println(connection + " : conection adminLoginAction.jsp");
		
		String sql = "SELECT * FROM admin WHERE admin_id=? AND admin_pw=?";
		statement = connection.prepareStatement(sql);
		statement.setString(1, adminId);
		statement.setString(2, adminPw);
		System.out.println(statement + " : statement adminLoginAction.jsp");
		resultSet = statement.executeQuery();
		
		if(resultSet.next()) {
			System.out.println("관리자 로그인 성공");
			// 세션에 아이디값 저장
			System.out.println(resultSet.getString("admin_id") + " : admin_id adminLoginAction.jsp");
			session.setAttribute("sessionAdminId", resultSet.getString("admin_id"));
		} else {
			System.out.println("관리자 로그인 실패");
		}
		
	} catch (Exception e) {
		
	} finally {
		if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
		if (statement != null) try { statement.close(); } catch(SQLException ex) {}
		
		//커넥션 종료
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
	}
	
	// 로그인 성공,실패에 상관없이 adminIndex.jsp로 이동
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
%>
</body>
</html>