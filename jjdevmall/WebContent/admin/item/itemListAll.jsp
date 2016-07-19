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
		
		<table border=1>
			<tr>
				<td>no</td><td>상품이름</td><td>가격</td><td>할인율</td>
			</tr>
	<%
		request.setCharacterEncoding("UTF-8");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String jdbcDriver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=UTF-8";
			String dbUser = "root";
			String dbPass = "java0000";
			Class.forName(jdbcDriver);
			conn = DriverManager.getConnection(url, dbUser, dbPass);
			System.out.println(conn + " : conn itemListAll.jsp.jsp");
			
			String sql = "SELECT item_no, item_name, item_price, item_rate FROM item";
			pstmt = conn.prepareStatement(sql);
			System.out.println(pstmt + " : pstmt itemListAll.jsp.jsp");
			
			rs = pstmt.executeQuery();
			System.out.println(rs + " : rs itemListAll.jsp.jsp");
			
			while(rs.next()) {
	%>
				<tr>
					<td><%=rs.getString("item_no")%></td>
					<td><%=rs.getString("item_name")%></td>
					<td><%=rs.getString("item_price")%></td>
					<td><%=rs.getString("item_rate")%></td>
				</tr>
	<%	
			}
			
		} catch(SQLException ex) {
			out.println(ex.getMessage());
			ex.printStackTrace();
			
		} finally {
			//사용한 Statement 종료
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			
			//커넥션 종료
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}
	%>
		</table>
	</body>
</html>