<%@ page  contentType="text/html;charset=utf-8" 
		import="java.sql.*, java.io.*"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 목록</title>
<style>
	#child {
	margin-left:40px;
    }
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
	
	
	div.list {
	    display:inline-block;
	    height:300px;
	    margin-left:100px;
	    width:70%;
	}
	div.marginL {margin-left:150px;}
	img.c1 {
	    height:150px;
	    width:250px;
	}
	#myFont {font-weight:normal; font-size:medium; font-family:"맑은 고딕", serif; display:inline;}
	#boldFont {font-weight:bold; font-size:large; font-family:"맑은 고딕", serif; display:inline;}
	.click:hover {cursor:pointer;}
	p:hover {text-decoration:underline;}
	p:active {text-decoration:underline;}
	a { text-decoration: none; color: black; }    
	a:visited { text-decoration: none; }    
	a:hover { text-decoration: none; }    
	a:focus { text-decoration: none; }    
	a:hover, a:active { text-decoration: none; }
</style>
</head>
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
String idx = request.getParameter("idx");

Connection con= null;


try {
	//3. 연결자를 생성한다.
    con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	String sql = "SELECT * FROM registration WHERE idx=?";

    //4. Statement 객체를 생성한다.
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(idx));
    ResultSet rs = pstmt.executeQuery();
    rs.next();
    
    //여기 추가
    String s = "SELECT * FROM episodeList";
    PreparedStatement p = con.prepareStatement(s);
    ResultSet r = p.executeQuery();
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

<div style="display:flex;">
	<div style="display:inline-block; margin-left:200px;">
		<img src="./upload/<%=rs.getString("savedFileName")%>" width="180" height="110">
	</div>
	<div style="display:inline-block; margin-left:30px;">
		<strong><%=rs.getString("title")%></strong><br>
		
		<%=rs.getString("story")%><br>
		<%=rs.getString("introduction") %><br>
		<%=rs.getString("author")%>&nbsp;&nbsp;&nbsp;<%=rs.getString("genre") %><br><br>
		
	</div>
	
	
	
<!-- 수정부분 -->
</div>
	<div style="text-align:right; margin-right:185px;">
		<strong><a href="episode_add.jsp?idx=<%=rs.getInt("idx")%>">회차별 웹툰 등록</a></strong>
		
	</div>
<table border="1" style="border-collapse:collapse; margin-left:150px; width:75%;">
<tr>
	<th>Thumbnail</th>
	<th>Episode_title</th>
	<th>date</th>
	<th>비고</th>
</tr>

<%
    while(r.next()) {
%><tr>
<%
if(r.getString("title").equals(rs.getString("title")))
{
%>
<td><%=r.getString("epiThumnail")%></td>
<td><%=r.getString("epiTitle") %></td>
<td><%=r.getString("date")%></td>
<td>
<!-- 8. 삭제를 처리하기 위한 링크를 구성한다. 
		삭제 페이지는 delete_do.jsp인것으로 한다.-->
	<a href="episode_delete.jsp?epiNum=<%=rs.getInt("epiNum")%>">삭제</a>

<!-- 9. 수정 기능을 구현하기 위한 버튼을 만든다. 
		단, 수정페이지는 DB에 저장된 정보를 먼저 출력해주어야 할 것이다.
			수정을 위한 정보 출력 페이지는 modify.jsp인 것으로 한다 -->
	<input type="button" value="수정" onclick="location.href='episode_modify.jsp?idx=<%=rs.getInt("epiNum")%>'">
</td>

<%
	}
%>
</tr>
<%
} // end while
%></table>

<%
	r.close();

	rs.close();     // ResultSet 종료

    pstmt.close();     // Statement 종료

    con.close(); 	// Connection 종료

} catch (SQLException e) {
      out.println("err:"+e.toString());
      return;
} 
%>