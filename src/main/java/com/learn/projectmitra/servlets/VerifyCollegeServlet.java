package com.learn.projectmitra.servlets;

import com.learn.projectmitra.dao.CollegeDao;
import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.helper.FactoryProvider;
import com.learn.projectmitra.helper.SendMail;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.hibernate.Session;

@MultipartConfig
public class VerifyCollegeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //fetch form details..
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String cpassword = request.getParameter("cpassword");
            String password = request.getParameter("password");
            String weblink = request.getParameter("link");
            String userName = request.getParameter("userName");
            String address = request.getParameter("address");
            int followers = 0;
            int following = 0;
//            System.out.println("abc");
            Part part = request.getPart("pic");
            String pic = part.getSubmittedFileName();
//            System.out.println(pic);

            Session s = FactoryProvider.getFactory().openSession();
            HttpSession httpSession = request.getSession();

            if (!cpassword.equals(password)) {
                httpSession.setAttribute("error_message", "Confirm password do not match password");
                response.sendRedirect("signup.jsp?user=college");
                return;
            }

            SendMail sm = new SendMail();
            String code = sm.getRandom();

            CollegeDao collegeDao = new CollegeDao(FactoryProvider.getFactory());
            College college = collegeDao.getCollegeByEmail(email);

            if (college != null) {
                httpSession.setAttribute("error_message", "Email already registered");
                response.sendRedirect("signup.jsp?user=college");
                return;
            }

            College college1 = new College(name, email, pic, address, userName, weblink, password, code);
            if (pic.equals("")) {
                college1.setCollegeImage("default.png");
//                System.out.println("if block");
            } else {
                college1.setCollegeImage(pic);
//                System.out.println("else block");
            }

//            upload image in folder
            String path = request.getRealPath("profileCollege") + File.separator + userName + "_" +pic;
            System.out.println(path);

            //uploading code
            System.out.println("uploading ");
            try {
                FileOutputStream fos = new FileOutputStream(path);
                InputStream is = part.getInputStream();
                //reading data
                byte[] data = new byte[is.available()];
                is.read(data);
                //writing data
                fos.write(data);
                fos.close();
                System.out.println("file uploaded");
            } catch (Exception e) {
                e.printStackTrace();
            }

            boolean b = sm.sendToCollege(college1);
            if (b) {
//                collegeDao.saveCollege(college1);
                HttpSession session = request.getSession();
                session.setAttribute("authcode", college1);
                session.setAttribute("part", part);
                session.setAttribute("message", "We already sent a verification code to your email!..");
                response.sendRedirect("signup.jsp?user=college");
            } else {
                System.out.println("There is some problem in sending mail..");
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
