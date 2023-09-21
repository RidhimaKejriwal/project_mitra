package com.learn.projectmitra.servlets;

import com.learn.projectmitra.dao.CollegeDao;
import com.learn.projectmitra.dao.FilesDao;
import com.learn.projectmitra.dao.ProjectDao;
import com.learn.projectmitra.dao.StudentDao;
import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.entities.Files;
import com.learn.projectmitra.entities.Project;
import com.learn.projectmitra.entities.Student;
import com.learn.projectmitra.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class addProjectServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String projectName = request.getParameter("projectName");
            String language = request.getParameter("language");
            String category = request.getParameter("category");
            String description = request.getParameter("desc");
            String videoLink = request.getParameter("vidLink");
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            int collegeId = Integer.parseInt(request.getParameter("collegeId"));
            
            StudentDao sdao = new StudentDao(FactoryProvider.getFactory());
            Student student = sdao.getStudentById(studentId);
            CollegeDao cdao = new CollegeDao(FactoryProvider.getFactory());
            College college = cdao.getCollegeById(collegeId);
            
            ProjectDao pdao = new ProjectDao(FactoryProvider.getFactory());
            FilesDao fdao = new FilesDao(FactoryProvider.getFactory());

            Project project = new Project(projectName, studentId, collegeId, description, videoLink, category, language);

            HttpSession session = request.getSession();
            
            String fileName;
            List<Part> fileParts = (List<Part>) request.getParts();
            for (Part filePart : fileParts) {
                fileName = filePart.getSubmittedFileName();
                if (fileName != null) {
                    Files file = new Files(projectName, studentId, collegeId);
                    fileName = fileName.replaceAll(".html", ".txt");
                    fileName = fileName.replaceAll(".jsp", ".txt");
                    fileName = studentId + "_" + fileName;
                    file.setFileName(fileName);
                    String path = request.getRealPath("uploads") + File.separator + fileName;

                    //uploading
                    System.out.println("uploading ");
                    try {
                        FileOutputStream fos = new FileOutputStream(path);
                        InputStream is = filePart.getInputStream();
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
                    fdao.saveFile(file);
                }
            }
            
            int studentProjects = student.getProjects() + 1;
            student.setProjects(studentProjects);
            int collegeProjects = college.getProjects() + 1;
            college.setProjects(collegeProjects);
            sdao.updateStudent(student);
            cdao.updateCollege(college);
            pdao.saveProject(project);
            session.setAttribute("current-student", student);
            response.sendRedirect("profileStudent.jsp");
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
