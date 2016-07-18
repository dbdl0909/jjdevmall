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
		request.setCharacterEncoding("utf-8");
		String item_name = request.getParameter("item_name");
		int item_price = Integer.parseInt(request.getParameter("item_price"));
		Double item_rate = Double.parseDouble(request.getParameter("item_rate"));
		
		System.out.println(item_name + " : item_name itemAddAction.jsp");
		System.out.println(item_price + " : item_price itemAddAction.jsp");
		System.out.println(item_rate + " : item_rate itemAddAction.jsp");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String jdbcDriver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "java0000";
		Class.forName(jdbcDriver);
		conn = DriverManager.getConnection(url, dbUser, dbPass);
		System.out.println(conn + " : conn itemAddAction.jsp");
	
		String sqlInsertItem = "INSERT INTO item(item_name, item_price, item_rate) VALUES(?,?,?)";
		stmt = conn.prepareStatement(sqlInsertItem);
		stmt.setString(1, item_name);
		stmt.setInt(2, item_price);
		stmt.setDouble(3, item_rate);
		System.out.println(stmt + " : stmt itemAddAction.jsp");
		stmt.executeUpdate();
		
		response.sendRedirect(request.getContextPath() + "/admin/item/itemAddForm.jsp");
		
	%>
	</body>
</html>