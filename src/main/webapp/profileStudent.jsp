<%-- 
    Document   : profile
    Created on : 13-Sept-2023, 8:32:00 pm
    Author     : Dell
--%>
<%@page import="com.learn.projectmitra.entities.Project"%>
<%@page import="com.learn.projectmitra.dao.ProjectDao"%>
<%@page import="com.learn.projectmitra.dao.StudentDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.projectmitra.entities.Follow"%>
<%@page import="com.learn.projectmitra.dao.FollowDao"%>
<%@page import="com.learn.projectmitra.entities.College"%>
<%@page import="com.learn.projectmitra.helper.FactoryProvider"%>
<%@page import="com.learn.projectmitra.dao.CollegeDao"%>
<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Student student = (Student) session.getAttribute("current-student");
    if (student == null) {
        session.setAttribute("error_message", "You are not logged in!! Login first..");
        response.sendRedirect("login.jsp");
        return;
    }
    CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());
    System.out.println(student.getCollegeId());
    College college = cdao.getCollegeById(student.getCollegeId());
    String op = request.getParameter("op");
    FollowDao fdao = new FollowDao(FactoryProvider.getFactory());
    List<Follow> followersList = fdao.getallFollowers(student.getStudentUserName());
    List<Follow> followingList = fdao.getallFollowing(student.getStudentUserName());
    StudentDao sdao = new StudentDao(FactoryProvider.getFactory());
    
    String cat = request.getParameter("cat");
    String lang = request.getParameter("lang");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer">
        <link rel="stylesheet" href="css/profile_friends.css">
        <link rel="stylesheet" href="css/profile.css">
        <script src="js/script.js"></script>
    </head>
    <% if(op == null || op.equals("projects")){
    %>
    <body onload="makeActive('projects')">
    <%
        }else if(op.equals("followers")){
    %>
    <body onload="makeActive('followers')">
    <%
    }else if(op.equals("following")){
    %>
    <body onload="makeActive('following')">
    <%
    }
    %>
    
        <div class="navbar">
            <ul>
                <li><span class="material-symbols-outlined">rocket</span></li>
                <li>Projects</li>
            </ul>
            <ul>
                <form action="explore.jsp" method="post" role="search">
                    <div class="sebar">
                        <li><input type="search" name="ch" placeholder="Search here"></li>
                        <!--<button type="submit">Search</button>-->
                    </div>  
                </form>
                <li><a style="text-decoration: none; color: white" href="LogoutServlet">Logout</a></li>
                <li class="signup"><%=student.getStudentName()%></li>
            </ul>
        </div>

        <div class="container1">
            <div class="container2">
                <div class="container3">
                    <div class="pp">
                        <% String pic = student.getStudentUserName() + "_" + student.getStudentImage();%>
                        <img src="profileCollege/<%= pic%>" alt="profile picture">
                    </div>
                    <div class="pinfo">
                        <h1 class="name"><%= student.getStudentName()%></h1>
                        <h3 class="username"><%= student.getStudentUserName()%></h3>
                        <h4 class="clgname"><%= college.getCollegeName()%></h4>
                        <h5 class="profession">|<%= student.getProfession()%>|</h5>
                        <h5 style="margin-top: 2vh;"><%= student.getBranch() %></h5>
                        <h5 class=""><%= student.getYear() %> Year</h5>
                        <div class="folfol">
                            <span class="material-symbols-outlined">groups</span>
                            <h5><span>&#8226;<%=student.getFollowers()%> </span>followers</h5>
                            <h5><span>&#8226;<%= student.getFollowing()%> </span>following</h5>
                        </div>
                        <div class="adrs">
                            <span class="material-symbols-outlined">location_on</span>
                            <h4 class="address"><%= student.getAddress()%></h4>
                        </div>
                        <div class="social">
                            <span class="material-symbols-outlined">link</span>
                            <a href="<%= student.getWeblink()%>" class="sociallink"><%= student.getWeblink()%></a>
                        </div>
                    </div>
                </div>
                <div class="container4">
                    <div class="cnav">
                        <div class="cnavs1">
                            <ul>
                                <a href="profileStudent.jsp?op=projects">
                                    <li id='projects'>
                                        <span class="material-symbols-outlined">library_books</span>
                                        Projects
                                    </li>
                                </a>
                                <a href="profileStudent.jsp?op=followers" >
                                    <li id='followers'>
                                        <span class="material-symbols-outlined">group</span>
                                        Followers
                                    </li>
                                </a>
                                <a href="profileStudent.jsp?op=following" >
                                    <li id='following'>
                                        <span class="material-symbols-outlined">group</span>
                                        Following
                                    </li>
                                </a>
                            </ul>
                        </div>
                        <div class="cnavs2">
                            <ul>
                                <a href="addProject.jsp">
                                    <li>
                                        <span class="material-symbols-outlined">post_add</span>
                                        Add Project
                                    </li>
                                </a>
                            </ul>
                        </div>
                    </div>
                    <div class="pcon">
                        <%
                            if (op == null || op.equals("projects")) {
                            ProjectDao pdao = new ProjectDao(FactoryProvider.getFactory());
                            List<Project> projects = null;
                            if(cat == null && lang == null )
                            {
                                projects = pdao.getProjectsByStudentId(student.getStudentId());
                            }else if(cat != null)
                            {
                                projects = pdao.getProjectsByCategory(student.getStudentId(), cat);
                            }else if(lang != null)
                            {
                                projects = pdao.getProjectsByStudentId_Language(student.getStudentId(), lang);
                            }
                            
                        %>
                        <div class="menu-bar" onload="makeActive('projects')">
                            <div class="opt">
                                <select name="Language" id="lang" class="option1" onchange="location = this.value;">
                                    <option value="Language" disabled selected>Language</option>
                                    <option value="profileStudent.jsp?lang=Python">Python</option>
                                    <option value="profileStudent.jsp?lang=C/C++">C/C++</option>
                                    <option value="profileStudent.jsp?lang=Java">Java</option>
                                    <option value="profileStudent.jsp?lang=Web">Web</option>
                                </select>
                            </div>
                            <div class="opt">
                                <select name="category" id="category" class="option2" onchange="location = this.value;">
                                    <option value="category" disabled selected>Category</option>
                                    <option value="profileStudent.jsp?cat=Hardware">Hardware</option>
                                    <option value="profileStudent.jsp?cat=Software">Software</option>
                                </select>
                            </div>
                        </div>
                        <%
                            for(Project project : projects){
                        %>
                            <!-- Card for project details -->
                                <div class="cards">
                                    <div class="card1">
                                        <div class="cinfo">
                                            <h3><a style="text-decoration: none; color: #2f81f7" href="projectDisplay.jsp?id=<%=project.getProjectId() %>"><%=project.getProjectName() %></a></h3>
                                            <h4><%=project.getProjectDescription() %></h4>
                                        </div>
                                        <div class="cardicons">
                                            <ul>
                                                <li>
                                                    <span class="material-symbols-outlined">language</span>
                                                    <h5><%=project.getProjectLanguage() %></h5>
                                                </li>
                                                <li>
                                                    <a href="LikeServlet?op=student&sid=<%=student.getStudentId()%>&pid=<%=project.getProjectId()%>" style="text-decoration: none; color: white;"><span class="material-symbols-outlined">star</span><a>
                                                    <h5><%=project.getLikes() %></h5>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                        <%
                            }
                        %>
                        
                        <%
                        } else if (op.equals("followers")) {
                            for(Follow follower : followersList){
                                if(follower.getFollowedBy_entity().equals("student")){
                                    Student student1 = sdao.getStudentByUserName(follower.getFollowedBy());
                        %>
                                    <div class="cards" onload="makeActive('followers')">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=student1.getStudentUserName() %>_<%=student1.getStudentImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_student.jsp?id=<%= student1.getStudentId() %>"><%= student1.getStudentName() %><a></h3>
                                                    <h5 class="username"><%= student1.getStudentUserName() %></h5>
                                                </div>
                                            </div>
                                            <div class="cardicons">
                                                <ul>
                                                    <li>
                                                        <span class="material-symbols-outlined">menu_book</span>
                                                        <h5><%=student1.getProjects() %> Projects</h5>
                                                    </li>
                                                    <li>
                                                        <span class="material-symbols-outlined">group</span>
                                                        <h5><%=student1.getFollowers() %> Followers</h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                }else if(follower.getFollowedBy_entity().equals("college")){
                                    College college1 = cdao.getCollegeByUserName(follower.getFollowedBy());
                                %>
                                    <div class="cards">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=college1.getUserName() %>_<%=college1.getCollegeImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_college.jsp?id=<%= college1.getCollegeId() %>"><%= college1.getCollegeName() %><a></h3>
                                                    <h5 class="username"><%=college1.getUserName() %></h5>
                                                </div>
                                            </div>
                                            <div class="cardicons">
                                                <ul>
                                                    <li>
                                                        <span class="material-symbols-outlined">menu_book</span>
                                                        <h5><%=college1.getProjects() %> Projects</h5>
                                                    </li>
                                                    <li>
                                                        <span class="material-symbols-outlined">group</span>
                                                        <h5><%=college1.getFollowers() %> Followers</h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                        <%      }
                            }
                        }else if(op.equals("following")){
                            for(Follow following : followingList){
                                if(following.getFollowedTo_entity().equals("student")){
                                    Student student1 = sdao.getStudentByUserName(following.getFollowedTo());
                        %>
                                    <div class="cards">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=student1.getStudentUserName() %>_<%=student1.getStudentImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_student.jsp?id=<%= student1.getStudentId() %>"><%= student1.getStudentName() %><a></h3>
                                                    <h5 class="username"><%= student1.getStudentUserName() %></h5>
                                                </div>
                                            </div>
                                            <div class="cardicons">
                                                <ul>
                                                    <li>
                                                        <span class="material-symbols-outlined">menu_book</span>
                                                        <h5><%=student1.getProjects() %> Projects</h5>
                                                    </li>
                                                    <li>
                                                        <span class="material-symbols-outlined">group</span>
                                                        <h5><%=student1.getFollowers() %> Followers</h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                }else if(following.getFollowedTo_entity().equals("college")){
                                    College college1 = cdao.getCollegeByUserName(following.getFollowedTo());
                                %>
                                    <div class="cards">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=college1.getUserName() %>_<%=college1.getCollegeImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_college.jsp?id=<%= college1.getCollegeId() %>"><%= college1.getCollegeName() %><a></h3>
                                                    <h5 class="username"><%=college1.getUserName() %></h5>
                                                </div>
                                            </div>
                                            <div class="cardicons">
                                                <ul>
                                                    <li>
                                                        <span class="material-symbols-outlined">menu_book</span>
                                                        <h5><%=college1.getProjects() %> Projects</h5>
                                                    </li>
                                                    <li>
                                                        <span class="material-symbols-outlined">group</span>
                                                        <h5><%=college1.getFollowers() %> Followers</h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                        <%      }
                            }
                        }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
