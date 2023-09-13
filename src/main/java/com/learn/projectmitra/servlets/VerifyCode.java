package com.learn.projectmitra.servlets;

import com.learn.projectmitra.entities.Student;
import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class VerifyCode extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String user = request.getParameter("user");
            if (user.equals("college")) {
                College college = (College) session.getAttribute("authcode");
                String code = request.getParameter("authcode");

                if (code.equals(college.getVerifyCode())) {
                    try {
                        String verified = "YES";

                        college.setVerifyCode(verified);

                        Session hibernateSession = FactoryProvider.getFactory().openSession();
                        Transaction tx = hibernateSession.beginTransaction();
                        hibernateSession.save(college);
                        tx.commit();
                        hibernateSession.close();

                        session.removeAttribute("authcode");

                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("message", "Verification successfull !!..");
                        response.sendRedirect("login.jsp");
                        return;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    out.println("Incorrect verification code");
                }
            }
            Student student = (Student) session.getAttribute("authcode");
            String code = request.getParameter("authcode");

            if (code.equals(student.getVerifyCode())) {
                try {
                    String verified = "YES";

                    student.setVerifyCode(verified);

                    Session hibernateSession = FactoryProvider.getFactory().openSession();
                    Transaction tx = hibernateSession.beginTransaction();
                    hibernateSession.save(student);
                    tx.commit();
                    hibernateSession.close();

                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("message", "Verification successfull !!..");
                    response.sendRedirect("login.jsp");
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                out.println("Incorrect verification code");
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
