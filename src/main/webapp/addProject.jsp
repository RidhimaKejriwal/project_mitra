<%-- 
    Document   : addProduct
    Created on : 13-Sept-2023, 11:44:30 pm
    Author     : Dell
--%>

<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Student student = (Student)session.getAttribute("current-student");
    int studentId = student.getStudentId();
    int collegeId = student.getCollegeId();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Submission</title>
        <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="stylesheet" href="css/addProject.css">
    </head>
    <body>
        <div class="navbar">
            <ul>
                <li><span class="material-symbols-outlined">rocket</span></li>
                <li>Projects</li>
            </ul>
            <ul>
                <div class="sebar">
                    <li><input type="text" placeholder="Search here"></li>
                </div>
                <li>Login</li>
                <li class="signup">Sign up</li>
            </ul>
        </div>
        <div class="bigcon">
            <div class="con1">
                <div class="scon1">
                    <div class="vdo">
                        <video autoplay muted loop id="myVideo">
                            <source src="img/Copy of robot.mp4" type="video/mp4">
                        </video>
                    </div>
                    <div class="img">
                        <img src="/Copy of Untitled Design.png" alt="error">
                    </div>
                </div>
                <div class="scon2">
                    <div class="frm">
                        <form action="addProjectServlet" method="post" enctype="multipart/form-data">
                            <input name="studentId" type="text" hidden value="<%=studentId%>">
                            <input name="collegeId" type="text" hidden value="<%=collegeId%>">
                            <div class="prjtnm">
                                <p>Project Name</p>
                                <input type="text" name="projectName" placeholder="Input project name">
                            </div>

                            <div class="btns">
                                <div class="opt">
                                    <select name="language" id="lang" class="option1">
                                        <option value="Language" disabled selected>Language</option>
                                        <option value="Python">Python</option>
                                        <option value="C/C++">C/C++</option>
                                        <option value="Java">Java</option>
                                        <option value="Web">Web</option>
                                    </select>
                                </div>
                                <div class="opt">
                                    <select name="category" id="category" class="option2">
                                        <option value="category" disabled selected>Category</option>
                                        <option value="Hardware">Hardware</option>
                                        <option value="Software">Software</option>
                                    </select>
                                </div>
                            </div>

                            <div class="bcon">
                                <p>Add Project Files</p>
                                <input name="pic" class="pic" type="file" multiple=""/>
                            </div>

                            <div class="descrpt">
                                <p>Add Project Description</p>
                                <textarea name="desc" id="" cols="85" rows="12" placeholder="Input your text here"></textarea>
                            </div>

                            <div class="ylnk">
                                <p>Youtube Video Link</p>
                                <input name="vidLink" type="text" placeholder="Link">
                            </div>

                            <div class="sbmt">
                                <p>Submit Project</p>
                                <button type="submit">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
