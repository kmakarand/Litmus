package com.ngs.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * Exammaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="ExamMaster"
    ,catalog="nectar"
)

public class Exammaster  implements java.io.Serializable {


    // Fields    

     private Integer examId;
     private Integer moderatorId;
     private String exam;
     private Integer examMode;
     private Date startDate;
     private Date endDate;
     private String conductedBy;
     private String centre;
     private String country;
     private Integer frequency;
     private Integer showResults;
     private Integer displayTests;
     private Float registrationFee;


    // Constructors

    /** default constructor */
    public Exammaster() {
    }

	/** minimal constructor */
    public Exammaster(Integer moderatorId, String exam, Integer examMode, Date startDate, Date endDate, Integer showResults, Integer displayTests, Float registrationFee) {
        this.moderatorId = moderatorId;
        this.exam = exam;
        this.examMode = examMode;
        this.startDate = startDate;
        this.endDate = endDate;
        this.showResults = showResults;
        this.displayTests = displayTests;
        this.registrationFee = registrationFee;
    }
    
    /** full constructor */
    public Exammaster(Integer moderatorId, String exam, Integer examMode, Date startDate, Date endDate, String conductedBy, String centre, String country, Integer frequency, Integer showResults, Integer displayTests, Float registrationFee) {
        this.moderatorId = moderatorId;
        this.exam = exam;
        this.examMode = examMode;
        this.startDate = startDate;
        this.endDate = endDate;
        this.conductedBy = conductedBy;
        this.centre = centre;
        this.country = country;
        this.frequency = frequency;
        this.showResults = showResults;
        this.displayTests = displayTests;
        this.registrationFee = registrationFee;
    }

   
    // Property accessors
    @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="ExamID", unique=true, nullable=false)

    public Integer getExamId() {
        return this.examId;
    }
    
    public void setExamId(Integer examId) {
        this.examId = examId;
    }
    
    @Column(name="ModeratorID", nullable=false)

    public Integer getModeratorId() {
        return this.moderatorId;
    }
    
    public void setModeratorId(Integer moderatorId) {
        this.moderatorId = moderatorId;
    }
    
    @Column(name="Exam", nullable=false, length=50)

    public String getExam() {
        return this.exam;
    }
    
    public void setExam(String exam) {
        this.exam = exam;
    }
    
    @Column(name="ExamMode", nullable=false)

    public Integer getExamMode() {
        return this.examMode;
    }
    
    public void setExamMode(Integer examMode) {
        this.examMode = examMode;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="StartDate", nullable=false, length=10)

    public Date getStartDate() {
        return this.startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="EndDate", nullable=false, length=10)

    public Date getEndDate() {
        return this.endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    
    @Column(name="ConductedBy", length=250)

    public String getConductedBy() {
        return this.conductedBy;
    }
    
    public void setConductedBy(String conductedBy) {
        this.conductedBy = conductedBy;
    }
    
    @Column(name="Centre", length=250)

    public String getCentre() {
        return this.centre;
    }
    
    public void setCentre(String centre) {
        this.centre = centre;
    }
    
    @Column(name="Country", length=25)

    public String getCountry() {
        return this.country;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    
    @Column(name="Frequency")

    public Integer getFrequency() {
        return this.frequency;
    }
    
    public void setFrequency(Integer frequency) {
        this.frequency = frequency;
    }
    
    @Column(name="ShowResults", nullable=false)

    public Integer getShowResults() {
        return this.showResults;
    }
    
    public void setShowResults(Integer showResults) {
        this.showResults = showResults;
    }
    
    @Column(name="DisplayTests", nullable=false)

    public Integer getDisplayTests() {
        return this.displayTests;
    }
    
    public void setDisplayTests(Integer displayTests) {
        this.displayTests = displayTests;
    }
    
    @Column(name="RegistrationFee", nullable=false, precision=12, scale=0)

    public Float getRegistrationFee() {
        return this.registrationFee;
    }
    
    public void setRegistrationFee(Float registrationFee) {
        this.registrationFee = registrationFee;
    }
   








}