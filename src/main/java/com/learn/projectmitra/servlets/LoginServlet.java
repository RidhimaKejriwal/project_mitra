
package com.learn.projectmitra.servlets;

import com.learn.projectmitra.dao.CollegeDao;
import com.learn.projectmitra.dao.StudentDao;
import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.entities.Student;
import com.learn.projectmitra.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try{
                String userType = request.getParameter("userType");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                HttpSession httpsession = request.getSession();
                
                if (userType.equals("student")) 
                {
                    StudentDao stDao = new StudentDao(FactoryProvider.getFactory());
                    Student student = stDao.getStudentByEmailAndPassword(email, password);

                    if (student == null) {
                        httpsession.setAttribute("error_message", "Invalid details !! try again");
                        response.sendRedirect("login.jsp");
                        return;
                    } else {
                        httpsession.setAttribute("current-student", student);
                        response.sendRedirect("profileStudent.jsp");
                    }
                } 
                else if(userType.equals("college")) 
                {
                    CollegeDao sellerDao = new CollegeDao(FactoryProvider.getFactory());
                    College college = sellerDao.getCollegeByEmailAndPassword(email, password);
                    if (college == null) {
                        httpsession.setAttribute("error_message", "Invalid details !! try again");
                        response.sendRedirect("login.jsp");
                        return;
                    } else {
                        httpsession.setAttribute("current-college", college);
                        response.sendRedirect("profileCollege.jsp");
                    }

                } 
            }
            catch (Exception e)
            {
                e.printStackTrace();
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
