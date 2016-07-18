<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				$('#itemName').blur(function() {	//상품이름
					if($('#itemName').val() == '') {
						$('#itemNameHelper').text('이름 입력');
						$('#itemName').focus();
					}
				});
				
				$('#itemPrice').blur(function() {	//상품이름
					if($('#itemPrice').val() == '' || isNaN($('#itemPrice').val())) {
						$('#itemPriceHelper').text('가격 입력');
						$('#itemPrice').focus();
					}
				});
				
				$('#itemRate').blur(function() {	//상품이름
					if($('#itemRate').val() == '' || $('#itemRate').val()>=1) {
						$('#itemRateHelper').text('할인율 입력');
						$('#itemRate').focus();
					}
				});
				
				$('#addBtn').click(function() {
					if($('#itemName').val() == '') {
						$('#itemNameHelper').text('이름 입력');
						$('#itemName').focus();
					} else if($('#itemPrice').val() == '' || isNaN($('#itemPrice').val())) {
						$('#itemPriceHelper').text('가격 입력');
						$('#itemPrice').focus();
					} else if($('#itemRate').val() == '' || $('#itemRate').val()>=1) {
						$('#itemRateHelper').text('할인율 입력');
						$('#itemRate').focus();
					} else {
						$('#addForm').submit();
					}
				});
			});
		</script>
	</head>
	<body>
	<h1>item 등록</h1>
		<form id="addForm" action="<%=request.getContextPath()%>/admin/item/itemAddAction.jsp" method="post">
			<table>
				<tr>
					<td>상품이름</td>
					<td>
						<input type="text" name="itemName" id="itemName"/>
						<span id="itemNameHelper"></span>
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<input type="text" name="itemPrice" id="itemPrice"/>
						<span id="itemPriceHelper"></span>
					</td>
				</tr>
				<tr>
					<td>할인율</td>
					<td>
						<input type="text" name="itemRate" id="itemRate"/>
						<span id="itemRateHelper"></span>
					</td>
				</tr>
				<tr>
					<td><input type="button" id="addBtn" value="상품등록"/></td>
				</tr>
			</table>
		</form>
	</body>
</html>