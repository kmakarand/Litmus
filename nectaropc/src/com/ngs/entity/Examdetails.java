package com.ngs.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * Examdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="ExamDetails"
    ,catalog="nectar"
)

public class Examdetails  implements java.io.Serializable {


    // Fields    

     private Integer candidateId;
     private Integer clientId;
     private Date examDate;


    // Constructors

    /** default constructor */
    public Examdetails() {
    }

    
    /** full constructor */
    public Examdetails(Integer candidateId, Integer clientId, Date examDate) {
        this.candidateId = candidateId;
        this.clientId = clientId;
        this.examDate = examDate;
    }

   
    // Property accessors
    @Id 
    
    @Column(name="CandidateID", unique=true, nullable=false)

    public Integer getCandidateId() {
        return this.candidateId;
    }
    
    public void setCandidateId(Integer candidateId) {
        this.candidateId = candidateId;
    }
    
    @Column(name="ClientID", nullable=false)

    public Integer getClientId() {
        return this.clientId;
    }
    
    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="ExamDate", nullable=false, length=10)

    public Date getExamDate() {
        return this.examDate;
    }
    
    public void setExamDate(Date examDate) {
        this.examDate = examDate;
    }
   








}