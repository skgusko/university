<%@ page contentType="text/html;charset=utf-8" 
			import="java.util.*, myBean.multipart.*"
			import="java.sql.*, java.io.*"
			errorPage="error.jsp"
%>
<%
request.setCharacterEncoding("utf-8");

// 사용자로 부터 idx, id, name, pwd 파라미터의 값 전달 받아 각 변수에 저장하기
String idx = request.getParameter("idx");
String title = request.getParameter("title"); //1. 입력양식 id에 입력한 값을 알아낸다.
String genre = request.getParameter("genre"); //2. 입력양식 name에 입력한 값을 알아낸다.
String story = request.getParameter("story"); //3. 입력양식 pwd에 입력한 값을 알아낸다.
String author = request.getParameter("author");
String introduction = request.getParameter("introduction");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);

try {
	// JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

	//3. 연결자 생성
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	if(multiPart.getMyPart("fileName") != null) {
		// 사용자가 새로운 파일을 지정한 경우 registration 테이블에 저장된 idx 레코드의 파일명을 알아내어, 물리적 파일 삭제
		sql = "SELECT savedFileName FROM registration WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(idx));
		pstmt.executeQuery();
		rs = pstmt.executeQuery();
		rs.next();
		String oldFileName = rs.getString("savedFileName");
		
		File oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
	
		// 새로운 파일명(original file name, UUID 적용 file name)과 데이터로 registration 테이블 수정
		sql = "UPDATE registration SET title=?, genre=?, story=?, originalFileName=?, savedFileName=?, author=?, introduction=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, genre);
		pstmt.setString(3, story);
		pstmt.setString(4, multiPart.getOriginalFileName("fileName"));
		pstmt.setString(5, multiPart.getSavedFileName("fileName"));
		pstmt.setString(6, author);
		pstmt.setString(7, introduction);
		pstmt.setInt(8, Integer.parseInt(idx));
		System.out.print("there");
	}
	else {
		//fileName에 해당하는 Part 객체가 null이라면, 새로운 파일을 선택하지 않을 경우임
		sql = "UPDATE registration SET title=?, genre=?, story=?, author=?, introduction=? WHERE idx=?";
		System.out.print("here");
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, genre);
		pstmt.setString(3, story);
		pstmt.setString(4, author);
		pstmt.setString(5, introduction);
		pstmt.setInt(6, Integer.parseInt(idx));
	}

	// 쿼리 실행
	pstmt.executeUpdate();
	

	pstmt.close();
	con.close();
}catch(SQLException e) {
	out.print(e);
	return;
}
// 리스트 출력 페이지로 이동시키기
response.sendRedirect("registration_db_list.jsp");
%>