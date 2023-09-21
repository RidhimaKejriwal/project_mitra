
package com.learn.projectmitra.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class College {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int collegeId;
    private String collegeName;
    private String collegeEmail;
    private int collegeRank;
    private String collegeImage;
    private String collegeAddress;
    private String userName;
    private String weblink;
    private int projects;
    private int followers;
    private int following;
    private String password;
    private String verifyCode;

    public int getCollegeId() {
        return collegeId;
    }

    public void setCollegeId(int collegeId) {
        this.collegeId = collegeId;
    }

    public String getCollegeName() {
        return collegeName;
    }

    public void setCollegeName(String collegeName) {
        this.collegeName = collegeName;
    }

    public String getCollegeEmail() {
        return collegeEmail;
    }

    public void setCollegeEmail(String collegeEmail) {
        this.collegeEmail = collegeEmail;
    }

    public int getCollegeRank() {
        return collegeRank;
    }

    public void setCollegeRank(int collegeRank) {
        this.collegeRank = collegeRank;
    }

    public String getCollegeImage() {
        return collegeImage;
    }

    public void setCollegeImage(String collegeImage) {
        this.collegeImage = collegeImage;
    }

    public String getCollegeAddress() {
        return collegeAddress;
    }

    public void setCollegeAddress(String collegeAddress) {
        this.collegeAddress = collegeAddress;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getWeblink() {
        return weblink;
    }

    public void setWeblink(String weblink) {
        this.weblink = weblink;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getFollowers() {
        return followers;
    }

    public void setFollowers(int followers) {
        this.followers = followers;
    }

    public int getFollowing() {
        return following;
    }

    public void setFollowing(int following) {
        this.following = following;
    }

    public int getProjects() {
        return projects;
    }

    public void setProjects(int projects) {
        this.projects = projects;
    }

    public String getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode;
    }

    public College() {
    }

    public College(String collegeName, String collegeEmail, String collegeImage, String collegeAddress, String userName, String weblink, String password, String verifyCode) {
        this.collegeName = collegeName;
        this.collegeEmail = collegeEmail;
        this.collegeImage = collegeImage;
        this.collegeAddress = collegeAddress;
        this.userName = userName;
        this.weblink = weblink;
        this.password = password;
        this.verifyCode = verifyCode;
    }
    
    
}
