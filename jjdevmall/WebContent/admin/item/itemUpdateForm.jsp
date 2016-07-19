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
					if($('#itemName').val() == '') {
						$('#itemNameHelper').text('상품이름을 적어주세요');
						$('#itemName').focus();
					} else if($('#itemRate').val() == '' || $('#itemRate').val()>=1 || isNaN($('#itemRate').val())) {
						$('#itemRateHelper').text('할인율을 적어주세요, 숫자만 가능');
						$('#itemRate').focus();
					} else {
						$('#updateForm').submit();
					}
				});
			});
		</script>
		
	</head>
	<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String sessionAdminId = (String)session.getAttribute("sessionAdminId");
	System.out.println(sessionAdminId + " : sessionAdminId itemUpdateForm.jsp");
	
	int itemNo = Integer.parseInt(request.getParameter("send_no"));
	System.out.println(itemNo + " : itemNo itemUpdateForm.jsp");
	
	String itemName = "";
	int itemPrice = 0;
	double itemRate = 0;
	
	if(sessionAdminId == null) { // 로그인이 안된 상태
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
		
	} else {					// 로그인이 된 상태
	%>
		<h1>item 리스트</h1>
		
	<%
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
			System.out.println(connection + " : connection itemUpdateForm.jsp.jsp");
			
			String sql = "SELECT item_name, item_price, item_rate FROM item WHERE item_no=?";
			statement = connection.prepareStatement(sql);
			statement.setInt(1, itemNo);
			System.out.println(statement + " : statement itemUpdateForm.jsp");
			
			resultSet = statement.executeQuery();
			System.out.println(resultSet + " : resultSet itemUpdateForm.jsp");

			if(resultSet.next()) {
				System.out.println(itemNo + " : itemNo itemUpdateForm.jsp");
				
				itemName = resultSet.getString("item_name");
				System.out.println(itemName + " : itemName itemUpdateForm.jsp");
				
				itemPrice = resultSet.getInt("item_price");
				System.out.println(itemPrice + " : itemPrice itemUpdateForm.jsp");
				
				itemRate = resultSet.getDouble("item_rate");
				System.out.println(itemRate + " : itemRate itemUpdateForm.jsp");
				
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
		<form id="updateForm" action="<%=request.getContextPath()%>/admin/item/itemUpdateAction.jsp?itemNo=<%=itemNo%>" method="post">
			<table>
				<tr>
					<td>no</td>
					<td><input type="text" name="itemNo" value="<%=itemNo%>" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>상품이름</td>
					<td>
						<input type="text" id="itemName" name="itemName" value="<%=itemName%>"/>
						<span id="itemNameHelper"></span>
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<input type="text" id="itemPrice" name="itemPrice" value="<%=itemPrice%>" readonly="readonly"/>
						<span id="itemPriceHelper"></span>
					</td>
				</tr>
				<tr>
					<td>할인율</td>
					<td>
						<input type="text" id="itemRate"  name="itemRate" value="<%=itemRate%>"/>
						<span id="itemRateHelper"></span>
					</td>
				</tr>
				<tr>
					<td colspan=2><input type="button" id="updateBtn" value="수정하기"/></td>
				</tr>
			</table>
		</form>
	</body>
</html>