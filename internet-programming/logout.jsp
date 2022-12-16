<%@ page contentType="text/html; charset=UTF-8" %>
<%
session.invalidate(); //세션 비우기
%>
<script>
alert("로그아웃되었습니다.");
location.href="login.jsp";
</script>