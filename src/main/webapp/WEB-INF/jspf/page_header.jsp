<%@page import="services.UserServices"%>
<%@page import="db.User"%>
<%
    String token = UserServices.getUserTokenCookie(request.getCookies());
    User currentUser = new User(token);
    
    if (token.equals("") || !currentUser.authenticateUser()) {
%>

    <jsp:include page="WEB-INF/jspf/authfail.jsp" />

<%
        return;
    }

    if (request.getParameter("inframe") == null) {
%>

<div id="header">
    Welcome <%= currentUser.getEmail() %>
    <div id="header_links">
        <table>
            <tr>
                <td><a href="<%= request.getContextPath() %>/logout.jsp">Logout</a></td>
            </tr>
        </table>
    </div>
</div>

<%
    }
%>
