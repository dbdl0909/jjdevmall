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
	System.out.println(sessionAdminId + " : sessionAdminId itemListAll.jsp");
	
	if(sessionAdminId == null) { // 로그인이 안된 상태
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
		
	} else {					// 로그인이 된 상태
	%>
		<h1>item 리스트</h1>
		
		<div>
			<a href="<%=request.getContextPath()%>/admin/item/itemAddForm.jsp">상품 추가</a>
		</div>
		
		<div>
		
			<table border=1>
				<tr>
					<td>no</td><td>상품이름</td><td>가격</td><td>할인율</td><td>수정</td><td>삭제</td>
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
				System.out.println(statement + " : pstmt itemListAll.jsp.jsp");
				
				resultSet = statement.executeQuery();
				System.out.println(resultSet + " : resultSet itemListAll.jsp.jsp");
				
				while(resultSet.next()) {
	%>
					<tr>
						<td><%=resultSet.getInt("item_no")%></td>
						<td><%=resultSet.getString("item_name")%></td>
						<td><%=resultSet.getString("item_price")%></td>
						<td><%=resultSet.getString("item_rate")%></td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/item/itemUpdateForm.jsp?send_no=<%=resultSet.getString("item_no")%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/item/itemDeleteAction.jsp?send_no=<%=resultSet.getString("item_no")%>">삭제</a>
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
		}
	%>
			</table>
		</div>
	</body>
</html>