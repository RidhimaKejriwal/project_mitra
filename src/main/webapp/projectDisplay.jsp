
<%@page import="com.learn.projectmitra.entities.Files"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.projectmitra.dao.FilesDao"%>
<%@page import="com.learn.projectmitra.dao.CollegeDao"%>
<%@page import="com.learn.projectmitra.dao.StudentDao"%>
<%@page import="com.learn.projectmitra.entities.Project"%>
<%@page import="com.learn.projectmitra.helper.FactoryProvider"%>
<%@page import="com.learn.projectmitra.dao.ProjectDao"%>
<%@page import="com.learn.projectmitra.entities.College"%>
<%@page import="com.learn.projectmitra.entities.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Student student = (Student) session.getAttribute("current-student");
    College college = (College) session.getAttribute("current-college");
    if (student == null && college == null) {
        session.setAttribute("error_message", "You are not logged in!! Login first..");
        response.sendRedirect("login.jsp");
        return;
    }
    int projectId = Integer.parseInt(request.getParameter("id"));
    ProjectDao pdao = new ProjectDao(FactoryProvider.getFactory());
    Project project = pdao.getProjectsByProjectId(projectId);

    StudentDao sdao = new StudentDao(FactoryProvider.getFactory());
    Student student1 = sdao.getStudentById(project.getStudentId());
    CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());
    College college1 = cdao.getCollegeById(project.getCollegeId());

    FilesDao fdao = new FilesDao(FactoryProvider.getFactory());
    System.out.println(project.getStudentId());
    System.out.println(project.getProjectName());
    List<Files> files = fdao.getFilesByStudentId_projectName(project.getStudentId(), project.getProjectName());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Display</title>
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="stylesheet" href="css/projectDisplay.css">
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
                <li><a style="text-decoration: none; color: white" href="LogoutServlet">Logout</a></li>
                    <%
                        if (student != null) {
                    %>
                <li class="signup"><%=student.getStudentName()%></li>
                    <%
                    } else if (college != null) {
                    %>
                <li class="signup"><%= college.getUserName()%></li>
                    <%
                        }
                    %>
            </ul>
        </div>

        <div class="title">
            <h1><%=project.getProjectName()%></h1>
            <div class="acnt">
                <% String pic = student1.getStudentUserName() + "_" + student1.getStudentImage();%>
                <img src="profileCollege/<%=pic%>" alt="error">
                <div class="nm">
                    <p><%=student1.getStudentName()%></p>
                    <p><%=student1.getStudentUserName()%></p>
                </div>
            </div>
        </div>
        <hr>

        <div class="bigcon">
            <div class="con1">

                <div class="scon1">
                    <!-- Project Download -->
                    <div class="pd">
                        <ul>
                            <li><span class="material-symbols-outlined">home_storage</span></li>
                            <li>Files</li>
                        </ul>
                        <ul>
                            <li>Download</li>
                        </ul>
                    </div>
                    <!-- Files Container -->
                    <div class="fcon">
                        <%
                            for (Files file : files) {
                        %>
                        <div class="ab">
                            <p><a style="text-decoration: none; color: white; margin: 2vw" href="uploads/<%=file.getFileName()%>"><%=file.getFileName()%></a><p>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <h3>Project description</h3>
                    <div class="dcon">
                        <p style="margin: 1vw;"><%=project.getProjectDescription()%></p>
                    </div>

                    <h3>Project Images</h3>
                    <hr>
                    <img src="/47129.jpg" alt="error">
                    <img src="/47140.jpg" alt="error">
                    <hr>

                    <h3>Project Video</h3>
                    <hr>
                    <iframe width="560" height="500" src="<%=project.getVideolink()%>" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

                </div>

                <div class="scon2">
                    <div class="abt">
                        <h1>About</h1>
                    </div>
                    <hr>
                    <div class="abtd">
                        <ul>
                            <li><span class="material-symbols-outlined">download</span>Download</li>
                            <li><span class="material-symbols-outlined">visibility</span>Views</li>
                            <li><span class="material-symbols-outlined">matter</span>Citations</li>
                            <li><span class="material-symbols-outlined">star</span><%=project.getLikes()%></li>
                        </ul>
                    </div>
                    <hr>
                    <h1>Language Used</h1>
                    <div class="lacon">
                        <span class="material-symbols-outlined">globe</span>
                        <p><%=project.getProjectLanguage()%></p>
                    </div>
                    <hr>
                    <h1>Category</h1>
                    <div class="lacon">
                        <span class="material-symbols-outlined">globe</span>
                        <p><%=project.getProjectCategory()%></p>
                    </div>
                    <hr>
                </div>
            </div>
        </div>
    </body>
</html>
