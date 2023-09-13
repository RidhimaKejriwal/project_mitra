
<%@page import="java.util.Map"%>
<%@page import="com.learn.projectmitra.helper.Helper"%>
<%@page import="com.learn.projectmitra.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    </head>
    <body>
        <%
//            out.println(FactoryProvider.getFactory());
            Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());
        %>
        <video autoplay muted loop id="myVideo">
            <source src="img/video.mp4" type="video/mp4">
        </video>
        <!-- First Container for HomePage -->
        <div class="container1">
            <!-- Second Container for TagLine -->
            <div class="container2">
                <div class="subcont1">
                    <div class="sub-subcont1"></div>
                    <div class="sub-subcont2">
                        <h1>You create for <span>India</span>,</h1>
                        <h1>We create for you.</h1>
                        <h4>Trusted by Colleges all over India.
                    </div>
                </div>
                <div class="subcont2">
                    <div class="sub-subcont3">
                        <span class="material-symbols-outlined">rocket_launch</span>
                    </div>
                    <div class="sub-subcont4">
                        <h1>Start Your Journey</h1>
                    </div>
                </div>
            </div>
        </div>



        <!-- Third Container for Showcasing Profile Page -->
        <div class="container3">
            <!-- Fourth Container for Profile Page Photo-->
            <div class="container4">
                <div class="subcont1">
                    <div class="sub-subcont1">
                        <span class="material-symbols-outlined">person</span>
                    </div>
                    <div class="sub-subcont2">
                        <h1>Profile</h1>
                    </div>
                </div>
                <div class="subcont2">
                    <div class="sub-subcont3"></div>
                    <div class="sub-subcont4">
                        <h1><span>Showcase</span> Your</h1>
                        <h1>Profile and</h1>
                        <h1>Projects.</h1>
                    </div>
                </div>
            </div>
        </div>


        <!-- Fifth Container for Showcasing Profile Page -->
        <div class="container5">
            <!-- Sixth Container for Profile Page Photo-->
            <div class="container6">
                <div class="subcont1">
                    <div class="sub-subcont1">
                        <span class="material-symbols-outlined">groups</span>
                    </div>
                    <div class="sub-subcont2">
                        <h1>Collaboration</h1>
                    </div>
                </div>
                <div class="subcont2">
                    <div class="sub-subcont3"></div>
                    <div class="sub-subcont4">
                        <h1><span>Collaborate</span></h1>
                        <h1>with</h1>
                        <h1>Friends</h1>
                        <h1>and <span>Share</span></h1>
                        <h1>Projects.</h1>
                    </div>
                </div>
            </div>
        </div>

        <!-- seventh Container for Achievements -->
        <div class="container7">
            <div class="container8">
                <div class="subcont1">
                    <div class="sub-subcont1">
                        <span class="material-symbols-outlined">military_tech</span>
                    </div>
                    <div class="sub-subcont2">
                        <h1>Achievements</h1>
                    </div>
                </div>
                <div class="subcont2">
                    <div class="sub-subcont3"></div>
                    <div class="sub-subcont4">
                        <div class="cr">
                            <h1>Colleges Registered</h1>
                            <h1><%= m.get("collegeCount")%></h1>
                        </div>
                        <div class="sr">
                            <h1>Students Registered</h1>
                            <h1><%= m.get("studentCount")%></h1>
                        </div>
                        <div class="ps">
                            <h1>Projects Submitted</h1>
                            <h1><%= m.get("projectCount")%></h1>
                        </div>
                        <div class="bc"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- NavBar -->
        <div class="navbar">
            <ul>
                <span class="material-symbols-outlined">rocket</span>
                <li>Services</li>
            </ul>
            <ul>
                <li><a href="login.jsp">Login</a></li>
                <li class="signup"><a href="signup.jsp">Sign up</a></li>
            </ul>
        </div>
        <a href="login.jsp"></a>


        <!-- Footer -->
        <footer>
            <div class="txt">
                <h2>&#169;All Rights Reserved</h2>
            </div>
            <div class="rgstr">
                <input type="email" name="" id="email" placeholder="Email Address">
                <button>Sign Up</button>
            </div>
        </footer>

    </body>
</html>
