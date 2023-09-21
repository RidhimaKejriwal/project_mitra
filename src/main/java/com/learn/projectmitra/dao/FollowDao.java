
package com.learn.projectmitra.dao;

import com.learn.projectmitra.entities.College;
import com.learn.projectmitra.entities.Follow;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class FollowDao {
    private SessionFactory factory;
    
    public FollowDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public Follow getFollowerBy_followedByandfollowedTo(String followedBy, String followedTo)
    {
        Follow follower = null;
        try
        {
            String query = "from Follow where followedBy =: by and followedTo =: to";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("by", followedBy);
            q.setParameter("to", followedTo);
            follower = (Follow) q.uniqueResult();
            session.close(); 
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return follower;
    }
    
    public boolean saveFollower(Follow follower)
    {
        boolean f = false;
        try
        {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(follower);
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
    
    public void deleteFollower(String follwedBy, String followedTo)
    {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        Query query = session.createQuery("delete from Follow where followedBy =: fb and followedTo =: ft");
        query.setParameter("fb", follwedBy);
        query.setParameter("ft", followedTo);
        int r = query.executeUpdate();
        System.out.println(r);
        tx.commit();
        session.close();
    }
    
    public List<Follow> getallFollowers(String followedTo)
    {
        List<Follow> list = null;
        try
        {
            String query = "from Follow where followedTo =: ft";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("ft", followedTo);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Follow> getallFollowing(String followedBy)
    {
        List<Follow> list = null;
        try
        {
            String query = "from Follow where followedBy =: fb";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("fb", followedBy);
            list = q.list();  
            session.close();   
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
}
