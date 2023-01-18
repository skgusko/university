<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
	header {
	    /*margin-top:40px;*/
	    /*margin-left:40px;*/
	    width:100%;
	    height:100px;
	    /*background: greenyellow;*/
	}
	#koTitle {
	    text-align:center;
	    padding-left:50px;
	    padding-top:10px;
	    float:left;
	    width:10%;
	    height:50px;
	}
	.search {
	    width:900px;
	    padding:8px;
	    margin-left:10px;
	    margin-top:28px;
	}
</style>
</head>
<body>
<header>
	<form action="./search.jsp">
	<div>
	    <h2 id="koTitle">KO 웹툰</h2>
	    <input type="text" class="search" name="search" placeholder="제목/작가로 검색할 수 있습니다.">
	    <button type="submit"> 검 색 </button>
    </div>
    </form>    
</header>
<% //세션이 설정되지 않을 경우
if(session.getAttribute("id") == null) {
%>
<div style="text-align:center; margin-top:50px;">
<form action="member_ok.jsp" method="post" >
	<h2>관리자 전환</h2><br>
	<label for="id">아이디</label>&nbsp;&nbsp;&nbsp;
	<input type="text" name="id" id="id" placeholder="아이디" required /><br><br>
	<label for="pass">비밀번호</label>&nbsp;&nbsp;&nbsp;
	<input type="password" name="pass" id="pass" placeholder="비밀번호" required /><br><br><br><br>
	<input type="submit" value="로그인" />
</form>
</div>
<% 
}else {
//세션이 설정되어 있는 경우
	response.sendRedirect("registration_db_list.jsp");
%>

<% } %>
</body>
</html>