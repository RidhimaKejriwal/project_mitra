
package com.learn.projectmitra.dao;

import com.learn.projectmitra.entities.Files;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class FilesDao {
    private SessionFactory factory;
    
    public FilesDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public boolean saveFile(Files file)
    {
        boolean f = false;
        try
        {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(file);
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
    
    public List<Files> getFilesByStudentId_projectName(int studentId, String projectName)
    {
        List<Files> list = null;
        Files file = null;
        try
        {
//            System.out.println(studentId);
//            System.out.println(stude);
            String query = "from Files where studentId =: id and projectName =: pn";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", studentId);
            q.setParameter("pn", projectName);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
}
