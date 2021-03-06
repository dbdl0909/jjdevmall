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
		
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;

		try {
			String jdbcDriver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=UTF-8";
			String dbUser = "root";
			String dbPass = "java0000";
			Class.forName(jdbcDriver);
			connection = DriverManager.getConnection(url, dbUser, dbPass);
			System.out.println(connection + " : connection itemAddAction.jsp");
		
			String sqlInsertItem = "INSERT INTO item(item_name, item_price, item_rate) VALUES(?,?,?)";
			statement = connection.prepareStatement(sqlInsertItem);
			statement.setString(1, itemName);
			statement.setInt(2, itemPrice);
			statement.setDouble(3, itemRate);
			System.out.println(statement + " : statement itemAddAction.jsp");
			statement.executeUpdate();
			
		} catch (SQLException ex) {
			out.println(ex.getMessage());
			ex.printStackTrace();
			
		} finally {
			//사용한 Statement 종료
			if (statement != null) try { statement.close(); } catch(SQLException ex) {}
			
			//커넥션 종료
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/item/itemListAll.jsp");
		
	%>
	</body>
</html>