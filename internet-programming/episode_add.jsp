<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 등록 화면</title>
<style>
	header {
	    /*margin-top:40px;*/
	    /*margin-left:40px;*/
	    width:100%;
	    height:100px;
	    /*background: greenyellow;*/
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
	    -webkit-transition:width .35s ease-in-out;
	    transition:width .35s ease-in-out;
	    padding:8px;
	    margin-left:10px;
	    margin-top:28px;
	}

   h3 {font-weight:bold; margin-left:100px;}
   .alignL {text-align:left;}
   #alignR {text-align:center;}
   table {border-collapse:seperate; border-spacing:30px; margin-left:100px; margin-top:15px; width:1000px;}
   .button {background-color:rgba(255, 247, 129, 0.945); color:black; font-size:18px; padding:10px 30px; border-radius:25px; border:0; outline:0;}
   div.margin {margin:0 auto; align:center; margin-left:50px;}
</style>

<script>
function deleteEvent() {
	if(confirm("정말 삭제하시겠습니까?") == true) {
		document.form.submit();
	}
	else {
		return false;
	}
}
/*
function blankAlert(obj) {
	//아이디 입력 안 된 경우(length가 0) 입력하도록
	if(obj.value.length == 0) {
		alert("모든 항목을 입력하셔야 합니다.");
		obj.focus();
		return false; //밑에 내용 실행 안 되도록
	}
}


function showUserData() {
	var str = "";
	var obj = document.getElementsByName("epieNum");
	str += "회차 No. : " + obj[0].value + "\n";
	
	obj = document.getElementsByName("epiTitle");
	str += "회차 제목 : " + obj[0].value + "\n";
	
	obj = document.getElementsByName("epiImage");
	str += "회별 썸네일 : " + obj[0].value + "\n";
	
	obj = document.getElementsByName("storyImage");
	str += "웹툰 그림 파일 : " + obj[0].value + "\n";
	
	obj = document.getElementsByName("author");
	str += "작가명 : " + obj[0].value + "\n";
	
	obj = document.getElementById("myDate");
	str += "등록일 : " + obj.value + "\n";
	
	alert(str);
	
	return false;
	*/
}
</script>

</head>

<body>
<header>
	<div>
	    <h2 id="koTitle">KO 웹툰</h2>
	    <input type="text" name="search" class="search" placeholder="제목/작가로 검색할 수 있습니다.">
    </div>
</header>

<form action="episode_save.jsp" method="post" enctype="multipart/form-data" onsubmit="return showUserData()">
	<div class="margin">
	   <h3>회차별 웹툰 등록</h3>
	   <table class="myTable">
	      <tr>
	         <th class="alignL">회차 No.</th>
	         <td>
	            <input type="text" name="epiNum" placeholder="회차 No." onfocus="this.placeholder=''" onblur="this.placeholder='회차 No.'" style="padding:5px;">
	         </td>
	      </tr>
	      <tr>
	         <th class="alignL">회차 제목</th>
	         <td>
	            <input type="text" name="epiTitle" size="97" maxlength="30" placeholder="회차 제목을 입력해주세요 (30자 이내)" onfocus="this.placeholder=''" onblur="this.placeholder='회차 제목을 입력해주세요 (30자 이내)'" style="padding:5px;">
	         </td>
	      </tr>
	      <tr>
	         <th class="alignL">회별 썸네일</th>
	         <td>
	            <input type="file" accept="image/jpg, image/gif, image/png" name="epiThumnail">
	         </td>
	      </tr>
	      <tr>
	      <tr>
	         <th class="alignL">웹툰 그림 파일</th>
	         <td>
	            <input type="file" accept="image/jpg, image/gif, image/png" name="epiImageFile">
	         </td>
	      </tr>
	      <tr>
	         <th class="alignL">작가명</th>
	         <td>
	            <input type="text" name="author" size="97" maxlength="10" style="padding:5px;">
	         </td>
	      </tr>
	      <tr>
	         <th class="alignL">등록일</th>
	         <td>
	            <input type="date" id="myDate" name="myDate">
	         </td>
	      </tr>
	      <tr>
	         <td colspan="2" id="alignR">
	            <input type="reset" value="  취  소  " class="button" onclick='return deleteEvent();'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            <input type="submit" value="  저  장  " class="button">&nbsp;&nbsp;&nbsp;&nbsp;
	         </td>
	      </tr>
	   </table>
	</div>
</form>

</body>
</html>