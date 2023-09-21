<%-- 
    Document   : show_profile_college
    Created on : 15-Sept-2023, 8:42:12 pm
    Author     : Dell
--%>

<%@page import="com.learn.projectmitra.entities.Project"%>
<%@page import="com.learn.projectmitra.dao.ProjectDao"%>
<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page import="com.learn.projectmitra.entities.Follow"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.projectmitra.dao.FollowDao"%>
<%@page import="com.learn.projectmitra.dao.CollegeDao"%>
<%@page import="com.learn.projectmitra.helper.FactoryProvider"%>
<%@page import="com.learn.projectmitra.dao.StudentDao"%>
<%@page import="com.learn.projectmitra.entities.College"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    College college1 = (College) session.getAttribute("current-college");
    Student student1 = (Student) session.getAttribute("current-student");
    if (student1 == null && college1 == null) {
        session.setAttribute("error_message", "You are not logged in!! Login first..");
        response.sendRedirect("login.jsp");
        return;
    }
    int id = Integer.parseInt(request.getParameter("id"));
    StudentDao sdao = new StudentDao(FactoryProvider.getFactory());
    CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());
    College college = cdao.getCollegeById(id);
    String op = request.getParameter("op");
    FollowDao fdao = new FollowDao(FactoryProvider.getFactory());
    List<Follow> followersList = fdao.getallFollowers(college.getUserName());
    List<Follow> followingList = fdao.getallFollowing(college.getUserName());
    Follow fol = null;
    Follow fol1 = null;
    if(college1 != null){
        fol = fdao.getFollowerBy_followedByandfollowedTo(college1.getUserName(), college.getUserName());
        fol1 = fdao.getFollowerBy_followedByandfollowedTo(college.getUserName(), college1.getUserName());
    }else if(student1 != null){
        fol = fdao.getFollowerBy_followedByandfollowedTo(student1.getStudentUserName(), college.getUserName());
        fol1 = fdao.getFollowerBy_followedByandfollowedTo(college.getUserName(), student1.getStudentUserName());
    }
    
    String cat = request.getParameter("cat");
    String lang = request.getParameter("lang");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Colleges Profiles</title>
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
                <li><a style="text-decoration: none; color: white" href="LogoutServlet">Logout</a></li>
                <%
                    if(college1 != null){
                %>
                    <li class="signup"><%=college1.getUserName()%></li>
                <%
                    }else if(student1 != null){
                %>
                    <li class="signup"><%= student1.getStudentName() %></li>
                <%
                }
                %>
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
                        <%
                            if(college1 != null){
                        %>
                            <form action="FollowServlet?op=collegeCollege" method="post">
                                <input type="text" hidden value="<%=college1.getUserName() %>" name="followedBy">
                                <input type="text" hidden value="<%=college.getUserName() %>" name="followedTo">
                                <%
                                    if(fol == null){
                                        if(fol1 != null){
                                        // remove follower link
                                %>
                                        <a style="color: #1ecdff; text-decoration: none;" href="FollowServlet?op=removeFollowerCC&followedBy=<%=college1.getUserName() %>&followedTo=<%=college.getUserName() %>"> Remove Follower?</a>
                                        <%
                                            }
                                        %>
                                <button type="submit" class="follow">Follow</button>
                                <%
                                    }else{
                                        if(fol1 != null){
                                        // remove follower link
                                %>
                                        <a style="color: #1ecdff; text-decoration: none;" href="FollowServlet?op=removeFollowerCC&followedBy=<%=college1.getUserName() %>&followedTo=<%=college.getUserName() %>"> Remove Follower?</a>
                                        <%
                                            }
                                        %>
                                <button type="submit" class="unfollow">UnFollow</button>
                                <%
                                    }
                                %>
                            </form>
                        <%  
                            }else if(student1 != null){
                        %>
                            <form action="FollowServlet?op=studentCollege" method="post">
                                <input type="text" hidden value="<%=student1.getStudentUserName() %>" name="followedBy">
                                <input type="text" hidden value="<%=college.getUserName() %>" name="followedTo">
                                <%
                                    if(fol == null){
                                        if(fol1 != null){
                                        // remove follower link
                                %>
                                        <a style="color: #1ecdff; text-decoration: none;" href="FollowServlet?op=removeFollowerSC&followedBy=<%=student1.getStudentUserName() %>&followedTo=<%=college.getUserName() %>"> Remove Follower?</a>
                                        <%
                                            }
                                        %>
                                <button type="submit" class="follow">Follow</button>
                                <%
                                    }else{
                                        if(fol1 != null){
                                        // remove follower link
                                %>
                                        <a style="color: #1ecdff; text-decoration: none;" href="FollowServlet?op=removeFollowerSC&followedBy=<%=student1.getStudentUserName() %>&followedTo=<%=college.getUserName() %>"> Remove Follower?</a>
                                        <%
                                            }
                                        %>
                                <button type="submit" class="unfollow">UnFollow</button>
                                <%
                                    }
                                %>
                            </form>
                        <%   
                            }
                        %>
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
                                <a href="show_profile_college.jsp?op=projects&id=<%=request.getParameter("id") %>">
                                    <li id="projects">
                                        <span class="material-symbols-outlined">library_books</span>
                                        Projects
                                    </li>
                                </a>
                                <a href="show_profile_college.jsp?op=followers&id=<%=request.getParameter("id") %>">
                                    <li id="followers">
                                        <span class="material-symbols-outlined">group</span>
                                        Followers
                                    </li>
                                </a>
                                <a href="show_profile_college.jsp?op=following&id=<%=request.getParameter("id") %>">
                                    <li id="following">
                                        <span class="material-symbols-outlined">group</span>
                                        Following
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
                                    <option value="show_profile_college.jsp?id=<%=request.getParameter("id")%>&lang=Python">Python</option>
                                    <option value="show_profile_college.jsp?id=<%=request.getParameter("id")%>&lang=C/C++">C/C++</option>
                                    <option value="show_profile_college.jsp?id=<%=request.getParameter("id")%>&lang=Java">Java</option>
                                    <option value="show_profile_college.jsp?id=<%=request.getParameter("id")%>&lang=Web">Web</option>
                                </select>
                            </div>
                            <div class="opt">
                                <select name="category" id="category" class="option2" onchange="location = this.value;">
                                    <option value="category" disabled selected>Category</option>
                                    <option value="show_profile_college.jsp?id=<%=request.getParameter("id")%>&cat=Hardware">Hardware</option>
                                    <option value="show_profile_college.jsp?id=<%=request.getParameter("id")%>&cat=Software">Software</option>
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
                                                    <%
                                                        if(student1 != null){
                                                    %>
                                                        <a href="LikeServlet?op=student&sid=<%=student1.getStudentId()%>&pid=<%=project.getProjectId()%>" style="text-decoration: none; color: white;"><span class="material-symbols-outlined">star</span><a>
                                                    <%
                                                        }else if(college1!=null){
                                                    %>
                                                        <a href="LikeServlet?op=college&cid=<%=college1.getCollegeId()%>&pid=<%=project.getProjectId()%>" style="text-decoration: none; color: white;"><span class="material-symbols-outlined">star</span></a>
                                                    <%
                                                        }
                                                    %>
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
                                    Student student2 = sdao.getStudentByUserName(follower.getFollowedBy());
                        %>
                                    <div class="cards">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=student2.getStudentUserName() %>_<%=student2.getStudentImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_student.jsp?id=<%= student2.getStudentId() %>"><%= student2.getStudentName() %><a></h3>
                                                    <h5 class="username"><%= student2.getStudentUserName() %></h5>
                                                </div>
                                            </div>
                                            <div class="cardicons">
                                                <ul>
                                                    <li>
                                                        <span class="material-symbols-outlined">menu_book</span>
                                                        <h5><%=student2.getProjects() %> Projects</h5>
                                                    </li>
                                                    <li>
                                                        <span class="material-symbols-outlined">group</span>
                                                        <h5><%=student2.getFollowers() %> Followers</h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                }else if(follower.getFollowedBy_entity().equals("college")){
                                    College college2 = cdao.getCollegeByUserName(follower.getFollowedBy());
                                %>
                                <div class="cards">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=college2.getUserName() %>_<%=college2.getCollegeImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_college.jsp?id=<%= college2.getCollegeId() %>"><%= college2.getCollegeName() %><a></h3>
                                                    <h5 class="username"><%=college2.getUserName() %></h5>
                                                </div>
                                            </div>
                                            <div class="cardicons">
                                                <ul>
                                                    <li>
                                                        <span class="material-symbols-outlined">menu_book</span>
                                                        <h5><%=college2.getProjects() %> Projects</h5>
                                                    </li>
                                                    <li>
                                                        <span class="material-symbols-outlined">group</span>
                                                        <h5><%=college2.getFollowers() %> Followers</h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                        <%      }
                            }
                        } else if(op.equals("following")) {
                            for(Follow following : followingList){      
                                if(following.getFollowedTo_entity().equals("student")){
                                    Student student2 = sdao.getStudentByUserName(following.getFollowedTo());
                        %>
                                    <div class="cards">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=student2.getStudentUserName() %>_<%=student2.getStudentImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_student.jsp?id=3"><%=student2.getStudentName() %><a></h3>
                                                    <h5 class="username"><%= student2.getStudentUserName() %></h5>
                                                </div>
                                            </div>
                                            <div class="cardicons">
                                                <ul>
                                                    <li>
                                                        <span class="material-symbols-outlined">menu_book</span>
                                                        <h5><%=student2.getProjects() %> Projects</h5>
                                                    </li>
                                                    <li>
                                                        <span class="material-symbols-outlined">group</span>
                                                        <h5><%=student2.getFollowers() %> Followers</h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                }else if(following.getFollowedTo_entity().equals("college")){
                                    College college2 = cdao.getCollegeByUserName(following.getFollowedTo());
                                %>
                                <div class="cards">
                                        <div class="card1">
                                            <div class="cinfo">
                                                <div class="spp">
                                                    <img src="profileCollege/<%=college2.getUserName() %>_<%=college2.getCollegeImage() %>" alt="profile picture" class="pp">
                                                </div>
                                                <div class="pnam">
                                                    <h3 class="name"><a style="text-decoration: none; color: #2f81f7;" href="show_profile_college.jsp?id=<%= college2.getCollegeId() %>"><%= college2.getCollegeName() %><a></h3>
                                                    <h5 class="username"><%=college2.getUserName() %></h5>
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
