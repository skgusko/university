<%@ page  contentType="text/html;charset=utf-8" 
		import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 목록</title>
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
	
	div.list {
	    display:inline-block;
	    height:300px;
	    width:25%;
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
    <div style="text-align:right; margin-right:30px;">
    	<strong><a href="login.jsp">페이지 관리</a></strong>
    </div>
    
</header>


<table border="1" style="border-collapse:collapse; margin-left:5px; width:75%;">
<%
    while(rs.next()) {
%>
<div class="list">
<ul style="list-style:none;">
	<li>
	<img src="./upload/<%=rs.getString("savedFileName")%>" width="70" height="100" class="c1">
		<dl>
			<dd><a href="episode_list.jsp?idx=<%=rs.getInt("idx")%>"><%=rs.getString("title")%></a></dd>			
			<dd><%=rs.getString("genre") %></dd>
			<dd><%=rs.getString("author")%></dd>
		</dl>
	</li>
</ul>
</div>

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