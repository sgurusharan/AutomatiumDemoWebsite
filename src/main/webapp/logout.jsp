<%-- 
    Document   : logout
    Created on : 30 Jul, 2017, 7:57:14 AM
    Author     : Padmanabha
--%>
<%
    response.addCookie(new Cookie("auth", null));
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout Automatium Demo</title>
    </head>
    <body>
        <p>
            You have been logged out.<br />
            Please login <a href="<%= request.getContextPath().equals("") ? "/" : request.getContextPath() %>" target="_top">here</a> if you are not redirected automatically.<br />
        </p>

        <script type="text/javascript">
            setTimeout(open, 3000, "<%= request.getContextPath().equals("") ? "/" : request.getContextPath() %>", "_top");
        </script>
    </body>
</html>
