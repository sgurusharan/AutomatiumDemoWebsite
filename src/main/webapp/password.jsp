<%-- 
    Document   : welcome
    Created on : 29 Jul, 2017, 10:57:09 AM
    Author     : Padmanabha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/universal_head.jsp"%>
        <title>Change Password</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/page_header.jsp"%>
        <div id="content">
            <p>
                Change Password
            </p>
            <table>
                <tr>
                    <td>Current Password</td>
                    <td>: <input type="password" id="currentPassword" name="currentPassword" /></td>
                </tr>
                <tr>
                    <td>New Password</td>
                    <td>: <input type="password" id="newPassword" name="newPassword" /></td>
                </tr>
                <tr>
                    <td>Retype New Password</td>
                    <td>: <input type="password" id="rePassword" name="rePassword" /></td>
                </tr>
            </table>
        </div>
    </body>
</html>
