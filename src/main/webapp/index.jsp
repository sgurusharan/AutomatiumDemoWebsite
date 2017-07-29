<%-- 
    Document   : index
    Created on : 14 Apr, 2017, 10:22:11 AM
    Author     : Padmanabha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Automatium Demo</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        <script type="text/javascript">
            
            function didClickOnForgotPassword() {
                
            }
            
            function didClickOnLogin() {
                
                document.getElementById("loginButton").disabled = true;
                
                var formData = {};
                formData['formType'] = 'login';
                formData['email'] = document.getElementById('loginEmail').value;
                formData['password'] = document.getElementById('loginPassword').value;
                
                if (verifyFormData(formData)) {
                    showNotification("Login successful. Click <a href='welcome.jsp' target='_self'>here</a> if you are not redirected automatically.", true);
                    setTimeout(gotoWelcomePage, 1000);
                }
                else {
                    showNotification("Invalid login credentials", false);
                    document.getElementById("loginButton").disabled = false;
                }
                return false;
            }
            
            function didClickOnRegister() {
                var registerButton = document.getElementById('registerButton');
                registerButton.disabled = true;
                if (!didChangeRegisterEmail()) {
                    showNotification("Please enter a valid email ID", false);
                    registerButton.disabled = false;
                    return false;
                }
                if (!didChangeRegisterPasswordFields()) {
                    showNotification("Passwords do not match", false);
                    registerButton.disabled = false;
                    return false;
                }
                
                var formData = {};
                
                formData['formType'] = 'register';
                formData['email'] = document.getElementById('registerEmail').value;
                formData['password'] = document.getElementById('registerPassword').value;
                
                if (!validatePassword(formData['password'])) {
                    showNotification("Password should be atleast 8 characters long", false);
                    registerButton.disabled = false;
                    return false;
                }
                
                if (verifyFormData(formData)) {
                    showNotification("Registration successful. Click <a href='welcome.jsp' target='_self'>here</a> if you are not redirected automatically.", true);
                    setTimeout(gotoWelcomePage, 1000);
                }
                else {
                    showNotification("Email ID already taken - please try logging in", false);
                    registerButton.disabled = false;
                }
                
                return false;
            }
            
            function validatePassword(password) {
                return password.length > 7;
            }
            
            function didResetForm(form) {
                var inputElements = form.getElementsByTagName("input");
                for (var i = 0; i < inputElements.length; i++) {
                    revalidateField(inputElements[i]);
                }
                document.getElementById('notificationDiv').style.display = 'none';
            }
            
            function didChangeRegisterEmail() {
                var emailField = document.getElementById("registerEmail");
                if(validateEmail(emailField.value)) {
                    revalidateField(emailField);
                    return true;
                }
                else {
                    invalidateField(emailField);
                    return false;
                }
            }
            
            function didChangeRegisterPasswordFields() {
                var passwordField = document.getElementById("registerPassword");
                var rePasswordField = document.getElementById("registerRePassword");
                
                if (passwordField.value === rePasswordField.value) {
                    revalidateField(passwordField);
                    revalidateField(rePasswordField);
                    return true;
                }
                else {
                    invalidateField(passwordField);
                    invalidateField(rePasswordField);
                    return false;
                }
            }
            
            function verifyFormData(formData) {
                if (formData['formType'] === 'login') {
                    return verifyLoginFormData(formData);
                }
                else if (formData['formType'] === 'register') {
                    return verifyRegisterFormData(formData);
                }
            }
            
            function verifyLoginFormData(formData) {
                var email = formData['email'];
                var password = formData['password'];
                
                if (authenticate(email, password)) {
                    return true;
                }
                else {
                    return false;
                }
            }
            
            function gotoWelcomePage() {
                open("welcome.jsp", "_self");
            }
            
            function authenticate(email, password) {
                var ajaxAuthenticationResult = null; // Do authentication here.
                
                if (ajaxAuthenticationResult === "FAIL" || ajaxAuthenticationResult === null) {
                    return false;
                }
                else {
                    document.cookie = "auth=" + ajaxAuthenticationResult;
                    return true;
                }
            }
            
            function verifyRegisterFormData(formData) {
                var email = formData['email'];
                var password = formData['password'];
                
                if (register(email, password)) {
                    return true;
                }
                else {
                    return false;
                }
            }
            
            function register(email, password) {
                var dataToPost = "action=register&email=" + email + "&password=" + password;
                
                var ajaxRegistrationResult = null;
                
                $.ajax({
                    url: "UserServices",
                    type: "POST",
                    data: dataToPost,
                    async: false,
                    success: function(response) {
                        ajaxRegistrationResult = response;
                    }
                });
                alert(ajaxRegistrationResult);
                return false;
                
                if (ajaxRegistrationResult === "FAIL" || ajaxRegistrationResult === null) {
                    return false;
                }
                else {
                    document.cookie = "auth=" + ajaxRegistrationResult;
                    return true;
                }
            }
            
            function invalidateField(field) {
                field.style.borderColor = "#ff0000";
            }
            
            function revalidateField(field) {
                field.style.borderColor = "";
            }
            
            function showNotification(notificationMessage,isSuccess) {
                var notificationDiv = document.getElementById("notificationDiv");
                if (isSuccess) {
                    notificationDiv.style.backgroundColor = "#008800";
                }
                else {
                    notificationDiv.style.backgroundColor = "#dd0000";
                }
                notificationDiv.innerHTML = notificationMessage;
                notificationDiv.style.display = "block";
            }
            
            function validateEmail(email) {
                var atpos = email.indexOf("@");
                var dotpos = email.lastIndexOf(".");
                return !(atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length);
            }
            
        </script>
        <style type="text/css">
            html, body {
                height: 98%;
                background-color: #ddd;
                color: #444;
                font-size: 12px;
                font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
            }
            
            a {
                color: #000;
            }
            
            a:hover {
                color: #444;
            }
            
            tbody th {
                font-weight: normal;
                font-size: 12px;
                text-align: left;
                padding-right: 25px;
            }
            
            thead th {
                font-weight: normal;
                text-align: center;
                padding-right: 0px;
            }
            
            .middlePane {
                display: table;
                width: 100%;
                height: 100%;
            }

            .paneContent {
                display: table-cell;
                vertical-align: middle;
                text-align: center;
            }

            .outerTable {
                background-color: #eee;
                margin: auto;
                padding: 5px;
            }

            .innerTable {
                border: solid thin #000;
                padding: 5px;
                width: 100%;
                height: 100%;
            }

            .outerTable thead th {
                background-color: #000;
                color: #fff;
                font-size: 18px;
                padding-top: 10px;
                padding-bottom: 10px;
            }
            
            .innerTable thead th {
                background-color: #888;
                color: #fff;
                font-size: 16px;
                padding-top: 5px;
                padding-bottom: 5px;
            }
            
            .formbuttontable {                
                width: 100%;
                margin: auto;
                padding-top: 10px;
                border-spacing: 0px;
                border-collapse: separate;
            }
            
            .formbuttoncell {
                background-color: #fff;
            }
            
            .notecell {
                font-size: 10px;
                padding-top: 7px;
            }
            
            .notification {
                display: none;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="middlePane">
            
            <div class="paneContent">
                <table class="outerTable">
                    <thead>
                        <tr><th colspan="2">Welcome to Automatium Demo</th></tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <form name="loginForm" id="loginForm" onreset="didResetForm(this)" onsubmit="return didClickOnLogin()">
                                <table class="innerTable">
                                    <thead>
                                        <tr><th colspan="2">Login to continue</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>Email ID</th>
                                            <td><input type="email" name="loginEmail" id="loginEmail" /></td>
                                        </tr>
                                        <tr>
                                            <th>Password</th>
                                            <td><input type="password" name="loginPassword" id="loginPassword" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="notecell">
                                                <a href="javascript:void(0)" onclick="didClickOnForgotPassword()">Forgot password?</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table class="formbuttontable">
                                                    <tr>
                                                        <td class="formbuttoncell"><input type="submit" value="Login" id="loginButton" /></td>
                                                        <td class="formbuttoncell"><input type="reset" value="Clear" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                </form>
                            </td>
                            <td>
                                <form name="registerForm" id="registerForm" onreset="didResetForm(this)" onsubmit="return didClickOnRegister()">
                                <table class="innerTable">
                                    <thead>
                                        <tr><th colspan="2">Or register as a new user</th></tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>Email ID</th>
                                            <td><input type="email" name="registerEmail" id="registerEmail" onchange="didChangeRegisterEmail()" /></td>
                                        </tr>
                                        <tr>
                                            <th>Password</th>
                                            <td><input type="password" name="registerPassword" id="registerPassword" onchange="didChangeRegisterPasswordFields()" /></td>
                                        </tr>
                                        <tr>
                                            <th>Retype Password</th>
                                            <td><input type="password" name="registerRePassword" id="registerRePassword" onchange="didChangeRegisterPasswordFields()" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table class="formbuttontable">
                                                    <tr>
                                                        <td class="formbuttoncell"><input type="submit" value="Register" id="registerButton" /></td>
                                                        <td class="formbuttoncell"><input type="reset" value="Clear" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                 <div class="notification" id="notificationDiv"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
