
package com.learn.projectmitra.helper;

import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.entities.Student;
import java.util.Random;

public class SendMail {
    public String getRandom()
    {
        Random rd = new Random();
        int num = rd.nextInt(999999);
        
        return String.format("%06d", num);
    }
    
    public boolean sendToStudent(Student student)
    {
        GmailSender gmail = new GmailSender();
        String to = student.getStudentEmail();
        String from = "requestrentrepeat@gmail.com";
        String subject = "Student verification Email";
        String text = "Registration successful!! Please verify your account using this code: " + student.getVerifyCode();
        boolean b = gmail.sendEmail(to, from, subject, text);
        return b;
    }
    
    public boolean sendToCollege(College college)
    {
        GmailSender gmail = new GmailSender();
        String to = college.getCollegeEmail();
        String from = "requestrentrepeat@gmail.com";
        String subject = "Student verification Email";
        String text = "Registration successful!! Please verify your account using this code: " + college.getVerifyCode();
        boolean b = gmail.sendEmail(to, from, subject, text);
        return b;
    }
}
