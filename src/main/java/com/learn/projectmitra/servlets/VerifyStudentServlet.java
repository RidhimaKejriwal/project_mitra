package com.learn.projectmitra.servlets;

import com.learn.projectmitra.dao.StudentDao;
import com.learn.projectmitra.entities.Student;
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
public class VerifyStudentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //fetch form details..
            String email = request.getParameter("email");
            System.out.println(email);
            String name = request.getParameter("name");
            System.out.println(name);
            int collegeId = Integer.parseInt(request.getParameter("collegeId"));
            System.out.println(collegeId);
            String cpassword = request.getParameter("cpassword");
            String password = request.getParameter("password");
            String weblink = request.getParameter("link");
            String userName = request.getParameter("userName");
            String profession = request.getParameter("profession");
            String address = request.getParameter("address");
            int followers = 0;
            int following = 0;
            Part part = request.getPart("pic");
            String pic = part.getSubmittedFileName();
            String year = request.getParameter("year");
            String branch = request.getParameter("branch");

            Session s = FactoryProvider.getFactory().openSession();
            HttpSession httpSession = request.getSession();

            if (!cpassword.equals(password)) {
                httpSession.setAttribute("error_message", "Confirm password do not match password");
                response.sendRedirect("register.jsp");
                return;
            }

            SendMail sm = new SendMail();
            String code = sm.getRandom();

            StudentDao studentDao = new StudentDao(FactoryProvider.getFactory());
            Student student = studentDao.getStudentByEmail(email);

            if (student != null) {
                httpSession.setAttribute("error_message", "Email already registered");
                response.sendRedirect("signup.jsp?user=student");
                return;
            }

            Student student1 = new Student(name, userName, email, collegeId, pic, profession, address, password, weblink, followers, following, code);
            student1.setYear(year);
            student1.setBranch(branch);
            if (pic.equals("")) {
                student1.setStudentImage("default.png");
//                System.out.println("if block");
            } else {
                student1.setStudentImage(pic);
//                System.out.println("else block");
            }

//            upload image in folder
            String path = request.getRealPath("profileCollege") + File.separator + userName + "_" + pic;
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

            boolean b = sm.sendToStudent(student1);
            if (b) {
                HttpSession session = request.getSession();
                session.setAttribute("authcode", student1);
                session.setAttribute("message", "We already sent a verification code to your email!..");
                response.sendRedirect("signup.jsp?user=student");
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
