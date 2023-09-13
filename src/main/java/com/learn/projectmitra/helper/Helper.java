package com.learn.projectmitra.helper;

import java.util.HashMap;
import java.util.Map;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class Helper {
    public static Map<String,Long> getCounts(SessionFactory factory)
    {
        Session session = factory.openSession();
        String q1 = "Select count(*) from Student";
        String q2 = "Select count(*) from College";
        String q3 = "Select count(*) from Project";
        
        Query query1 = session.createQuery(q1);
        Query query2 = session.createQuery(q2);
        Query query3 = session.createQuery(q3);
        
        Long studentCount = (Long) query1.list().get(0);
        Long collegeCount = (Long) query2.list().get(0);
        Long projectCount = (Long) query3.list().get(0);
        
        Map <String,Long> map = new HashMap<>();
        map.put("studentCount", studentCount);
        map.put("collegeCount", collegeCount);
        map.put("projectCount", projectCount);
        
        session.close();
        return map;
    }
}
