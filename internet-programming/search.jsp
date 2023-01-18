<%@ page  contentType="text/html;charset=utf-8" 
		import="java.sql.*"  %>

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
</style>

<!-- 검색 단어 받기 -->
<%
	String search = request.getParameter("search");
%>


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
</header>

<table border="1" style="border-collapse:collapse; margin-left:150px; width:75%;">
<tr>
	<th>Title</th>
	<th>Genre</th>
	<th>Story</th>
	<th>Author</th>
	<th>Introduction</th>

</tr>
<%
    while(rs.next()) {
%><tr>
<%
if (search.equals(rs.getString("title")) || search.equals(rs.getString("author"))) {
%>
<td><a href="episode_list.jsp"><%=rs.getString("title")%></a></td>
<td><%=rs.getString("genre") %></td>
<td><%=rs.getString("story")%></td>
<td><%=rs.getString("author")%></td>
<td><%=rs.getString("introduction") %></td>
<%
}
%>

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