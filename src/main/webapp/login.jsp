<%-- 
    Document   : login
    Created on : 09-Sept-2023, 1:42:30 pm
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/login.css">
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    </head>
    <body>
        <div class="wrapper">
            <form action="LoginServlet">
                <h2>Login</h2>
                <div class="input-box">
                    <label class="forgot-pass">Select Login type</label>
                    <select>
                        <option>Student</option>
                        <option>College</option>
                    </select>
                </div>
                <div class="input-box">
                    <span class="icon"><ion-icon name="mail"></ion-icon></span>
                    <input type="text" placeholder="Email" required>
                </div>
                <div class="input-box">
                    <span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
                    <input type="password" placeholder="Password" required>
                </div>
                <button type="submit">Login</button>
                <div class="register-link"><p>Don't have an account? <a href="signup.jsp">Register</a></p></div>
            </form>

        </div>
    </body>
</html>
