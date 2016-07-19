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
				$('#ordersQuantity').change(function() {
					console.log($('#ordersQuantity').val());
					console.log($('#discount').text());
					
					$('#totalPrice').text(($('#ordersQuantity').val())*($('#discount').text()));
				});
				
				$('#ordersBtn').click(function() {
					if($('#ordersQuantity').val() == '') {
						$('#ordersQuantityHelper').text('수량 선택');
					} else {
						$('#ordersForm').submit();
					}
				});
			});
		</script>
	</head>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		Integer sessionMemberNo = (Integer)session.getAttribute("sessionMemberNo");
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
		
		System.out.println(sessionMemberNo + " : sessionMemberNo index.jsp");
		System.out.println(sessionMemberId + " : sessionMemberId index.jsp");
		
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		System.out.println(itemNo + " : itemNo ordersAddForm.jsp");
		
		if(sessionMemberId == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		} else {
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
				System.out.println(connection + " : connection ordersAddForm.jsp");
				
				String sql = "SELECT item_no, item_name, item_price, item_rate FROM item WHERE item_No=?";
				statement = connection.prepareStatement(sql);
				statement.setInt(1, itemNo);
				System.out.println(statement + " : statement ordersAddForm.jsp");
				
				resultSet = statement.executeQuery();
				System.out.println(resultSet + " : resultSet itemListAll.jsp");
			
				int itemPrice = 0;
				double itemRate = 0;
				if(resultSet.next()) {
					itemPrice = resultSet.getInt("item_price");
					itemRate = resultSet.getDouble("item_rate");
					System.out.println(itemPrice + " : itemPrice itemListAll.jsp");
					System.out.println(itemRate + " : itemRate itemListAll.jsp");
				}
				
				int discount = (int)Math.round(itemPrice*(1-itemRate));
				System.out.println(discount + " : discount itemListAll.jsp");
				
	%>
			<form id="ordersForm" action="<%=request.getContextPath()%>/orders/ordersAddAction.jsp?itemRate=<%=itemRate%>" method="post">
				<div>
					itemNo : 
					<input type="text" name="itemNo" value="<%=itemNo%>" readonly="readonly"/>
				</div>
				<div>
					itemPrice :
					<span id="itemPriceCss"><%=itemPrice%></span>&nbsp;
					<span id="discount"><%=discount%></span>&nbsp;
					(할인율:<span><%=itemRate%></span>)
				</div>
				<div>
					ordersQuantity :
					<select id="ordersQuantity" name="ordersQuantity">
						<option value="">::수량선택::</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
					<span id="ordersQuantityHelper"></span>
				</div>
				<div>
					total :<span id="totalPrice"></span>
				</div>
				<div>
					<input type="button" id="ordersBtn" value="주문하기"/>
				</div>
			</form>
	<%
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
	</body>
</html>