<%@ page contentType="text/html;charset=utf-8" import="java.sql.*"
	errorPage="error.jsp"%>
<%
//1.사용자가 전달한 idx값 알아내기
String idx = request.getParameter("idx");

try {
	//2. JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

	//3. 연결자 생성
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");

	//4. member 테이블에서 idx에 해당하는 레코드 검색하기위한 쿼리 문자열 구성
	String sql = "SELECT title, genre, story, originalFileName, savedFileName, author, introduction FROM registration WHERE idx=?";

	PreparedStatement pstmt = con.prepareStatement(sql);

	//5. pstmt에 SELECT문의 WHERE절 이하를 구성하기 위한 메소드 설정.
	pstmt.setInt(1, Integer.parseInt(idx));

	//6. 쿼리 실행
	ResultSet rs = pstmt.executeQuery();

	//7. 레코드 커서 이동시키기
	rs.next();

	//8. 레코드에 저장된 id, name, pwd 값을 알아내어 각 변수에 저장하기
	String title = rs.getString("title");
	String genre = rs.getString("genre");
	String story = rs.getString("story");
	String author = rs.getString("author");
	String introduction = rs.getString("introduction");
	System.out.print("check" + rs.getString("originalFileName"));

	//DB관련 객체 close시키기
	rs.close();
	pstmt.close();
	con.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록된 웹툰 수정</title>
<style>
header {
	/*margin-top:40px;*/
	/*margin-left:40px;*/
	width: 100%;
	height: 100px;
	/*background: greenyellow;*/
}

#koTitle {
	text-align: center;
	padding-left: 50px;
	padding-top: 10px;
	float: left;
	width: 10%;
	height: 50px;
}

.search {
	width: 900px;
	padding: 8px;
	margin-left: 10px;
	margin-top: 28px;
}

h3 {
	font-weight: bold;
	margin-left: 100px;
}

.alignL {
	text-align: left;
}

.alignR {
	text-align: center;
}

table { /*background:pink;*/
	border-collapse: seperate;
	border-spacing: 30px;
	margin: 0 auto;
	margin-top: 15px;
	width: 1000px;
}

button {
	background-color: rgba(255, 247, 129, 0.945);
	color: black;
	font-size: 18px;
	padding: 10px 30px;
	border-radius: 25px;
	border: 0;
	outline: 0;
}

div.margin { /*background:yellow;*/
	margin: 0 auto;
	align: center;
}
</style>
<script>
	/*
	 function deleteEvent() {
	 if(confirm("정말 삭제하시겠습니까?") == true) {
	 document.form.submit();
	 }
	 else {
	 return false;
	 }
	 }
	 */
</script>
</head>

<body>
	<header>
		<div>
			<h2 id="koTitle">KO 웹툰</h2>
			<input type="text" name="search" class="search"
				placeholder="제목/작가로 검색할 수 있습니다.">
		</div>
	</header>

	<form action="registration_modify_do.jsp" method="post"
		enctype="multipart/form-data">
		<div class="margin">
			<h3>웹툰 등록</h3>
			<table class="myTable">
				<tr>
					<th class="alignL">No.</th>
					<td><input type="text" name="idx" readOnly value="<%=idx%>">
					</td>
				</tr>
				<tr>
					<th class="alignL">작품 타이틀</th>
					<td><input type="text" name="title" size="103" maxlength="30"
						placeholder="제목을 입력해주세요 (30자 이내)" onfocus="this.placeholder=''"
						onblur="this.placeholder='제목을 입력해주세요 (30자 이내)'"
						style="padding: 5px;" value="<%=title%>"></td>
				</tr>
				<tr>
					<!-- 장르는 어떻게해야지? String으로 입력도 받고 체크도 되어야 할듯 -->
					<th class="alignL">장르</th>
					<td><input type="radio" name="genre" id="일상" value="일상">
						<label for="일상">일상</label> <input type="radio" name="genre"
						id="개그" value="개그"> <label for="개그">개그</label> <input
						type="radio" name="genre" id="판타지" value="판타지"> <label
						for="판타지">판타지</label> <input type="radio" name="genre" id="액션"
						value="액션"> <label for="액션">액션</label> <input type="radio"
						name="genre" id="무협/사극" value="무협/사극"> <label for="무협/사극">무협/사극</label>
						<input type="radio" name="genre" id="드라마" value="드라마"> <label
						for="드라마">드라마</label> <input type="radio" name="genre" id="순정"
						value="순정"> <label for="순정">순정</label> <input type="radio"
						name="genre" id="감성" value="감성"> <label for="감성">감성</label>
						<input type="radio" name="genre" id="스릴러" value="스릴러"> <label
						for="스릴러">스릴러</label> <input type="radio" name="genre" id="스포츠"
						value="스포츠"> <label for="스포츠">스포츠</label></td>
				</tr>
				<tr>
					<th class="alignL">줄거리</th>
					<td><textarea cols="106" rows="4" name="story"><%=story%></textarea>
					</td>
				</tr>
				<tr>
					<th class="alignL">대표 이미지</th>
					<td><%=rs.getString("originalFileName")%> <img
						src="./upload/<%=rs.getString("savedFileName")%>" width="100"
						height="100"> <input type="file" name="fileName"></td>
				</tr>
				<tr>
					<th class="alignL">작가명</th>
					<td><input type="text" name="author" size="102" maxlength="10"
						style="padding: 5px;" value="<%=author%>"></td>
				</tr>
				<tr>
					<th class="alignL">작가의 말(소개)</th>
					<td><textarea cols="105" rows="3" name="introduction"><%=introduction%></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="alignR">
						<!-- <input type="reset" onclick='return deleteEvent();'>&nbsp;&nbsp;취소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
						<input type="submit" value="  수 정  ">&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</div>
	</form>

</body>
</html>
<%
} catch (SQLException e) {
out.print(e);
return;
}
%>