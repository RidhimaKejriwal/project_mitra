<%-- 
    Document   : profileCollege
    Created on : 15-Sept-2023, 8:41:39 pm
    Author     : Dell
--%>

<%@page import="com.learn.projectmitra.entities.Project"%>
<%@page import="com.learn.projectmitra.dao.ProjectDao"%>
<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page import="com.learn.projectmitra.dao.StudentDao"%>
<%@page import="com.learn.projectmitra.entities.Follow"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.projectmitra.dao.FollowDao"%>
<%@page import="com.learn.projectmitra.helper.FactoryProvider"%>
<%@page import="com.learn.projectmitra.dao.CollegeDao"%>
<%@page import="com.learn.projectmitra.entities.College"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    College college = (College) session.getAttribute("current-college");
    if (college == null) {
        session.setAttribute("error_message", "You are not logged in!! Login first..");
        response.sendRedirect("login.jsp");
        return;
    }
    CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());
    String op = request.getParameter("op");
    FollowDao fdao = new FollowDao(FactoryProvider.getFactory());
    List<Follow> followersList = fdao.getallFollowers(college.getUserName());
    List<Follow> followingList = fdao.getallFollowing(college.getUserName());
    StudentDao sdao = new StudentDao(FactoryProvider.getFactory());
    
    String cat = request.getParameter("cat");
    String lang = request.getParameter("lang");
    String branch = request.getParameter("branch");
    String year = request.getParameter("year");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>College Profile Page</title>
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
    }else if(op.equals("students")){
    %>
    <body onload="makeActive('students')">
    <%
    }
    %>
        <div class="navbar">
            <ul>
                <li><span class="material-symbols-outlined">rocket</span></li>
                <li>Projects</li>
            </ul>
            <ul>
                <li><a style="text-decoration: none; color: white" href="LogoutServlet">Logout</a></li>
                <li class="signup"><%=college.getUserName()%></li>
            </ul>
        </div>
        <div class="container1">
            <div class="container2">
                <div class="container3">
                    <div class="pp">
                        <% String pic = college.getUserName() + "_" + college.getCollegeImage();%>
                        <img src="profileCollege/<%= pic%>" alt="profile picture">
                    </div>
                    <div class="pinfo">
                        <h2 class="name"><%= college.getCollegeName() %></h2>
                        <h3 class="username"><%=college.getUserName() %></h3>
                        <h5 class="profession"><%=college.getCollegeEmail() %></h5>
                        <div class="folfol">
                            <span class="material-symbols-outlined">groups</span>
                            <h5><span>&#8226;<%=college.getFollowers() %> </span>followers</h5>
                            <h5><span>&#8226;<%= college.getFollowing()%> </span>following</h5>
                        </div>
                        <div class="adrs">
                            <span class="material-symbols-outlined">location_on</span>
                            <h4 class="address"><%= college.getCollegeAddress() %></h4>
                        </div>
                        <div class="social">
                            <span class="material-symbols-outlined">link</span>
                            <a href="<%= college.getWeblink()%>" class="sociallink"><%= college.getWeblink()%></a>
                        </div>
                    </div>
                </div>
                <div class="container4">
                    <div class="cnav">
                        <div class="cnavs1">
                            <ul>
                                <a href="profileCollege.jsp?op=projects">
                                    <li id='projects'>
                                        <span class="material-symbols-outlined">library_books</span>
                                        Projects
                                    </li>
                                </a>
                                <a href="profileCollege.jsp?op=followers">
                                    <li id='followers'>
                                        <span class="material-symbols-outlined">group</span>
                                        Followers
                                    </li>
                                </a>
                                <a href="profileCollege.jsp?op=following">
                                    <li id="following">
                                        <span class="material-symbols-outlined">group</span>
                                        Following
                                    </li>
                                </a>
                                <a href="profileCollege.jsp?op=students">
                                    <li id="students">
                                        <span class="material-symbols-outlined">group</span>
                                        Students
                                    </li>
                                </a>
                            </ul>
                        </div>
