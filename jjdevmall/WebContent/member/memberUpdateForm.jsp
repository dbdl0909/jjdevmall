<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script>
			$(document).ready(function() {				
				$('#updateBtn').click(function() {
					if($('#memberPw').val() == '') {
						$('#memberPwHelper').text('패스워드를 적어주세요');
						$('#memberPw').focus();
					} else if($('#memberName').val() == '') {
						$('#memberNameHelper').text('이름을 적어주세요');
						$('#memberName').focus();
					} else if($('.memberGender').val().length == 0) {
						$('#memberGenderHelper').text('성별을 선택해주세요');
					} else if($('#addressAddr').val() == '') {
						$('#addressAddrHelper').text('주소를 적어주세요');
					} else if($('#memberAge').val() == '' || $('#memberAge').val()<=0 || isNaN($('#memberAge').val())) {
						$('#memberAgeHelper').text('할인율을 적어주세요, 숫자만 가능');
						$('#memberAge').focus();
					} else {
						$('#updateForm').submit();
					}
				});
			});
		</script>
		
	</head>
	<body>
	<%
	Integer sessionMemberNo = (Integer)session.getAttribute("sessionMemberNo");
	String sessionMemberId = (String)session.getAttribute("sessionMemberId");
	
	System.out.println(sessionMemberNo + " : sessionMemberNo memberUpdateForm.jsp");
	System.out.println(sessionMemberId + " : sessionMemberId memberUpdateForm.jsp");
	
	int resultSetRow = 0;
	int j = 0;
	
	String memberId = null;
	String memberPw = null;
	String memberName = null;
	String memberGender = null;
	int memberAge = 0;
	String[] address = null;
	
	if(sessionMemberId == null) { // 로그인이 안된 상태
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		
	} else {
	%>
		<h1><%=sessionMemberId %>님 회원정보 수정</h1>
		
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
			resultSetRow = resultSet.getRow();
			System.out.println(resultSetRow + " : resultSetRow memberUpdateForm.jsp");
			//resultSet의 커서를 last()로 이동시켰으니, 꼭 다시 first로 이동시켜줘야 한다.
			resultSet.beforeFirst();

			//주소가 여러개일때 배열에 저장한다.
			int count = 0;
			int i = 0;
			address = new String[resultSetRow];
			while(resultSet.next()) {
				System.out.println(count + " : count memberUpdateForm.jsp");
				address[count] = resultSet.getString("address_addr");
				System.out.println(address[count] + " : address[" + count + "] memberUpdateForm.jsp");
				count++;
				
				if(resultSet.isLast()) {
					memberId = resultSet.getString("member_id");
					memberPw = resultSet.getString("member_pw");
					memberName = resultSet.getString("member_name");
					memberGender = resultSet.getString("member_gender");
					memberAge = resultSet.getInt("member_age");
					
					System.out.println(memberId + " : memberId memberUpdateForm.jsp");
					System.out.println(memberPw + " : memberPw memberUpdateForm.jsp");
					System.out.println(memberName + " : memberName memberUpdateForm.jsp");
					System.out.println(memberGender + " : memberGender memberUpdateForm.jsp");
					System.out.println(memberAge + " : memberAge memberUpdateForm.jsp");
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
		<form id="addForm" action="<%=request.getContextPath()%>/member/memberAddAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly"/>
						<span id="memberIdHelper"></span>
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<input type="password" name="memberPw" id="memberPw" value="<%=memberPw%>"/>
						<span id="memberPwHelper"></span>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="memberName" id="memberName" value="<%=memberName%>"/>
						<span id="memberNameHelper"></span>
					</td>
				</tr>
	<%
				if(memberGender.equals("male")) {
	%>						
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="memberGender" class="memberGender" value="male" checked="checked"/>남
						<input type="radio" name="memberGender" class="memberGender" value="female"/>여
						<span id="memberGenderHelper"></span>
					</td>
				</tr>
	<%
				} else {
	%>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="memberGender" class="memberGender" value="male"/>남
						<input type="radio" name="memberGender" class="memberGender" value="female" checked="checked"/>여
						<span id="memberGenderHelper"></span>
					</td>
				</tr>	
	<%
				}
	%>
				<tr>
					<td>나이</td>
					<td>
						<input type="text" name="memberAge" id="memberAge" value="<%=memberAge%>"/>
						<span id="memberAgeHelper"></span>
					</td>
				</tr>
	<%
				for(j=0; j<resultSetRow; j++) {
	%>
				<tr>
					<td>주소 <%=j+1%></td>
					<td>
						<input type="text" name="addressAddr" id="addressAddr" value="<%=address[j]%>"/>
						<span id="addressAddrHelper"></span>
					</td>
				</tr>
	<%
				}
	%>
				<tr>
					<td colspan=2>
						<input type="button" id="updateBtn" value="수정하기"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>