<%@ page  contentType="text/html;charset=utf-8" 
		import="java.sql.*"  %>
<%-- 1. page 지시어에 JDBC 프로그래밍을 위한 필요 패키지 import 시킨다. --%>

<style>
	header {
	    /*margin-top:40px;*/
	    /*margin-left:40px;*/
	    width:100%;
	    height:100px;
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
	.uploadButton {
		background : skyblue;
		margin-left:150px; 
		padding : 10px 20px 10px 20px;
		font-size : 15px;
		border-radius : 5px;
	}
	.uploadButton:hover {cursor:pointer;}
	
</style>

<%
//2. JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con= null;
PreparedStatement pstmt = null;
//Statement stmt = null;
ResultSet rs = null;

try {
	//3. 연결자를 생성한다.
    con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	String sql = "SELECT * FROM registration";

    //4. Statement 객체를 생성한다.
    pstmt = con.prepareStatement(sql);

    rs = pstmt.executeQuery();

%>

<header>
	<form action="./search.jsp">
	<div>
	    <h2 id="koTitle">KO 웹툰</h2>
	    <input type="text" class="search" name="search" placeholder="제목/작가로 검색할 수 있습니다.">
	    <button type="submit"> 검 색 </button>
    </div>
    </form>
    <div style="text-align:right; margin-right:170px;">
    	<div style="display:inline-block; text-align:right; margin-top:30px;">
			<form method="post" action="logout.jsp">
				<input type="submit" value="로그아웃" />
			</form>
		</div>
    </div>
    

</header>
    <input type="button" value="웹툰 등록" onclick="location.href='registration.jsp'" class = "uploadButton"><br><br>


<table border="1" style="border-collapse:collapse; margin-left:150px; width:75%;">

<tr>
	<th>Number</th>
	<th>Thumbnail</th>
	<th>Title</th>
	<th>Genre</th>
	<th>Story</th>
	<th>Author</th>
	<th>Introduction</th>
	<th>비고</th>

</tr>
<%
    while(rs.next()) {
%><tr>
<td><%=rs.getInt("idx") %></td>
<td>
	<img src="./upload/<%=rs.getString("savedFileName")%>" width="100%" height="100">
</td>

<td><a href="episode_list.jsp?idx=<%=rs.getInt("idx")%>"><%=rs.getString("title")%></a></td>
<td><%=rs.getString("genre") %></td>
<td><%=rs.getString("story")%></td>
<td><%=rs.getString("author")%></td>
<td><%=rs.getString("introduction") %></td>
<td>
<!-- 8. 삭제를 처리하기 위한 링크를 구성한다. 
		삭제 페이지는 delete_do.jsp인것으로 한다.-->
<a href="registration_delete.jsp?idx=<%=rs.getInt("idx")%>">삭제</a>

<!-- 9. 수정 기능을 구현하기 위한 버튼을 만든다. 
		단, 수정페이지는 DB에 저장된 정보를 먼저 출력해주어야 할 것이다.
			수정을 위한 정보 출력 페이지는 modify.jsp인 것으로 한다 -->
<input type="button" value="수정" onclick="location.href='registration_modify.jsp?idx=<%=rs.getInt("idx")%>'">

</td>

</tr>
<%
    } // end while
%></table>

<%

	rs.close();     // ResultSet 종료

    pstmt.close();     // Statement 종료

    con.close(); 	// Connection 종료

} catch (SQLException e) {
      out.println("err:"+e.toString());
      return;
} 
%>