<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Insert title here</title>
	</head>
	<body>
	<%
		request.setCharacterEncoding("utf-8");
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		String memberName = request.getParameter("memberName");
		String memberGender = request.getParameter("memberGender");
		String memberAge = request.getParameter("memberAge");
		String addressAddr = request.getParameter("addressAddr");
		
		System.out.println(memberId + " : memberId memberAddAction.jsp");
		System.out.println(memberPw + " : memberPw memberAddAction.jsp");
		System.out.println(memberName + " : memberName memberAddAction.jsp");
		System.out.println(memberGender + " : memberGender memberAddAction.jsp");
		System.out.println(memberAge + " : memberAge memberAddAction.jsp");
		System.out.println(addressAddr + " : addressAddr memberAddAction.jsp");
		
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		ResultSet rs = null;
		
		try {			
			String jdbcDriver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
			String dbUser = "root";
			String dbPass = "java0000";
			Class.forName(jdbcDriver);
			conn = DriverManager.getConnection(url, dbUser, dbPass);
			System.out.println(conn + " : conn memberAddAction.jsp");
			conn.setAutoCommit(false);
			
			String sqlInsertMember = "INSERT INTO member(member_id, member_pw, member_name, member_gender, member_age) VALUES(?,?,?,?,?)";
			stmt1 = conn.prepareStatement(sqlInsertMember, Statement.RETURN_GENERATED_KEYS);
			stmt1.setString(1, memberId);
			stmt1.setString(2, memberPw);
			stmt1.setString(3, memberName);
			stmt1.setString(4, memberGender);
			stmt1.setString(5, memberAge);
			System.out.println(stmt1 + " : stmt1 memberAddAction.jsp");
			stmt1.executeUpdate();
			
			//member 테이블에 INSERT했을때 PRIMARY KEY 가져오기
			rs = stmt1.getGeneratedKeys();
			System.out.println(rs + " : rs memberAddAction.jsp");
			
			int lastKey = 0;
			//stmt1이 제대로 executeUpdate가 됬다면 rs에 PRIMARY KEY 값이 담겨있을 것이다.
			if(rs.next()) {
				lastKey = rs.getInt(1);
				//변수 lastKey에 담겨있는 값은 address테이블의 member_no컬럼의 데이터로 넣을 것이다.
				System.out.println(lastKey + " : lastKey");
			}
			
			if(addressAddr != null) {
				//member테이블에 방금 INSERT한 데이터의 PRIMARY KEY 값인 member_no컬럼의 데이터를 가져와서
				//address테이블의 member_no컬럼의 데이터로 넣는다.
				String sqlInsertAddr = "INSERT INTO address(member_no, address_addr) VALUES(?,?)";
				stmt2 = conn.prepareStatement(sqlInsertAddr);
				stmt2.setInt(1, lastKey);
				stmt2.setString(2, addressAddr);
				System.out.println(stmt2 + " : stmt2 memberAddAction.jsp");
				stmt2.executeUpdate();
				
				//1, 2단계가 성공하면 commit
				conn.commit();
			}
			
		
		} catch(Exception e) {
			conn.rollback();
			e.printStackTrace();
		}
		
		
		response.sendRedirect(request.getContextPath() + "/member/memberAddForm.jsp");
	%>
	</body>
</html>