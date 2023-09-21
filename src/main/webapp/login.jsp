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
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    </head>
    <body>
        <div class="navbar">
            <ul>
                <a href="/projectMitra/"><span class="material-symbols-outlined">rocket</span></a>
                <li><a href="/projectMitra/">Prarambh</a></li>
                <li><a href="explore.jsp">Explore</a></li>
            </ul>
            <ul>
                <form action="explore.jsp" method="post" role="search">
                    <div class="sebar">
                        <li><input type="search" name="ch" placeholder="Search here"></li>
                        <!--<button type="submit">Search</button>-->
                    </div>  
                </form>
                <li><a href="login.jsp">Login</a></li>
                <li class="signup"><a href="signup.jsp">Sign up</a></li>
            </ul>
        </div>
        <div class="wrapper">
            <form action="LoginServlet" method="post">
                <h2>Login</h2>
                <div class="input-box">
                    <label class="forgot-pass">Select Login type</label>
                    <select name="userType">
                        <option selected>--Select--</option>
                        <option value="student">Student</option>
                        <option value="college">College</option>
                    </select>
                </div>
                <div class="input-box">
                    <span class="icon"><ion-icon name="mail"></ion-icon></span>
                    <input name="email" type="email" placeholder="Email" required>
                </div>
                <div class="input-box">
                    <span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
                    <input name="password" type="password" placeholder="Password" required>
                </div>
                <button type="submit">Login</button>
                <div class="register-link"><p>Don't have an account? <a href="signup.jsp">Register</a></p></div>
            </form>
        </div>
    </body>
</html>
