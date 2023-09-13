<%-- 
    Document   : signup
    Created on : 09-Sept-2023, 1:43:22 pm
    Author     : Dell
--%>

<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page import="com.learn.projectmitra.entities.College"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SignUp Page</title>
        <link rel="stylesheet" href="css/signup.css">
    </head>
    <body>
        <%
            String user = request.getParameter("user");
        %>
        <div class="main">
            <div class="navbar">
                <div class="icon">
                    <h2 class="logo">Services</h2>
                </div>
                <div class="menu">
                    <ul>
                        <li><a href="#">HOME</a></li>
                        <li><a href="#">ABOUT</a></li>
                        <li><a href="#">SERVICE</a></li>
                        <li><a href="#">DESIGN</a></li>
                        <li><a href="#">CONTACT</a></li>
                    </ul>
                </div>
                <div class="search">
                    <p class="srch">Already have an Account?</p>
                    <a href="login.jsp"><button class="btn">Login</button></a>
                </div>
            </div>
            <div class="content">
                <div class="container1">
                    <h1>Submit <span> Projects</span><br>& Build<span> Portfolio</span><br></h1>
                    <p class="par">Create awesome projects and start building your portfolio by posting it on services app.</p>
                </div>
                <%
                    if(user == null){
                %>
                <div class="form">
                    <%@include file="components/message.jsp" %>
                    <div class="input-box">
                        <h1>Register as?<h1>
                        <button class="btnn"><a href="signup.jsp?user=student">Student</a></button>
                        <button class="btnn"><a href="signup.jsp?user=college">College</a></button>
                    </div>
                <div>
                <%
                    }else if(user.equals("student")){
                        Student student = (Student)session.getAttribute("authcode");
                %>
                <div class="form">
                    <%
                        if(student == null){
                    %>
                    <form action="VerifyStudentServlet" method="post" enctype="multipart/form-data">
                        <p>Profile</p>
                        <input class="pic" type="file" name="pic" placeholder="Enter your name"><br>
                        <div class="input-box">
                            <p>Name</p>
                            <input type="text" name="name" placeholder="Enter your name"><br>
                            <p>User Name</p>
                            <input type="text" name="userName" placeholder="Enter your userName"><br>
                            <p>Email</p>
                            <input type="email" name="email" placeholder="Enter your Email"><br>
                            <p>College Name</p>
                            <select name="collegeId">
                                <option value="collegeId">College Name</option>
                            </select><br>
                            <p>Profession</p>
                            <input type="text" name="profession" placeholder="Enter Password"><br>
                            <p>Address</p>
                            <input type="text" name="address" placeholder="Enter your Address"><br>
                            <p>Promotional Link</p>
                            <input type="text" name="link" placeholder="Enter promotional link if any"><br>
                            <p>Password</p>
                            <input type="password" name="password" placeholder="Enter your Password"><br>
                            <p>Confirm Password</p>
                            <input type="password" name="cpassword" placeholder="Confirm Password"><br>
                            <button class="btnn" style="margin-bottom: 10px;" type="submit">Sign up</button>
                        </div>
                    </form>
                    <%
                        }else if(student.getVerifyCode() !=null){
                    %>
                    <h3 class="text-center my-3">We have sent a verification code to your email!</h3>
                    <form action="VerifyCode" method="post">
                        <div class="input-box">
                            <label for="code">Enter Code</label>
                            <input type="text" hidden name="user" value="college">
                            <input required name="authcode" type="text" class="form-control" id="code" aria-describedby="emailHelp">
                            <button type="submit" value="verify" class="btnn">Verify</button>
                        </div>
                    </form>
                    <%
                        }
                    %>
                </div>
                <%
                    }else if(user.equals("college")){
                        College college = (College)session.getAttribute("authcode");
                %>
                <div class="form">
                    <%
                        if(college == null){
                    %>
                    <form action="VerifyCollegeServlet" method="post" enctype="multipart/form-data">
                        <p>Profile</p>
                        <input class="pic" type="file" name="pic" placeholder="Enter your name"><br>
                        <div class="input-box">
                            <p>College Name</p>
                            <input type="text" name="name" placeholder="Enter your College name"><br>
                            <p>User Name</p>
                            <input type="text" name="userName" placeholder="Enter user name"><br>
                            <p>Email</p>
                            <input type="email" name="email" placeholder="Enter Email"><br>
                            <p>Address</p>
                            <input type="text" name="address" placeholder="Enter your Address"><br>
                            <p>Promotional Link</p>
                            <input type="text" name="link" placeholder="Enter promotional link if any"><br>
                            <p>Password</p>
                            <input type="password" name="password" placeholder="Enter Password"><br>
                            <p>Confirm Password</p>
                            <input type="password" name="cpassword" placeholder="Confirm Password"><br>
                            <button class="btnn" style="margin-bottom: 10px;" type="submit">Sign up</button>
                        </div>
                    </form>
                    <%
                        }else if(college.getVerifyCode() !=null){
                    %>
                    <h3 class="text-center my-3">We have sent a verification code to your email!</h3>
                    <form action="VerifyCode" method="post">
                        <div class="input-box">
                            <label for="code">Enter Code</label>
                            <input type="text" hidden name="user" value="college">
                            <input required name="authcode" type="text" class="form-control" id="code" aria-describedby="emailHelp">
                            <button type="submit" value="verify" class="btnn">Verify</button>
                        </div>
                    </form>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
