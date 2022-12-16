<%@ page  contentType="text/html;charset=utf-8" import="java.sql.*, java.io.*" %>
<%
//전체 만들어 보기
request.setCharacterEncoding("utf-8");		//URL 인코딩 : UTF-8. MariaDB 인코딩 : utf8

String idx = request.getParameter("idx");  //1. 사용자가 입력한 idx 정보 가져오기

try {

	 //2.jdbc 클래스 드라이버 정의
	Class.forName("org.mariadb.jdbc.Driver");
	 
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

	//3. 연결자정보 가져오기
	Connection con =  DriverManager.getConnection(DB_URL, "admin", "1234");
	
	String sql = "SELECT savedFileName FROM registration WHERE idx=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(idx));
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	// 삭제할 savedFileName 필드 값(UUID 적용된 파일명) 알아내기
	String filename = rs.getString("savedFileName");
	
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	File file = new File(realFolder + File.separator + filename);
	file.delete();
	
	
	//4. DELETE 쿼리문 구성하기
	 sql = "DELETE FROM registration WHERE idx=?";
	pstmt = con.prepareStatement(sql);
	
	//6. pstmt에  DELETE 쿼리문 구성하기
	pstmt.setInt(1, Integer.parseInt(idx));

	//7. 쿼리문 실행
	pstmt.executeUpdate();

	//8. close하기
	rs.close();
	pstmt.close();
	con.close();

}catch(ClassNotFoundException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}catch(Exception e) {
	out.print(e);
	return;
}

//9. 리스트출력 페이지로 이동시키기
response.sendRedirect("registration_db_list.jsp");
%>