<%@page import="db.User"%>
<%
    String token = "";
    for (Cookie cookie : request.getCookies()) {
        if (cookie.getName().equals("auth")) {
            token = cookie.getValue();
            break;
        }
    }
    User currentUser = new User(token);
    
    if (token.equals("") || !currentUser.authenticateUser()) {
%>

    <jsp:include page="WEB-INF/jspf/authfail.jsp" />

<%
        return;
    }
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
