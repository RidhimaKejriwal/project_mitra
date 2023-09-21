
package com.learn.projectmitra.dao;

import com.learn.projectmitra.entities.LikebyCollege;
import com.learn.projectmitra.entities.LikebyStudent;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;


public class LikeDao {
    private SessionFactory factory;
    
    public LikeDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public boolean saveLikeByStudent(LikebyStudent like)
    {
        boolean f = false;
        try
        {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(like);
            tx.commit();
            session.close();
            f = true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            f = false;
        }
        return f;
    }
    
    public boolean saveLikeByCollege(LikebyCollege like)
    {
        boolean f = false;
        try
        {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(like);
            tx.commit();
            session.close();
            f = true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            f = false;
        }
        return f;
    }
    
    public boolean isLikedByStudent(int sid, int pid)
    {
        boolean f = false;
        LikebyStudent like = null;
        try
        {
            String query = "from LikebyStudent where studentId =: sid and ProjectId =: pid";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("sid", sid);
            q.setParameter("pid", pid);
            like = (LikebyStudent) q.uniqueResult();
            session.close(); 
            
            if(like!= null)
            {
                f = true;
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    
    public boolean isLikedByCollege(int cid, int pid)
    {
        boolean f = false;
        LikebyCollege like = null;
        try
        {
            String query = "from LikebyCollege where collegeId =: cid and projectId =: pid";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("cid", cid);
            q.setParameter("pid", pid);
            like = (LikebyCollege) q.uniqueResult();
            session.close(); 
            
            if(like!= null)
            {
                f = true;
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    
    public void deleteLike(int sid, int pid)
    {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        Query query = session.createQuery("delete from LikebyStudent where studentId =: sid and ProjectId =: pid");
        query.setParameter("sid", sid);
        query.setParameter("pid", pid);
        int r = query.executeUpdate();
        System.out.println(r);
        tx.commit();
        session.close();
    }
    
    public void deleteLikebyCollege(int cid, int pid)
    {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        Query query = session.createQuery("delete from LikebyCollege where collegeId =: cid and projectId =: pid");
        query.setParameter("cid", cid);
        query.setParameter("pid", pid);
        int r = query.executeUpdate();
        System.out.println(r);
        tx.commit();
        session.close();
    }
    
}
