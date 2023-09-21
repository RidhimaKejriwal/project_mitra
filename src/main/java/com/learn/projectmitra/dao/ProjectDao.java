
package com.learn.projectmitra.dao;

import com.learn.projectmitra.entities.Project;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProjectDao {
    private SessionFactory factory;
    
    public ProjectDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public boolean saveProject(Project project)
    {
        boolean f = false;
        try
        {
            
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(project);
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
    
    public void updateProject(Project project)
    {
        try
        {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.update(project);
            tx.commit();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }        
    }
    
    public Project getProjectsByProjectId(int projectId)
    {
        Project project = null;
        try
        {
            String query = "from Project where projectId =: id";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", projectId);
            project = (Project) q.uniqueResult();
            session.close();
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return project;
    }
    
    public List<Project> getProjectsByStudentId(int studentId)
    {
        List<Project> list = null;
        Project project = null;
        try
        {
            String query = "from Project where StudentId =: id";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", studentId);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Project> getProjectsByCollegetId(int collegeId)
    {
        List<Project> list = null;
        Project project = null;
        try
        {
            String query = "from Project where collegeId =: id";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", collegeId);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Project> getProjectsByStudentId_Language(int studentId, String language)
    {
        List<Project> list = null;
        Project project = null;
        try
        {
            String query = "from Project where StudentId =: id and projectLanguage =: lang";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", studentId);
            q.setParameter("lang", language);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Project> getProjectsByCategory(int studentId, String category)
    {
        List<Project> list = null;
        Project project = null;
        try
        {
            String query = "from Project where StudentId =: id and projectCategory =: cat";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", studentId);
            q.setParameter("cat", category);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Project> getProjectsByCollegeId_Language(int collegeId, String language)
    {
        List<Project> list = null;
        Project project = null;
        try
        {
            String query = "from Project where collegeId =: id and projectLanguage =: lang";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", collegeId);
            q.setParameter("lang", language);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Project> getProjectsByCollegeId_Category(int collegeId, String category)
    {
        List<Project> list = null;
        Project project = null;
        try
        {
            String query = "from Project where collegeId =: id and projectCategory =: cat";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("id", collegeId);
            q.setParameter("cat", category);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Project> getSearchedProjects(String ch)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Project as p where p.projectName like :key");
        query.setParameter("key", "%"+ch+"%");
        List<Project> list = query.list();
        return list;        
    }
    
}
