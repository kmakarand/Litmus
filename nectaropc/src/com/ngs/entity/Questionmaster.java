package com.ngs.entity;

import java.sql.Timestamp;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * Questionmaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="QuestionMaster"
    ,catalog="nectar"
)

public class Questionmaster  implements java.io.Serializable {


    // Fields    

     private Integer questionId;
     private String codeId;
     private Integer partyId;
     private String question;
     private Short examType;
     private Integer noOfOptions;
     private String option1;
     private String option2;
     private String option3;
     private String option4;
     private String option5;
     private Integer answer;
     private String newAnswer;
     private String explanation;
     private Integer levelId;
     private Integer examId;
     private Timestamp insertionDate;
     private Date updateValidityDate;
     private Short status;
     private Integer image;
     private Short resonableTime;
     private Short marks;
     private String rrn;


    // Constructors

    /** default constructor */
    public Questionmaster() {
    }

	/** minimal constructor */
    public Questionmaster(Integer questionId, String codeId, String question, Integer noOfOptions, Integer answer, String newAnswer, Integer examId, Timestamp insertionDate, Short marks, String rrn) {
        this.questionId = questionId;
        this.codeId = codeId;
        this.question = question;
        this.noOfOptions = noOfOptions;
        this.answer = answer;
        this.newAnswer = newAnswer;
        this.examId = examId;
        this.insertionDate = insertionDate;
        this.marks = marks;
        this.rrn = rrn;
    }
    
    /** full constructor */
    public Questionmaster(Integer questionId, String codeId, Integer partyId, String question, Short examType, Integer noOfOptions, String option1, String option2, String option3, String option4, String option5, Integer answer, String newAnswer, String explanation, Integer levelId, Integer examId, Timestamp insertionDate, Date updateValidityDate, Short status, Integer image, Short resonableTime, Short marks, String rrn) {
        this.questionId = questionId;
        this.codeId = codeId;
        this.partyId = partyId;
        this.question = question;
        this.examType = examType;
        this.noOfOptions = noOfOptions;
        this.option1 = option1;
        this.option2 = option2;
        this.option3 = option3;
        this.option4 = option4;
        this.option5 = option5;
        this.answer = answer;
        this.newAnswer = newAnswer;
        this.explanation = explanation;
        this.levelId = levelId;
        this.examId = examId;
        this.insertionDate = insertionDate;
        this.updateValidityDate = updateValidityDate;
        this.status = status;
        this.image = image;
        this.resonableTime = resonableTime;
        this.marks = marks;
        this.rrn = rrn;
    }

   
    // Property accessors
    @Id 
    
    @Column(name="QuestionID", unique=true, nullable=false)

    public Integer getQuestionId() {
        return this.questionId;
    }
    
    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }
    
    @Column(name="CodeID", nullable=false, length=8)

    public String getCodeId() {
        return this.codeId;
    }
    
    public void setCodeId(String codeId) {
        this.codeId = codeId;
    }
    
    @Column(name="PartyID")

    public Integer getPartyId() {
        return this.partyId;
    }
    
    public void setPartyId(Integer partyId) {
        this.partyId = partyId;
    }
    
    @Column(name="Question", nullable=false, length=65535)

    public String getQuestion() {
        return this.question;
    }
    
    public void setQuestion(String question) {
        this.question = question;
    }
    
    @Column(name="ExamType")

    public Short getExamType() {
        return this.examType;
    }
    
    public void setExamType(Short examType) {
        this.examType = examType;
    }
    
    @Column(name="NoOfOptions", nullable=false)

    public Integer getNoOfOptions() {
        return this.noOfOptions;
    }
    
    public void setNoOfOptions(Integer noOfOptions) {
        this.noOfOptions = noOfOptions;
    }
    
    @Column(name="Option1", length=65535)

    public String getOption1() {
        return this.option1;
    }
    
    public void setOption1(String option1) {
        this.option1 = option1;
    }
    
    @Column(name="Option2", length=65535)

    public String getOption2() {
        return this.option2;
    }
    
    public void setOption2(String option2) {
        this.option2 = option2;
    }
    
    @Column(name="Option3", length=65535)

    public String getOption3() {
        return this.option3;
    }
    
    public void setOption3(String option3) {
        this.option3 = option3;
    }
    
    @Column(name="Option4", length=65535)

    public String getOption4() {
        return this.option4;
    }
    
    public void setOption4(String option4) {
        this.option4 = option4;
    }
    
    @Column(name="Option5", length=65535)

    public String getOption5() {
        return this.option5;
    }
    
    public void setOption5(String option5) {
        this.option5 = option5;
    }
    
    @Column(name="Answer", nullable=false)

    public Integer getAnswer() {
        return this.answer;
    }
    
    public void setAnswer(Integer answer) {
        this.answer = answer;
    }
    
    @Column(name="NewAnswer", nullable=false, length=5)

    public String getNewAnswer() {
        return this.newAnswer;
    }
    
    public void setNewAnswer(String newAnswer) {
        this.newAnswer = newAnswer;
    }
    
    @Column(name="Explanation", length=65535)

    public String getExplanation() {
        return this.explanation;
    }
    
    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }
    
    @Column(name="LevelID")

    public Integer getLevelId() {
        return this.levelId;
    }
    
    public void setLevelId(Integer levelId) {
        this.levelId = levelId;
    }
    
    @Column(name="ExamID", nullable=false)

    public Integer getExamId() {
        return this.examId;
    }
    
    public void setExamId(Integer examId) {
        this.examId = examId;
    }
    
    @Column(name="InsertionDate", nullable=false, length=19)

    public Timestamp getInsertionDate() {
        return this.insertionDate;
    }
    
    public void setInsertionDate(Timestamp insertionDate) {
        this.insertionDate = insertionDate;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="UpdateValidityDate", length=10)

    public Date getUpdateValidityDate() {
        return this.updateValidityDate;
    }
    
    public void setUpdateValidityDate(Date updateValidityDate) {
        this.updateValidityDate = updateValidityDate;
    }
    
    @Column(name="Status")

    public Short getStatus() {
        return this.status;
    }
    
    public void setStatus(Short status) {
        this.status = status;
    }
    
    @Column(name="Image")

    public Integer getImage() {
        return this.image;
    }
    
    public void setImage(Integer image) {
        this.image = image;
    }
    
    @Column(name="ResonableTime")

    public Short getResonableTime() {
        return this.resonableTime;
    }
    
    public void setResonableTime(Short resonableTime) {
        this.resonableTime = resonableTime;
    }
    
    @Column(name="Marks", nullable=false)

    public Short getMarks() {
        return this.marks;
    }
    
    public void setMarks(Short marks) {
        this.marks = marks;
    }
    
    @Column(name="RRN", nullable=false, length=65535)

    public String getRrn() {
        return this.rrn;
    }
    
    public void setRrn(String rrn) {
        this.rrn = rrn;
    }
   








}