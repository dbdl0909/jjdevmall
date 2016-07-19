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
	Integer sessionMemberNo = (Integer)session.getAttribute("sessionMemberNo");
	String sessionMemberId = (String)session.getAttribute("sessionMemberId");
	
	System.out.println(sessionMemberNo + " : sessionMemberNo memberUpdateForm.jsp");
	System.out.println(sessionMemberId + " : sessionMemberId memberUpdateForm.jsp");
	
	if(sessionMemberId == null) { // 로그인이 안된 상태
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		
	} else {
	%>
		<h1><%=sessionMemberId %>님 회원정보 수정</h1>
		
		<form id="updateForm" action="memberUpdateForm.jsp" method="post">
			<table border=1>
		
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
			System.out.println(connection + " : connection memberUpdateForm.jsp");
			
			String sql = "";
			sql += "SELECT m.member_id member_id, m.member_pw member_pw, m.member_name member_name";
			sql += ", m.member_gender member_gender, m.member_age member_age, a.address_addr address_addr";
			sql += " FROM member m LEFT JOIN address a ON m.member_no = a.member_no";
			sql += " WHERE member_id=?";
			
			statement = connection.prepareStatement(sql);
			statement.setString(1, sessionMemberId);
			System.out.println(statement + " : statement memberUpdateForm.jsp");
			
			resultSet = statement.executeQuery();
			System.out.println(resultSet + " : resultSet memberUpdateForm.jsp");
	
			//resultSet의 Row 구하기
			resultSet.last();
			int resultSetRow = resultSet.getRow();
			System.out.println(resultSetRow + " : resultSetRow memberUpdateForm.jsp");
			//resultSet의 커서를 last()로 이동시켰으니, 꼭 다시 first로 이동시켜줘야 한다.
			resultSet.beforeFirst();
			
			//주소가 여러개일때
			int j = 0;
	%>
				<tr>
					<td>아이디</td>
					<td>패스워드</td>
					<td>이름</td>
					<td>성별</td>
					<td>나이</td>
	<%
					for(j=0; j<resultSetRow; j++) {
	%>
						<td>주소 <%=j+1%></td>
	<%
					}
	%>
				</tr>
	<%
			//주소가 여러개일때 배열에 저장한다.
			int count = 0;
			int i = 0;
			String[] address = new String[resultSetRow];
			while(resultSet.next()) {
				System.out.println(count + " : count memberUpdateForm.jsp");
				address[count] = resultSet.getString("address_addr");
				System.out.println(address[count] + " : address[" + count + "] memberUpdateForm.jsp");
				count++;
				
				if(resultSet.isLast()) {
	%>
				<tr>
					<td><%=resultSet.getString("member_id")%></td>
					<td><%=resultSet.getString("member_pw")%></td>
					<td><%=resultSet.getString("member_name")%></td>
					<td><%=resultSet.getString("member_gender")%></td>
					<td><%=resultSet.getString("member_age")%></td>
	<%
					//배열에 담겨있는 값들을 출력한다.
					for(i=0; i<resultSetRow; i++) {
	%>
						<td><%=address[i]%></td>
	<%
					}
	%>						
				</tr>
	<%
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
		</form>
	</body>
</html>