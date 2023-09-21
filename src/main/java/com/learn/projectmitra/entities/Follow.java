
package com.learn.projectmitra.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Follow {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int followId;
    private String followedBy;
    private String followedTo;
    private String followedBy_entity;
    private String followedTo_entity;

    public int getFollowId() {
        return followId;
    }

    public void setFollowId(int followId) {
        this.followId = followId;
    }

    public String getFollowedBy() {
        return followedBy;
    }

    public void setFollowedBy(String followedBy) {
        this.followedBy = followedBy;
    }

    public String getFollowedTo() {
        return followedTo;
    }

    public void setFollowedTo(String followedTo) {
        this.followedTo = followedTo;
    }

    public String getFollowedBy_entity() {
        return followedBy_entity;
    }

    public void setFollowedBy_entity(String followedBy_entity) {
        this.followedBy_entity = followedBy_entity;
    }

    public String getFollowedTo_entity() {
        return followedTo_entity;
    }

    public void setFollowedTo_entity(String followedTo_entity) {
        this.followedTo_entity = followedTo_entity;
    }

    public Follow() {
    }

    public Follow(String followedBy, String followedTo) {
        this.followedBy = followedBy;
        this.followedTo = followedTo;
    }

    public Follow(String followedBy, String followedTo, String followedBy_entity, String followedTo_entity) {
        this.followedBy = followedBy;
        this.followedTo = followedTo;
        this.followedBy_entity = followedBy_entity;
        this.followedTo_entity = followedTo_entity;
    }
    
    
}
