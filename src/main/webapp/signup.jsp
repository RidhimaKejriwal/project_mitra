<%-- 
    Document   : signup
    Created on : 09-Sept-2023, 1:43:22 pm
    Author     : Dell
--%>

<%@page import="java.util.List"%>
<%@page import="com.learn.projectmitra.helper.FactoryProvider"%>
<%@page import="com.learn.projectmitra.dao.CollegeDao"%>
<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page import="com.learn.projectmitra.entities.College"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SignUp Page</title>
        <link rel="stylesheet" href="css/prereg.css">
        <link rel="stylesheet" href="css/cregister.css">
        <link rel="stylesheet" href="css/sregister.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    </head>
    <body>
        <%
            String user = request.getParameter("user");
        %>
        <!-- NavBar -->
        <div class="navbar">
            <ul>
                <li><a href="/projectMitra/" style="text-decoration: none; color: white;"><span class="material-symbols-outlined">rocket</span></a></li>
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
        <div class="container1">
            <div class="container2">
                <div class="vdo">
                    <video autoplay muted loop id="myVideo">
                        <source src="img/Copy of robot.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="subcontainer">
                    <h1>Create <span class="span1">account</span><br>& start submitting <span class="span2">Projects</span><br></h1>
                </div>
            </div>
            <%
                if(user == null){
            %>
            <div class="container3">
                <%@include file="components/message.jsp" %>
                <div class="subc1">
                    <h2>Register As</h2>
                    <div class="opts">
                        <a href="signup.jsp?user=student">Student</a>
                        <a href="signup.jsp?user=college">College</a>
                    </div>
                </div>
            <div>
            <%
                }else if(user.equals("student")){
                    Student student = (Student)session.getAttribute("authcode");
                    CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());
                    List<College> colleges = cdao.getallCollege();
            %>
            <div class="container3">
                <%
                    if(student == null){
                %>
                <div class="sfrm">
                    <h2>Register here</h2>
                    <div>
                        <form action="VerifyStudentServlet" method="post" enctype="multipart/form-data">
                            <p>Profile</p>
                            <input class="pic" type="file" name="pic" placeholder="Enter your name"><br>
                            <div class="sinput-box">
                                <p>Name</p>
                                <input type="text" name="name" placeholder="Enter your name"><br>
                                <p>User Name</p>
                                <input type="text" name="userName" placeholder="Enter your userName"><br>
                                <p>Email</p>
                                <input type="email" name="email" placeholder="Enter your Email"><br>
                                <p>College</p>
                                <div class="dd">
                                    <select name="collegeId">
                                        <option disabled selected>College Name</option>
                                        <%
                                            for(College col : colleges){
                                        %>
                                        <option value="<%= col.getCollegeId() %>"><%= col.getCollegeName() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <p>Studying year</p>
                                <div class="dd">
                                    <select name="year">
                                        <option disabled selected>Studying Year</option>
                                        <option value="1st">First(1st)</option>
                                        <option value="2nd">Second(2nd)</option>
                                        <option value="3rd">Third(3rd)</option>
                                        <option value="4th">Fourth(4th)</option>
                                    </select>
                                </div>
                                <p>Branch</p>
                                <div class="dd">
                                    <select name="branch">
                                        <option disabled selected>Branch</option>
                                        <option value="Artificial Intelligence and Machine Learning">Artificial Intelligence and Machine Learning</option>
                                        <option value="Artificial Intelligence and Data Science">Artificial Intelligence and Data Science</option>
                                        <option value="Cyber Security">Cyber Security</option>
                                        <option value="Computer Science Enginnering">Computer Science Enginnering</option>
                                        <option value="Electrical Enginnering">Electrical Enginnering</option>
                                        <option value="Mechanical Enginnering">Mechanical Enginnering</option>
                                        <option value="Information Technology">Information Technology</option>
                                    </select>
                                </div>
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
                                <button class="sbtnn" style="margin-bottom: 10px;" type="submit">Sign up</button>
                            </div>
                        </form>
                    </div>
                </div>
                <%
                    }else if(student.getVerifyCode() !=null){
                %>
                <div class="">
                    <h2 class="text-center my-3" style="color: white;">We have sent a verification code to your email!</h2>
                    <form action="VerifyCode" method="post">
                        <div class="sinput-box">
                            <label for="code">Enter Code</label>
                            <input type="text" hidden name="user" value="student">
                            <input required name="authcode" type="text" class="form-control" id="code" aria-describedby="emailHelp">
                            <button type="submit" value="verify" class="sbtnn">Verify</button>
                        </div>
                    </form>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }else if(user.equals("college")){
                    College college = (College)session.getAttribute("authcode");
            %>
            <div class="container3">
                <%
                    if(college == null){
                %>
                <div class="cfrm">
                    <h2>Register Here</h2>
                    <div>
                        <form action="VerifyCollegeServlet" method="post" enctype="multipart/form-data">
                            <p>Profile</p>
                            <input class="pic" type="file" name="pic" placeholder="Enter your name"><br>
                            <div class="cinput-box">
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
                                <button class="cbtnn" style="margin-bottom: 10px;" type="submit">Sign up</button>
                            </div>
                        </form>
                    </div>
                </div>
                <%
                    }else if(college.getVerifyCode() !=null){
                %>
                <div class="">
                    <h2 class="text-center my-3" style="color: white;">We have sent a verification code to your email!</h2>
                    <form action="VerifyCode" method="post">
                        <div class="cinput-box">
                            <label for="code">Enter Code</label>
                            <input type="text" hidden name="user" value="college">
                            <input required name="authcode" type="text" class="form-control" id="code" aria-describedby="emailHelp">
                            <button type="submit" value="verify" class="cbtnn">Verify</button>
                        </div>
                    </form>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>
