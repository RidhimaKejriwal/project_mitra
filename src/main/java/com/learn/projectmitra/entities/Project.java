package com.learn.projectmitra.entities;

import java.sql.Timestamp;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Project {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int projectId;
    private String projectName;
    private int StudentId;
    private int collegeId;
    private int likes;
    private Timestamp submitDate;
    private String projectDescription;
    private String videolink;
    private String projectCategory;
    private String projectLanguage;
    private String projectImage1;
    private String projectImage2;
    private String projectReport;

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public int getStudentId() {
        return StudentId;
    }

    public void setStudentId(int StudentId) {
        this.StudentId = StudentId;
    }

    public int getCollegeId() {
        return collegeId;
    }

    public void setCollegeId(int collegeId) {
        this.collegeId = collegeId;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public Timestamp getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Timestamp submitDate) {
        this.submitDate = submitDate;
    }

    public String getProjectDescription() {
        return projectDescription;
    }

    public void setProjectDescription(String projectDescription) {
        this.projectDescription = projectDescription;
    }

    public String getVideolink() {
        return videolink;
    }

    public void setVideolink(String videolink) {
        this.videolink = videolink;
    }

    public String getProjectCategory() {
        return projectCategory;
    }

    public void setProjectCategory(String projectCategory) {
        this.projectCategory = projectCategory;
    }

    public String getProjectLanguage() {
        return projectLanguage;
    }

    public void setProjectLanguage(String projectLanguage) {
        this.projectLanguage = projectLanguage;
    }

    public String getProjectImage1() {
        return projectImage1;
    }

    public void setProjectImage1(String projectImage1) {
        this.projectImage1 = projectImage1;
    }

    public String getProjectImage2() {
        return projectImage2;
    }

    public void setProjectImage2(String projectImage2) {
        this.projectImage2 = projectImage2;
    }

    public String getProjectReport() {
        return projectReport;
    }

    public void setProjectReport(String projectReport) {
        this.projectReport = projectReport;
    }
    
    

    public Project() {
    }

    public Project(String projectName, int StudentId, int collegeId, String projectDescription, String videolink, String projectCategory, String projectLanguage) {
        this.projectName = projectName;
        this.StudentId = StudentId;
        this.collegeId = collegeId;
        this.projectDescription = projectDescription;
        this.videolink = videolink;
        this.projectCategory = projectCategory;
        this.projectLanguage = projectLanguage;
    }
    
    
}