<!--                        <div class="cnavs2">
                            <ul>
                                <a href="addProject.jsp">
                                    <li>
                                        <span class="material-symbols-outlined">post_add</span>
                                        Add Project
                                    </li>
                                </a>
                            </ul>
                        </div>-->
                    </div>
                    <div class="pcon">
                        <%
                            if (op == null || op.equals("projects")) {
                            ProjectDao pdao = new ProjectDao(FactoryProvider.getFactory());
                            List<Project> projects = null;
                            if(cat == null && lang == null )
                            {
                                projects = pdao.getProjectsByCollegetId(college.getCollegeId());
                            }else if(cat != null)
                            {
                                projects = pdao.getProjectsByCollegeId_Category(college.getCollegeId(), cat);
                            }else if(lang != null)
                            {
                                projects = pdao.getProjectsByCollegeId_Language(college.getCollegeId(), lang);
                            }
                        %>
                        <div class="menu-bar">
                            <div class="opt">
                                <select name="Language" id="lang" class="option1" onchange="location = this.value;">
                                    <option value="Language" disabled selected>Language</option>
                                    <option value="profileCollege.jsp?lang=Python">Python</option>
                                    <option value="profileCollege.jsp?lang=C/C++">C/C++</option>
                                    <option value="profileCollege.jsp?lang=Java">Java</option>
                                    <option value="profileCollege.jsp?lang=Web">Web</option>
                                </select>
                            </div>
                            <div class="opt">
                                <select name="category" id="category" class="option2" onchange="location = this.value;">
                                    <option value="category" disabled selected>Category</option>
                                    <option value="profileCollege.jsp?cat=Hardware">Hardware</option>
                                    <option value="profileCollege.jsp?cat=Software">Software</option>
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
                                                    <a href="LikeServlet?op=college&cid=<%=college.getCollegeId()%>&pid=<%=project.getProjectId()%>" style="text-decoration: none; color: white;"><span class="material-symbols-outlined">star</span></a>
                                                    <h5><%=project.getLikes()%></h5>
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
                                <%
                                }
                            }
                        }else if(op.equals("students")){
                            List<Student> students = null;
                            if(branch == null && year == null )
                            {
                                students = sdao.getStudentBycollegeId(college.getCollegeId());
                            }else if(branch != null)
                            {
                                students = sdao.getStudentBycollegeId_branch(college.getCollegeId(), branch);
                            }else if(year != null)
                            {
                                students = sdao.getStudentBycollegeId_year(college.getCollegeId(), year);
                            }
                        %>
                        <div class="menu-bar">
                            <div class="opt">
                                <select name="branch" id="branch" class="option1" onchange="location = this.value;">
                                    <option value="branch" disabled selected>Branch</option>
                                    <option value="profileCollege.jsp?op=students&branch=Artificial Intelligence and Machine Learning">Artificial Intelligence and Machine Learning</option>
                                    <option value="profileCollege.jsp?op=students&branch=Artificial Intelligence and Data Science">Artificial Intelligence and Data Science</option>
                                    <option value="profileCollege.jsp?op=students&branch=Cyber Security">Cyber Security</option>
                                    <option value="profileCollege.jsp?op=students&branch=Computer Science Enginnering">Computer Science Enginnering</option>
                                    <option value="profileCollege.jsp?op=students&branch=Electrical Enginnering">Electrical Enginnering</option>
                                    <option value="profileCollege.jsp?op=students&branch=Mechanical Enginnering">Mechanical Enginnering</option>
                                    <option value="profileCollege.jsp?op=students&branch=Information Technology">Information Technology</option>
                                </select>
                            </div>
                            <div class="opt">
                                <select name="year" id="year" class="option2" onchange="location = this.value;">
                                    <option value="year" disabled selected>Year</option>
                                    <option value="profileCollege.jsp?op=students&year=1st">First(1st)</option>
                                    <option value="profileCollege.jsp?op=students&year=2nd">Second(2nd)</option>
                                    <option value="profileCollege.jsp?op=students&year=3rd">Third(3rd)</option>
                                    <option value="profileCollege.jsp?op=students&year=4th">Fourth(4th)</option>
                                </select>
                            </div>
                        </div>
                        <%
                            for(Student student1 : students){
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
                            }
                        }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
