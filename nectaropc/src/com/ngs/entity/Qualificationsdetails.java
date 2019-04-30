package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;



/**
 * Qualificationsdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({
	@NamedQuery(name="AddQualification-Qualificationsdetails.sql2",query="SELECT qdid.qualificationId,qdid.qualification " +
			"FROM Qualificationsdetails qdid WHERE qdid.candidateId=:cid and qdid.qualificationId=:qid")
			})
@Table(name="QualificationsDetails"
    ,catalog="nectar"
)

public class Qualificationsdetails  implements java.io.Serializable {


    // Fields    

    private Integer candidateId;
    private String qualification;
    private Integer qualificationId;
    private String yearOfPassing;
    private String percent;
    private String university;


    /** default constructor */
    public Qualificationsdetails() {
    }

	/** minimal constructor */
    public Qualificationsdetails(Integer candidateId, Integer qualificationId, String yearOfPassing, String percent) {
        this.candidateId = candidateId;
        this.qualificationId = qualificationId;
        this.yearOfPassing = yearOfPassing;
        this.percent = percent;
    }
    
    /** full constructor */
    public Qualificationsdetails(Integer candidateId, String qualification, Integer qualificationId, String yearOfPassing, String percent, String university) {
        this.candidateId = candidateId;
        this.qualification = qualification;
        this.qualificationId = qualificationId;
        this.yearOfPassing = yearOfPassing;
        this.percent = percent;
        this.university = university;
    }

 // Property accessors

    @Id
    @Column(name="CandidateID", nullable=false)
    public Integer getCandidateId() {
        return this.candidateId;
    }
    
    public void setCandidateId(Integer candidateId) {
        this.candidateId = candidateId;
    }

    @Column(name="Qualification", length=25)

    public String getQualification() {
        return this.qualification;
    }
    
    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    @Column(name="QualificationID")

    public Integer getQualificationId() {
        return this.qualificationId;
    }
    
    public void setQualificationId(Integer qualificationId) {
        this.qualificationId = qualificationId;
    }

    @Column(name="YearOfPassing", nullable=false, length=4)

    public String getYearOfPassing() {
        return this.yearOfPassing;
    }
    
    public void setYearOfPassing(String yearOfPassing) {
        this.yearOfPassing = yearOfPassing;
    }

    @Column(name="Percent", nullable=false, length=5)

    public String getPercent() {
        return this.percent;
    }
    
    public void setPercent(String percent) {
        this.percent = percent;
    }

    @Column(name="University")

    public String getUniversity() {
        return this.university;
    }
    
    public void setUniversity(String university) {
        this.university = university;
    }
   
   








}