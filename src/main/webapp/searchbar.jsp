<%-- 
    Document   : searchbar
    Created on : 18-Sept-2023, 11:22:22 pm
    Author     : Dell
--%>

<%@page import="com.learn.projectmitra.entities.College"%>
<%@page import="com.learn.projectmitra.dao.CollegeDao"%>
<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page import="com.learn.projectmitra.dao.StudentDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.projectmitra.entities.Project"%>
<%@page import="com.learn.projectmitra.helper.FactoryProvider"%>
<%@page import="com.learn.projectmitra.dao.ProjectDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="stylesheet" href="css/profile_friends.css">
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



        <div class="container1">
            <div class="container2">

                <div class="container4">

                    <div class="pcon">
                        <%
                            String ch = request.getParameter("ch");
                            ProjectDao pdao = new ProjectDao(FactoryProvider.getFactory());
                            List<Project> projects = pdao.getSearchedProjects(ch);
                        %>
                        <h1 style="color: white;">Projects..</h1>
                        <%
                            for (Project project : projects) {
                        %>
                        <!-- Card for project details -->
                        <div class="cards">
                            <div class="card1">
                                <div class="cinfo">
                                    <div class="spp">
                                        <img src="/z.PNG" alt="profile picture" class="pp">
                                    </div>
                                    <div class="pnam">
                                        <h3 class="name"><%=project.getProjectName()%></h3>
                                        <h5 class="username">harshit_2004</h5>
                                    </div>
                                </div>
                                <div class="cardicons">
                                    <ul>
                                        <li>
                                            <span class="material-symbols-outlined">menu_book</span>
                                            <h5>no of projects</h5>
                                        </li>
                                        <li>
                                            <span class="material-symbols-outlined">group</span>
                                            <h5>followers</h5>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <h1 style="color: white;">Students..</h1>
                        <%
                            StudentDao sdao = new StudentDao(FactoryProvider.getFactory());
                            List<Student> students = sdao.getSearchedStudents(ch);
                            for (Student student : students) {
                        %>
                        <!-- Card for project details -->
                        <div class="cards">
                            <div class="card1">
                                <div class="cinfo">
                                    <div class="spp">
                                        <img src="/z.PNG" alt="profile picture" class="pp">
                                    </div>
                                    <div class="pnam">
                                        <h3 class="name"><%=student.getStudentName() %></h3>
                                        <h5 class="username"><%=student.getStudentUserName() %></h5>
                                    </div>
                                </div>
                                <div class="cardicons">
                                    <ul>
                                        <li>
                                            <span class="material-symbols-outlined">menu_book</span>
                                            <h5>no of projects</h5>
                                        </li>
                                        <li>
                                            <span class="material-symbols-outlined">group</span>
                                            <h5>followers</h5>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <h1 style="color: white;">Colleges..</h1>
                        <%
                            CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());
                            List<College> colleges = cdao.getSearchedColleges(ch);
                            for (College college : colleges) {
                        %>
                        <!-- Card for project details -->
                        <div class="cards">
                            <div class="card1">
                                <div class="cinfo">
                                    <div class="spp">
                                        <img src="/z.PNG" alt="profile picture" class="pp">
                                    </div>
                                    <div class="pnam">
                                        <h3 class="name"><%=college.getCollegeName() %></h3>
                                        <h5 class="username"><%=college.getUserName() %></h5>
                                    </div>
                                </div>
                                <div class="cardicons">
                                    <ul>
                                        <li>
                                            <span class="material-symbols-outlined">menu_book</span>
                                            <h5>no of projects</h5>
                                        </li>
                                        <li>
                                            <span class="material-symbols-outlined">group</span>
                                            <h5>followers</h5>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
