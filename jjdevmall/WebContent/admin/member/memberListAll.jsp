<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>member 리스트</h1>
		
		<table border=1>
			<tr>
				<td>no</td><td>아이디</td><td>패스워드</td><td>이름</td><td>성별</td><td>나이</td>
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
		System.out.println(conn + " : conn memberListAll.jsp");
		
		String sql = "SELECT member_no, member_id, member_pw, member_name, member_gender, member_age FROM member";
		pstmt = conn.prepareStatement(sql);
		System.out.println(pstmt + " : pstmt memberListAll.jsp");
		
		rs = pstmt.executeQuery();
		System.out.println(rs + " : rs memberListAll.jsp");
		
		while(rs.next()) {
%>
		<tr>
			<td><%=rs.getString("member_no")%></td>
			<td><%=rs.getString("member_id")%></td>
			<td><%=rs.getString("member_pw")%></td>
			<td><%=rs.getString("member_name")%></td>
			<td><%=rs.getString("member_gender")%></td>
			<td><%=rs.getString("member_age")%></td>
		</tr>
<%	
		}
		
	} catch(SQLException ex) {
		out.println(ex.getMessage());
		ex.printStackTrace();
		
	} finally {
		// 6. 사용한 Statement 종료
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		
		// 7. 커넥션 종료
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
	
	%>
		</table>
	</body>
</html>