<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				$('#member_id').blur(function() {	//아이디
					if(!(isNaN($('#member_id').val())) || $('#member_id').val().length<4) {
						$('#memberIdHelper').text('아이디 문자 4글자 이상 입력');
						$('#member_id').focus();
					} else {
						$('#memberIdHelper').text('');
					}
				});
				
				$('#member_pw').blur(function() {	//비번
					if($('#member_pw').val().length<4) {
						$('#memberPwHelper').text('비밀번호 4글자 이상 입력');
						$('#member_pw').focus();
					} else {
						$('#memberPwHelper').text('');
					}
				});
				
				$('#member_name').blur(function() {	//이름
					if($('#member_name').val().length<2 || !isNaN($('#member_name').val())) {
						$('#memberNameHelper').text('이름 문자 2글자 이상 입력');
						$('#member_name').focus();
					} else {
						$('#memberNameHelper').text('');
					}
				});
				
				$('#member_age').blur(function() {	//나이
					if($('#member_age').val()=='' || isNaN($('#member_age').val())) {
						$('#memberAgeHelper').text('나이 숫자만 입력');
						$('#member_age').focus();
					} else {
						$('#memberAgeHelper').text('');
					}
				});
				
				$('#address_addr').blur(function() {	//나이
					if($('#address_addr').val()=='') {
						$('#addressAddrHelper').text('주소 입력');
						$('#address_addr').focus();
					} else {
						$('#addressAddrHelper').text('');
					}
				});
				
				$('#addBtn').click(function() {
					if(!(isNaN($('#member_id').val())) || $('#member_id').val().length<4) {
						$('#memberIdHelper').text('아이디 문자 4글자 이상 입력');
						$('#member_id').focus();
					} else if($('#member_pw').val().length<4) {
						$('#memberPwHelper').text('비밀번호 4글자 이상 입력');
						$('#member_pw').focus();
					} else if($('#member_name').val().length<2 || !isNaN($('#member_name').val())) {
						$('#memberNameHelper').text('이름 문자 2글자 이상 입력');
						$('#member_name').focus();
					} else if($('.member_gender:checked').length==0) {
						$('#memberGenderHelper').text('성별 선택');
					} else if($('#member_age').val()=='' || isNaN($('#member_age').val())) {
						$('#memberAgeHelper').text('나이 숫자만 입력');
						$('#member_age').focus();
					} else if($('#address_addr').val()=='') {
						$('#addressAddrHelper').text('주소 입력');
						$('#address_addr').focus();
					} else {
						$('#addForm').submit();
					}
				});
			});
		</script>
	</head>
	<body>
		<form id="addForm" action="<%=request.getContextPath()%>/member/memberAddAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="member_id" id="member_id"/>
						<span id="memberIdHelper"></span>
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<input type="password" name="member_pw" id="member_pw"/>
						<span id="memberPwHelper"></span>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="member_name" id="member_name"/>
						<span id="memberNameHelper"></span>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="member_gender" class="member_gender" value="male"/>남
						<input type="radio" name="member_gender" class="member_gender" value="female"/>여
						<span id="memberGenderHelper"></span>
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td>
						<input type="text" name="member_age" id="member_age"/>
						<span id="memberAgeHelper"></span>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input type="text" name="address_addr" id="address_addr"/>
						<span id="addressAddrHelper"></span>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input type="button" id="addBtn" value="회원가입"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>