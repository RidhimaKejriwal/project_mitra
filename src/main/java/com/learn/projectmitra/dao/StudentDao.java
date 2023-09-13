package com.learn.projectmitra.dao;

import com.learn.projectmitra.entities.Student;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class StudentDao {
    private SessionFactory factory;
    
    public StudentDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    //get user by email and passwrd
    public Student getStudentByEmailAndPassword(String email, String password)
    {
        Student student = null;
        
        try
        {
            String query = "from Student where studentEmail =: e and password =: p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);
            student = (Student) q.uniqueResult();
            session.close();
            
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return student;
    }
    
    public Student getStudentByEmail(String email)
    {
        Student student = null;
        try
        {
            String query = "from Student where studentEmail =: e";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            student = (Student) q.uniqueResult();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return student;
    }
    
}
