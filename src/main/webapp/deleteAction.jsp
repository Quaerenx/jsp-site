<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%> 
<%@ page import="bbs.Bbs"%> 
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
		} 
		int bbsID = 0 ;
		if ( request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));		
		}
			if (bbsID == 0 ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지않은 글')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");	
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userid.equals(bbs.getUserID()))	{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한 없음')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");	
		}

		else {
				
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.delete(bbsID);
				if (result == -1 ) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제 실패')");
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
	%>
</body>
</html>
