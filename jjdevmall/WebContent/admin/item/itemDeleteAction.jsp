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
	String sessionAdminId = (String)session.getAttribute("sessionAdminId");
	System.out.println(sessionAdminId + " : sessionAdminId itemDeleteAction.jsp");
	
	int itemNo = Integer.parseInt(request.getParameter("send_no"));
	System.out.println(itemNo + " : itemNo itemDeleteAction.jsp");
	
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
		System.out.println(connection + " : connection itemDeleteAction.jsp");
		
		String sqlDeleteItem = "DELETE FROM item WHERE item_no=?";
		statement = connection.prepareStatement(sqlDeleteItem);
		statement.setInt(1, itemNo);
		System.out.println(statement + " : statement itemUpdateAction.jsp");
		
		int temp = statement.executeUpdate();
		
		if(temp != 0) {
			System.out.println("상품 삭제 완료!");
			response.sendRedirect(request.getContextPath() + "/admin/item/itemListAll.jsp");
		}
		
		
	} catch (SQLException ex) {
		out.println(ex.getMessage());
		ex.printStackTrace();
		
	} finally {
		//사용한 Statement 종료
		if (statement != null) try { statement.close(); } catch(SQLException ex) {}
		
		//커넥션 종료
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
	}
	%>
	</body>
</html>