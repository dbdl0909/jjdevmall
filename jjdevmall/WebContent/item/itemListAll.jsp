<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>item 리스트</h1>
		
		<table border=1>
			<tr>
				<td>no</td><td>상품이름</td><td>가격</td><td>할인율</td><td>주문</td>
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
			System.out.println(connection + " : conn itemListAll.jsp.jsp");
			
			String sql = "SELECT item_no, item_name, item_price, item_rate FROM item";
			statement = connection.prepareStatement(sql);
			System.out.println(statement + " : statement itemListAll.jsp");
			
			resultSet = statement.executeQuery();
			System.out.println(resultSet + " : resultSet itemListAll.jsp");
			
			while(resultSet.next()) {
	%>
				<tr>
					<td><%=resultSet.getInt("item_no")%></td>
					<td><%=resultSet.getString("item_name")%></td>
					<td><%=resultSet.getInt("item_price")%></td>
					<td><%=resultSet.getDouble("item_rate")%></td>
					<td>
						<a href="<%=request.getContextPath()%>/orders/ordersAddForm.jsp?itemNo=<%=resultSet.getInt("item_no")%>">주문</a>
					</td>
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
	%>
		</table>
	</body>
</html>