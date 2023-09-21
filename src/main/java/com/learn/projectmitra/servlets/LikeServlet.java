package com.learn.projectmitra.servlets;

import com.learn.projectmitra.dao.LikeDao;
import com.learn.projectmitra.dao.ProjectDao;
import com.learn.projectmitra.entities.LikebyCollege;
import com.learn.projectmitra.entities.LikebyStudent;
import com.learn.projectmitra.entities.Project;
import com.learn.projectmitra.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LikeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String op = request.getParameter("op");
            int pid = Integer.parseInt(request.getParameter("pid"));
            ProjectDao pdao = new ProjectDao(FactoryProvider.getFactory());
            Project project = pdao.getProjectsByProjectId(pid);
            LikeDao ldao = new LikeDao(FactoryProvider.getFactory());

            if (op.equals("student")) {
                int sid = Integer.parseInt(request.getParameter("sid"));

                if (ldao.isLikedByStudent(sid, pid)) {
                    ldao.deleteLike(sid, pid);
                    int likes = project.getLikes() - 1;
                    project.setLikes(likes);
                    pdao.updateProject(project);
                } else {
                    LikebyStudent like = new LikebyStudent();
                    like.setStudentId(sid);
                    like.setProjectId(pid);
                    ldao.saveLikeByStudent(like);

                    int likescount = project.getLikes() + 1;
                    project.setLikes(likescount);
                    pdao.updateProject(project);
                }

                response.sendRedirect("profileStudent.jsp");
            }else if(op.equals("college")){
                int cid = Integer.parseInt(request.getParameter("cid"));
                
                if (ldao.isLikedByCollege(cid, pid)) {
                    ldao.deleteLikebyCollege(cid, pid);
                    int likes = project.getLikes() - 1;
                    project.setLikes(likes);
                    pdao.updateProject(project);
                } else {
                    LikebyCollege like = new LikebyCollege(cid, pid);
                    ldao.saveLikeByCollege(like);

                    int likescount = project.getLikes() + 1;
                    project.setLikes(likescount);
                    pdao.updateProject(project);
                }
                
                response.sendRedirect("profileCollege.jsp");
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
