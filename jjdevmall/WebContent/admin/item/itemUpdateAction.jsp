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
		System.out.println(sessionAdminId + " : sessionAdminId itemUpdateForm.jsp");
		
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		System.out.println(itemNo + " : itemNo itemUpdateForm.jsp");
	
		String itemName = request.getParameter("itemName");
		Double itemRate = Double.parseDouble(request.getParameter("itemRate"));
		
		System.out.println(itemName + " : itemName itemUpdateAction.jsp");
		System.out.println(itemRate + " : itemRate itemUpdateAction.jsp");
		
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
			System.out.println(connection + " : connection itemUpdateAction.jsp");
			
			String sqlUpdateItem = "UPDATE item SET item_name=?, item_rate=? WHERE item_no=?";
			statement = connection.prepareStatement(sqlUpdateItem);
			statement.setString(1, itemName);
			statement.setDouble(2, itemRate);
			statement.setInt(3, itemNo);
			System.out.println(statement + " : statement itemUpdateAction.jsp");
			
			int temp = statement.executeUpdate();
			
			if(temp != 0) {
				System.out.println("상품정보 수정 완료!");
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