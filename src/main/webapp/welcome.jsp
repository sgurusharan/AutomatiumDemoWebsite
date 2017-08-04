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
        <title>Welcome to Automatium Demo Site</title>
        <script type="text/javascript">
            function showChangePassword() {
                open('resetPassword.jsp?inframe=1', 'targetFrame');
            }
        </script>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/page_header.jsp"%>
        <div id="content">
            <p>
                This page contains links and frames.
            </p>
            <table width="100%">
                <tr>
                    <td style="border: solid #000 thin">
                        <ul>
                            <li style="cursor: pointer; text-decoration: underline;" onclick="showChangePassword();">Change Password</li>
                            <li style="cursor: pointer; text-decoration: underline;" onclick="showGetAutomatium();">Get Automatium</li>
                            <li style="cursor: pointer; text-decoration: underline;" onclick="showAutomatiumHelp();">Automatium Help</li>
                        </ul>
                    </td>
                    <td style="border: solid #000 thin">
                        <iframe id="targetFrame" style="width:100%; height: 100%; border: none;"></iframe>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>
