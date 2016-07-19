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
	String sessionMemberId = (String)session.getAttribute("sessionMemberId");
	System.out.println(sessionMemberId + " : sessionMemberId memberOne.jsp");
	
	if(sessionMemberId == null) { // 로그인이 안된 상태
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		
	} else {
	%>
		<h1><%=sessionMemberId %>님의 회원정보</h1>
		
		<table border=1>
			<tr>
				<td>아이디</td><td>패스워드</td><td>이름</td><td>성별</td><td>나이</td><td>주소</td>
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
			System.out.println(connection + " : connection memberOne.jsp");
			
			String sql2 = "";
			sql2 += "SELECT m.member_id member_id, m.member_pw member_pw, m.member_name member_name";
			sql2 += ", m.member_gender member_gender, m.member_age member_age, a.address_addr address_addr";
			sql2 += " FROM member m LEFT JOIN address a ON m.member_no = a.member_no";
			sql2 += " WHERE member_id=?";
			statement = connection.prepareStatement(sql2);
			statement.setString(1, sessionMemberId);
			System.out.println(statement + " : statement memberOne.jsp");
			
			resultSet = statement.executeQuery();
			System.out.println(resultSet + " : resultSet memberOne.jsp");
			String address = "";
			while(resultSet.next()) {
				address += resultSet.getString("address_addr");
				
				if(resultSet.isLast()) {
	%>
				<tr>
					<td><%=resultSet.getString("member_id")%></td>
					<td><%=resultSet.getString("member_pw")%></td>
					<td><%=resultSet.getString("member_name")%></td>
					<td><%=resultSet.getString("member_gender")%></td>
					<td><%=resultSet.getString("member_age")%></td>
					<td><%=address%></td>
				</tr>
	<%
				} else if(!resultSet.isLast()) {
					//커서의 위치가 마지막인지 여부를 조사해서 아니라면 쉼표를 찍는다.
					address += ", ";
				}
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
	</body>
</html>