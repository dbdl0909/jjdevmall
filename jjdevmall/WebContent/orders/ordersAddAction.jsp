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
	Integer sessionMemberNo = (Integer)session.getAttribute("sessionMemberNo");
	String sessionMemberId = (String)session.getAttribute("sessionMemberId");
	
	System.out.println(sessionMemberNo + " : sessionMemberNo ordersAddAction.jsp");
	System.out.println(sessionMemberId + " : sessionMemberId ordersAddAction.jsp");
	
	int itemNo = Integer.parseInt(request.getParameter("itemNo"));
	System.out.println(itemNo + " : itemNo ordersAddAction.jsp");
	
	int ordersQuantity = Integer.parseInt(request.getParameter("ordersQuantity"));
	System.out.println(ordersQuantity + " : ordersQuantity ordersAddAction.jsp");
	
	double itemRate = Double.parseDouble(request.getParameter("itemRate"));
	System.out.println(itemRate + " : itemRate ordersAddAction.jsp");
	
	if(sessionMemberId == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	} else {
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
			System.out.println(connection + " : connection ordersAddAction.jsp");
			
			String sql = "";
			sql += "INSERT INTO orders(item_no, member_no, orders_quantity, orders_rate, orders_date)";
			sql += " VALUES(?,?,?,?,SYSDATE())";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, itemNo);
			statement.setInt(2, sessionMemberNo);
			statement.setInt(3, ordersQuantity);
			statement.setDouble(4, itemRate);
			System.out.println(statement + " : statement ordersAddForm.jsp");
			
			int temp = statement.executeUpdate();
			if(temp != 0) {
				System.out.println("주문 성공");
				response.sendRedirect(request.getContextPath() + "/item/itemListAll.jsp");
			}
			
		} catch(SQLException ex) {
			out.println(ex.getMessage());
			ex.printStackTrace();
			
		} finally {
			//사용한 Statement 종료
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (statement != null) try { statement.close(); } catch(SQLException ex) {}
			
			//커넥션 종료
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
	}
	%>
	</body>
</html>