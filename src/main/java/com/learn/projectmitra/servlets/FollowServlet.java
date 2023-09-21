package com.learn.projectmitra.servlets;

import com.learn.projectmitra.dao.CollegeDao;
import com.learn.projectmitra.dao.FollowDao;
import com.learn.projectmitra.dao.StudentDao;
import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.entities.Follow;
import com.learn.projectmitra.entities.Student;
import com.learn.projectmitra.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FollowServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String op = request.getParameter("op");

            String followedBy = request.getParameter("followedBy");
            String followedTo = request.getParameter("followedTo");
            Follow follower1 = new Follow(followedBy, followedTo);
            
            FollowDao fdao = new FollowDao(FactoryProvider.getFactory());
            StudentDao sdao = new StudentDao(FactoryProvider.getFactory());
            CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());

            HttpSession httpsession = request.getSession();

            if (op.equals("student")) {
                Student student1 = sdao.getStudentByUserName(followedBy);
                Student student2 = sdao.getStudentByUserName(followedTo);

                Follow follower = fdao.getFollowerBy_followedByandfollowedTo(followedBy, followedTo);
                if (follower == null) {
                    //add follower
                    //increase follower of followed to
                    int followers = student2.getFollowers() + 1;
                    System.out.println(followers);
                    student2.setFollowers(followers);
                    //increase following of followed by
                    int following = student1.getFollowing() + 1;
                    System.out.println(following);
                    student1.setFollowing(following);
                    follower1.setFollowedBy_entity("student");
                    follower1.setFollowedTo_entity("student");
                    fdao.saveFollower(follower1);
                    sdao.updateStudent(student1);
                    sdao.updateStudent(student2);
                    httpsession.setAttribute("current-student", student1);
                } else {
                    // remove follower
                    //decrease follower of followed to
                    int followers = student2.getFollowers() - 1;
                    System.out.println(followers);
                    student2.setFollowers(followers);
                    //decrease following of followed by
                    int following = student1.getFollowing() - 1;
                    System.out.println(following);
                    student1.setFollowing(following);
                    fdao.deleteFollower(followedBy, followedTo);
                    sdao.updateStudent(student1);
                    sdao.updateStudent(student2);
                    httpsession.setAttribute("current-student", student1);
                }
                response.sendRedirect("profileStudent.jsp");
            } 
            else if (op.equals("removeFollower")) {
                Student student1 = sdao.getStudentByUserName(followedBy);
                Student student2 = sdao.getStudentByUserName(followedTo);

                int followers = student1.getFollowers() - 1;
                student1.setFollowers(followers);
                int following = student2.getFollowing() - 1;
                student2.setFollowing(following);
                fdao.deleteFollower(followedTo, followedBy);
                sdao.updateStudent(student1);
                sdao.updateStudent(student2);
                httpsession.setAttribute("current-student", student1);
                response.sendRedirect("profileStudent.jsp");
            }
            else if(op.equals("college"))
            {
                College college = cdao.getCollegeByUserName(followedBy);
                Student student2 = sdao.getStudentByUserName(followedTo);

                Follow follower = fdao.getFollowerBy_followedByandfollowedTo(followedBy, followedTo);
                if (follower == null) {
                    //add follower
                    //increase follower of followed to
                    int followers = student2.getFollowers() + 1;
                    System.out.println(followers);
                    student2.setFollowers(followers);
                    //increase following of followed by
                    int following = college.getFollowing() + 1;
                    System.out.println(following);
                    college.setFollowing(following);
                    follower1.setFollowedBy_entity("college");
                    follower1.setFollowedTo_entity("student");
                    fdao.saveFollower(follower1);
                    cdao.updateCollege(college);
                    sdao.updateStudent(student2);
                    httpsession.setAttribute("current-college", college);
                } else {
                    // remove follower
                    //decrease follower of followed to
                    int followers = student2.getFollowers() - 1;
                    System.out.println(followers);
                    student2.setFollowers(followers);
                    //decrease following of followed by
                    int following = college.getFollowing() - 1;
                    System.out.println(following);
                    college.setFollowing(following);
                    fdao.deleteFollower(followedBy, followedTo);
                    cdao.updateCollege(college);
                    sdao.updateStudent(student2);
                    httpsession.setAttribute("current-college", college);
                }
                response.sendRedirect("profileCollege.jsp");
            }
            else if (op.equals("removeFollowerCollege")) {
                
                College college = cdao.getCollegeByUserName(followedBy);
                Student student2 = sdao.getStudentByUserName(followedTo);
                int followers = college.getFollowers() - 1;
                college.setFollowers(followers);
                int following = student2.getFollowing() - 1;
                student2.setFollowing(following);
                fdao.deleteFollower(followedTo, followedBy);
                cdao.updateCollege(college);
                sdao.updateStudent(student2);
                httpsession.setAttribute("current-college", college);
                response.sendRedirect("profileCollege.jsp");
            }
            else if (op.equals("collegeCollege")) {
                College college1 = cdao.getCollegeByUserName(followedBy);
                College college2 = cdao.getCollegeByUserName(followedTo);

                Follow follower = fdao.getFollowerBy_followedByandfollowedTo(followedBy, followedTo);
                if (follower == null) {
                    //add follower
                    //increase follower of followed to
                    int followers = college2.getFollowers() + 1;
                    System.out.println(followers);
                    college2.setFollowers(followers);
                    //increase following of followed by
                    int following = college1.getFollowing() + 1;
                    System.out.println(following);
                    college1.setFollowing(following);
                    follower1.setFollowedBy_entity("college");
                    follower1.setFollowedTo_entity("college");
                    fdao.saveFollower(follower1);
                    cdao.updateCollege(college1);
                    cdao.updateCollege(college2);
                    httpsession.setAttribute("current-college", college1);
                } else {
                    // remove follower
                    //decrease follower of followed to
                    int followers = college2.getFollowers() - 1;
                    System.out.println(followers);
                    college2.setFollowers(followers);
                    //decrease following of followed by
                    int following = college1.getFollowing() - 1;
                    System.out.println(following);
                    college1.setFollowing(following);
                    fdao.deleteFollower(followedBy, followedTo);
                    cdao.updateCollege(college1);
                    cdao.updateCollege(college2);
                    httpsession.setAttribute("current-college", college1);
                }
                response.sendRedirect("profileCollege.jsp");
            }
            else if (op.equals("removeFollowerCC")) {
                College college1 = cdao.getCollegeByUserName(followedBy);
                College college2 = cdao.getCollegeByUserName(followedTo);

                int followers = college1.getFollowers() - 1;
                college1.setFollowers(followers);
                int following = college2.getFollowing() - 1;
                college2.setFollowing(following);
                fdao.deleteFollower(followedTo, followedBy);
                cdao.updateCollege(college1);
                cdao.updateCollege(college2);
                httpsession.setAttribute("current-college", college1);
                response.sendRedirect("profileCollege.jsp");
            }
            else if (op.equals("studentCollege")) {
                Student student1 = sdao.getStudentByUserName(followedBy);
                College college2 = cdao.getCollegeByUserName(followedTo);

                Follow follower = fdao.getFollowerBy_followedByandfollowedTo(followedBy, followedTo);
                if (follower == null) {
                    //add follower
                    //increase follower of followed to
                    int followers = college2.getFollowers() + 1;
                    System.out.println(followers);
                    college2.setFollowers(followers);
                    //increase following of followed by
                    int following = student1.getFollowing() + 1;
                    System.out.println(following);
                    student1.setFollowing(following);
                    follower1.setFollowedBy_entity("student");
                    follower1.setFollowedTo_entity("college");
                    fdao.saveFollower(follower1);
                    sdao.updateStudent(student1);
                    cdao.updateCollege(college2);
                    httpsession.setAttribute("current-student", student1);
                } else {
                    // remove follower
                    //decrease follower of followed to
                    int followers = college2.getFollowers() - 1;
                    System.out.println(followers);
                    college2.setFollowers(followers);
                    //decrease following of followed by
                    int following = student1.getFollowing() - 1;
                    System.out.println(following);
                    student1.setFollowing(following);
                    fdao.deleteFollower(followedBy, followedTo);
                    sdao.updateStudent(student1);
                    cdao.updateCollege(college2);
                    httpsession.setAttribute("current-student", student1);
                }
                response.sendRedirect("profileStudent.jsp");
            }
            else if (op.equals("removeFollowerSC")) {
                Student student1 = sdao.getStudentByUserName(followedBy);
                College college2 = cdao.getCollegeByUserName(followedTo);

                int followers = student1.getFollowers() - 1;
                student1.setFollowers(followers);
                int following = college2.getFollowing() - 1;
                college2.setFollowing(following);
                fdao.deleteFollower(followedTo, followedBy);
                sdao.updateStudent(student1);
                cdao.updateCollege(college2);
                httpsession.setAttribute("current-student", student1);
                response.sendRedirect("profileStudent.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
