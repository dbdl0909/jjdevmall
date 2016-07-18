<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				$('#memberId').blur(function() {	//아이디
					if(!(isNaN($('#memberId').val())) || $('#memberId').val().length<4) {
						$('#memberIdHelper').text('아이디 문자 4글자 이상 입력');
						$('#memberId').focus();
					} else {
						$('#memberIdHelper').text('');
					}
				});
				
				$('#memberPw').blur(function() {	//비번
					if($('#memberPw').val().length<4) {
						$('#memberPwHelper').text('비밀번호 4글자 이상 입력');
						$('#memberPw').focus();
					} else {
						$('#memberPwHelper').text('');
					}
				});
				
				$('#memberPw2').blur(function() {	//비번
					if($('#memberPw2').val() != $('#memberPw').val()) {
						$('#memberPw2Helper').text('비밀번호 확인바람');
						$('#memberPw2').focus();
					} else {
						$('#memberPw2Helper').text('');
					}
				});
				
				$('#memberName').blur(function() {	//이름
					if($('#memberName').val().length<2 || !isNaN($('#memberName').val())) {
						$('#memberNameHelper').text('이름 문자 2글자 이상 입력');
						$('#memberName').focus();
					} else {
						$('#memberNameHelper').text('');
					}
				});
				
				$('#memberAge').blur(function() {	//나이
					if($('#memberAge').val()=='' || isNaN($('#memberAge').val())) {
						$('#memberAgeHelper').text('나이 숫자만 입력');
						$('#memberAge').focus();
					} else {
						$('#memberAgeHelper').text('');
					}
				});
				
				$('#addressAddr').blur(function() {	//나이
					if($('#addressAddr').val()=='') {
						$('#addressAddrHelper').text('주소 입력');
						$('#addressAddr').focus();
					} else {
						$('#addressAddrHelper').text('');
					}
				});
				
				$('#addBtn').click(function() {
					if(!(isNaN($('#memberId').val())) || $('#memberId').val().length<4) {
						$('#memberIdHelper').text('아이디 문자 4글자 이상 입력');
						$('#memberId').focus();
					} else if($('#memberPw').val().length<4) {
						$('#memberPwHelper').text('비밀번호 4글자 이상 입력');
						$('#memberPw').focus();
					} else if($('#memberPw2').val() != $('#memberPw').val()) {
						$('#memberPw2Helper').text('비밀번호 확인바람');
						$('#memberPw2').focus();
					} else if($('#memberName').val().length<2 || !isNaN($('#memberName').val())) {
						$('#memberNameHelper').text('이름 문자 2글자 이상 입력');
						$('#memberName').focus();
					} else if($('.memberGender:checked').length==0) {
						$('#memberGenderHelper').text('성별 선택');
					} else if($('#memberAge').val()=='' || isNaN($('#memberAge').val())) {
						$('#memberAgeHelper').text('나이 숫자만 입력');
						$('#memberAge').focus();
					} else if($('#addressAddr').val()=='') {
						$('#addressAddrHelper').text('주소 입력');
						$('#addressAddr').focus();
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
						<input type="text" name="memberId" id="memberId"/>
						<span id="memberIdHelper"></span>
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<input type="password" name="memberPw" id="memberPw"/>
						<span id="memberPwHelper"></span>
					</td>
				</tr>
				<tr>
					<td>패스워드확인</td>
					<td>
						<input type="password" name="memberPw2" id="memberPw2"/>
						<span id="memberPw2Helper"></span>
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="memberName" id="memberName"/>
						<span id="memberNameHelper"></span>
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="memberGender" class="memberGender" value="male"/>남
						<input type="radio" name="memberGender" class="memberGender" value="female"/>여
						<span id="memberGenderHelper"></span>
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td>
						<input type="text" name="memberAge" id="memberAge"/>
						<span id="memberAgeHelper"></span>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input type="text" name="addressAddr" id="addressAddr"/>
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