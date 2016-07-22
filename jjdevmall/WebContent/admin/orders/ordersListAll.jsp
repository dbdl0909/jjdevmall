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
	String sessionAdminId = (String)session.getAttribute("sessionAdminId");
	System.out.println(sessionAdminId + " : sessionAdminId ordersListAll.jsp");
	
	if(sessionAdminId == null) { // 로그인이 안된 상태
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
		
	} else {					// 로그인이 된 상태
	%>
		<h1>item 리스트</h1>
		
		<div>
			<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">home으로 돌아가기</a>
		</div>
		
		<div>
		
			<table border=1>
				<tr>
					<td>orders_no</td><td>item_no</td><td>item_name</td><td>member_no</td><td>member_name</td>
					<td>orders_quantity</td><td>orders_rate</td><td>orders_date</td><td>orders_state</td>
				</tr>
	<%
			request.setCharacterEncoding("UTF-8");
			
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
				System.out.println(connection + " : conn ordersListAll.jsp");
				
				String sql = "";
				sql += "SELECT o.orders_no orders_no, o.item_no item_no, i.item_name item_name,";
				sql += " m.member_no member_no, m.member_id member_id, o.orders_quantity orders_quantity, o.orders_rate orders_rate,";
				sql += " o.orders_date orders_date, o.orders_state orders_state";
				sql += " FROM orders o INNER JOIN item i";
				sql += " ON o.item_no = i.item_no";
				sql += " INNER JOIN member m ON o.member_no = m.member_no";
				
				statement = connection.prepareStatement(sql);
				System.out.println(statement + " : pstmt ordersListAll.jsp");
				
				resultSet = statement.executeQuery();
				System.out.println(resultSet + " : resultSet ordersListAll.jsp");
				
				while(resultSet.next()) {
	%>
					<tr>
						<td><%=resultSet.getInt("orders_no")%></td>
						<td><%=resultSet.getString("item_no")%></td>
						<td><%=resultSet.getString("item_name")%></td>
						<td><%=resultSet.getString("member_no")%></td>
						<td><%=resultSet.getString("member_id")%></td>
						<td><%=resultSet.getString("orders_quantity")%></td>
						<td><%=resultSet.getString("orders_rate")%></td>
						<td><%=resultSet.getString("orders_date")%></td>
						<td><%=resultSet.getString("orders_state")%></td>
					</tr>
	<%	
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
			</table>
		</div>
	</body>
</html>