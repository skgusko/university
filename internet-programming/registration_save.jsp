<%@ page contentType="text/html;charset=utf-8" 
import="java.sql.*"
import="myBean.multipart.*"
import="java.util.*, java.io.*,
myBean.multipart.*" %>

<%
request.setCharacterEncoding("utf-8");		//URL 인코딩 : UTF-8. MariaDB(또는 MySQL) 인코딩 : utf8

String title = request.getParameter("title"); //1. 입력양식 title에 입력한 값을 알아낸다.
String genre = request.getParameter("genre"); //2. 입력양식 genre에 입력한 값을 알아낸다.
String story = request.getParameter("story"); //3. 입력양식 story에 입력한 값을 알아낸다.
String author = request.getParameter("author");
String introduction = request.getParameter("introduction");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);

//String originalFileName = "";
String originalFileName = "";
String savedFileName = "";

if(multiPart.getMyPart("image") != null) {
	//클라이언트가 전송한 원래 파일명 알아내기
	originalFileName = multiPart.getOriginalFileName("image");
	
	//서버에 저장된 파일 이름 알아내기(UUID 적용된 파일명)
	savedFileName = multiPart.getSavedFileName("image");
}

try {
	 // JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

	// 연결자 생성
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	
	// member 테이블에 삽입하기 위한 쿼리 문자열 구성.
	String sql = "INSERT INTO registration(title, genre, story, originalFileName, savedFileName, author, introduction) VALUES(?, ?, ?, ?, ?, ?, ?)";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//7. pstmt에 사용자로부터 입력받은 값들로 온전한 쿼리를 구성.
	pstmt.setString(1, title);
	pstmt.setString(2, genre);
	pstmt.setString(3, story);
	pstmt.setString(4, originalFileName);
	pstmt.setString(5, savedFileName);
	pstmt.setString(6, author);
	pstmt.setString(7, introduction);

	//8. 쿼리 실행
	pstmt.executeUpdate();

	pstmt.close();
	con.close();

}catch(ClassNotFoundException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}
//9. 리스트 출력페이지로 이동시킴
response.sendRedirect("registration_db_list.jsp");
%>