<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%> 
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
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
		if (userid == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
				if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null ) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('내용 없음')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userid,bbs.getBbsContent());
					if (result == -1 ) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기 실패')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}
				}
		}
	%>
</body>
</html>
