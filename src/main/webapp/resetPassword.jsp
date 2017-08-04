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
            function showNotification(notification, isError) {
                var notificationDiv = document.getElementById('notificationDiv');
                notificationDiv.innerHTML = notification;
                notificationDiv.style.backgroundColor = (isError ? '#dd0000' : '#008800');
            }
            
            function validateNewPasswords() {
                var newPassword = $('#newPassword').value();
                var retypePassword = $('#retypePassword').value();
                
                if (newPassword !== retypePassword) {
                    showNotification('New passwords do not match', true);
                    return false;
                }
                
                if (newPassword.length < 8) {
                    showNotification('Password should be atleast 8 characters long', true);
                }
            }
            
            function changePassword() {
                if (!validateNewPasswords()) {
                    return false;
                }
                
                $('#changePassword').disable();
                var oldPassword = $('#oldPassword').value();
                var newPassword = $('#newPassword').value();
                var dataToPost="action=changepassword&password=" + oldPassword + "&newPassword=" + newPassword;
                $.ajax({
                    url: "UserServices",
                    type: "POST",
                    data: dataToPost,
                    success: function(response) {
                        if (response.indexOf('success') >= 0) {
                            showNotification('Password changed successfully', false);
                        }
                        else if (response.indexOf('current') >= 0) {
                            showNotification('Invalid current password', true);
                        }
                        else if (response.indexOf('new') >= 0) {
                            showNotification('Invalid new password', true);
                        }
                        else if (response.indexOf('authentication') >= 0) {
                            showNotification('Unable to authenticate user - please relogin', true);
                        }
                        else {
                            showNotification('Unable to change password - please try later', true);
                        }
                    },
                    error: function() {
                        showNotification('Unable to change password - please try later', true);
                    },
                    complete: function() {
                        $('#changePassword').enable();
                    }
                });
                
                return false;
            }
        </script>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/page_header.jsp"%>
        <div id="content">
            <p>
                Reset your password here
            </p>
            <form onsubmit="return changePassword()" action="#" />
                <table style="width: 200px; border: thin solid #000">
                    <tr>
                        <td>Current Password</td>
                        <td>: <input type="password" name="currentPassword" id="currentPassword" /></td>
                    </tr>
                    <tr>
                        <td>New Password</td>
                        <td>: <input type="password" name="newPassword" id="newPassword" /></td>
                    </tr>
                    <tr>
                        <td>Retype Password</td>
                        <td>: <input type="password" name="retypePassword" id="retypeNewPassword" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>&nbsp;&nbsp;<input type="submit" name="changePassword" id="changePassword" value="Change Password" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><div id="notificationDiv" style="text-align: center; color: #fff;"></div></td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>
