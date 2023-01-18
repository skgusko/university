<%@ page contentType="text/html;charset=utf-8" 
import="java.sql.*"
import="myBean.multipart.*"
import="java.util.*, java.io.*,
myBean.multipart.*" %>

<%
request.setCharacterEncoding("utf-8");		//URL 인코딩 : UTF-8. MariaDB(또는 MySQL) 인코딩 : utf8

String idx = request.getParameter("idx");

String epiNum = request.getParameter("epiNum"); //1. 입력양식 title에 입력한 값을 알아낸다.
String epiTitle = request.getParameter("epiTitle"); //2. 입력양식 genre에 입력한 값을 알아낸다.
String date = request.getParameter("date");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts, realFolder);

//String originalFileName = "";
String originalFileName = "";
String savedFileName = "";

if(multiPart.getMyPart("image") != null) {
	System.out.println("여기여기");
	//클라이언트가 전송한 원래 파일명 알아내기
	originalFileName = multiPart.getOriginalFileName("image");
	
	//서버에 저장된 파일 이름 알아내기(UUID 적용된 파일명)
	savedFileName = multiPart.getSavedFileName("image");
}

try {
	 //4. JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

	//5. 연결자 생성
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	
	//6. member 테이블에 id, name, pwd를 삽입하기 위한 쿼리 문자열 구성.
	String sql = "INSERT INTO episode(registration_idx, epiTitle, epiThumnail, epiImageFile, date) VALUES(?, ?, ?, ?, ?)";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//7. pstmt에 사용자로부터 입력받은 값들로 온전한 쿼리를 구성.
	pstmt.setInt(1, Integer.parseInt(idx));
	pstmt.setString(2, epiTitle);
	pstmt.setString(3, originalFileName);
	pstmt.setString(4, originalFileName);
	pstmt.setString(5, date);

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
response.sendRedirect("episode_list.jsp");
%>