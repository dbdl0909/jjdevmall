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
		String itemName = request.getParameter("itemName");
		int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
		Double itemRate = Double.parseDouble(request.getParameter("itemRate"));
		
		System.out.println(itemName + " : itemName itemAddAction.jsp");
		System.out.println(itemPrice + " : itemPrice itemAddAction.jsp");
		System.out.println(itemRate + " : itemRate itemAddAction.jsp");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
		String jdbcDriver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "java0000";
		Class.forName(jdbcDriver);
		conn = DriverManager.getConnection(url, dbUser, dbPass);
		System.out.println(conn + " : conn itemAddAction.jsp");
	
		String sqlInsertItem = "INSERT INTO item(item_name, item_price, item_rate) VALUES(?,?,?)";
		stmt = conn.prepareStatement(sqlInsertItem);
		stmt.setString(1, itemName);
		stmt.setInt(2, itemPrice);
		stmt.setDouble(3, itemRate);
		System.out.println(stmt + " : stmt itemAddAction.jsp");
		stmt.executeUpdate();
		
		} finally {
				rs.close();
				stmt.close();
				conn.close();
			}
		
		response.sendRedirect(request.getContextPath() + "/admin/item/itemAddForm.jsp");
		
	%>
	</body>
</html>