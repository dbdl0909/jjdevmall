<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>address 리스트</h1>
		
		<table border=1>
			<tr>
				<td>address_no</td><td>member_no</td><td>주소</td>
			</tr>
			
	<%
	request.setCharacterEncoding("UTF-8");
	//memberListAll.jsp페이지에서 넘어온 send_no에 담겨있는 값을 memberNo에 담는다.
	String memberNo = request.getParameter("send_no");
	System.out.println(memberNo + " : memberNo memberAddressList.jsp");
	
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
		System.out.println(conn + " : conn memberAddressList.jsp");
		
		
		//SELECT쿼리 문장의 WHERE절에서 memberNo에 담겨있는 값과 DB에 있는 값이 같을때
		//그 줄에 해당하는 컬럼의 데이터들을 가져온다.
		String sql = "SELECT address_no, member_no, address_addr FROM address WHERE member_no=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberNo);
		System.out.println(pstmt + " : pstmt memberAddressList.jsp");
		
		rs = pstmt.executeQuery();
		System.out.println(rs + " : rs memberAddressList.jsp");
		
		while(rs.next()) {
		%>
			<tr>
				<td><%=rs.getString("address_no")%></td>
				<td><%=rs.getString("member_no")%></td>
				<td><%=rs.getString("address_addr")%></td>
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
	
	%>
		</table>
	</body>
</html>