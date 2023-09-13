package com.learn.projectmitra.dao;

import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.entities.Student;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CollegeDao {
    private SessionFactory factory;
    
    public CollegeDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    //get user by email and passwrd
    public College getCollegeByEmailAndPassword(String email, String password)
    {
        College college = null;
        
        try
        {
            String query = "from College where collegeEmail =: e and password =: p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);
            college = (College) q.uniqueResult();
            session.close();
            
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return college;
    }
    
    public College getCollegeByEmail(String email)
    {
        College college = null;
        try
        {
            String query = "from College where collegeEmail =: e";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            college = (College) q.uniqueResult();
            session.close();  
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return college;
    }
    
    public boolean saveCollege(College college)
    {
        boolean f = false;
        try
        {
            
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(college);
            tx.commit();
            session.close();
            
            f = true;
            
        }catch(Exception e)
        {
            e.printStackTrace();
            f = false;
        }
        
        return f;
    }
    
}
