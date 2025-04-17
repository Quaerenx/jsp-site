<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%> 
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userid" />
<jsp:setProperty name="user" property="userpw" />
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userid = null;
		if(session.getAttribute("userid") != null )  {
			userid =(String) session.getAttribute("userid");
		}
		if (userid != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있음')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserid(), user.getUserpw());
		if (result == 1 ) {
			session.setAttribute("userid", user.getUserid());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if (result == 0 ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -1 ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -2 ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류 발생')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>
