<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/custom.css">
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userid = null;
		if (session.getAttribute("userid") != null ) {
			userid = (String) session.getAttribute("userid");
		}
		if (userid == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 필요')");
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
	%>

    <nav class="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
                       <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle"
                        data-toggle="dropdown" role="button" aria-haspopup="true"
                        aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
				<table class="table table-striped" style="text=align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글 수정 양식</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td  style="text-align:center;"><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>"></td>
							</tr>
							<tr>
								<td  style="text-align:center;"><textarea  class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%=bbs.getBbsContent() %></textarea></td>
							</tr>
						</tbody>	
				</table>	
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
