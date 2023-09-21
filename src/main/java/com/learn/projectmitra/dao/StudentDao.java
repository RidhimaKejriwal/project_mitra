package com.learn.projectmitra.dao;

import com.learn.projectmitra.entities.Student;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
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
    
    public Student getStudentById(int id)
    {
        Student student = null;
        try
        {
            String query = "from Student where studentId =: id";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", id);
            student = (Student) q.uniqueResult();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return student;
    }
    
    public List<Student> getStudentBycollegeId(int cid)
    {
        List<Student> list = null;
        try
        {
            String query = "from Student where collegeId =: id";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", cid);
            list = q.list();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public Student getStudentByUserName(String userName)
    {
        Student student = null;
        try
        {
            String query = "from Student where studentUserName =: un";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("un", userName);
            student = (Student) q.uniqueResult();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return student;
    }
    
    public void updateStudent(Student student)
    {
        try
        {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.update(student);
            tx.commit();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }        
    }
    
    public List<Student> getSearchedStudents(String ch)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Student as s where s.studentName like :key or s.studentUserName like :key");
        query.setParameter("key", "%"+ch+"%");
        List<Student> list = query.list();
        return list;        
    }
    
    public List<Student> getStudentBycollegeId_branch(int cid, String branch)
    {
        List<Student> list = null;
        try
        {
            String query = "from Student where collegeId =: id and Branch =: b";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", cid);
            q.setParameter("b", branch);
            list = q.list();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public List<Student> getStudentBycollegeId_year(int cid, String year)
    {
        List<Student> list = null;
        try
        {
            String query = "from Student where collegeId =: id and year =: y";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", cid);
            q.setParameter("y", year);
            list = q.list();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
}
