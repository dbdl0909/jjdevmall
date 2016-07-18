<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				$('#item_name').blur(function() {	//상품이름
					if($('#item_name').val() == '') {
						$('#itemNameHelper').text('이름 입력');
						$('#item_name').focus();
					}
				});
				
				$('#item_price').blur(function() {	//상품이름
					if($('#item_price').val() == '' || isNaN($('#item_price').val())) {
						$('#itemPriceHelper').text('가격 입력');
						$('#item_price').focus();
					}
				});
				
				$('#item_rate').blur(function() {	//상품이름
					if($('#item_rate').val() == '' || $('#item_rate').val()>=1) {
						$('#itemRateHelper').text('할인율 입력');
						$('#item_rate').focus();
					}
				});
				
				$('#addBtn').click(function() {
					if($('#item_name').val() == '') {
						$('#itemNameHelper').text('이름 입력');
						$('#item_name').focus();
					} else if($('#item_price').val() == '' || isNaN($('#item_price').val())) {
						$('#itemPriceHelper').text('가격 입력');
						$('#item_price').focus();
					} else if($('#item_rate').val() == '' || $('#item_rate').val()>=1) {
						$('#itemRateHelper').text('할인율 입력');
						$('#item_rate').focus();
					} else {
						$('#addForm').submit();
					}
				});
			});
		</script>
	</head>
	<body>
		<form id="addForm" action="<%=request.getContextPath()%>/admin/item/itemAddAction.jsp" method="post">
			<table>
				<tr>
					<td>상품이름</td>
					<td>
						<input type="text" name="item_name" id="item_name"/>
						<span id="itemNameHelper"></span>
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<input type="text" name="item_price" id="item_price"/>
						<span id="itemPriceHelper"></span>
					</td>
				</tr>
				<tr>
					<td>할인율</td>
					<td>
						<input type="text" name="item_rate" id="item_rate"/>
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