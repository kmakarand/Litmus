package com.ngs.entity;

import java.sql.Time;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * Newperformancemaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({
	
	@NamedQuery(name="Analysis-Newperformancemaster.sql5",
	query="SELECT npm.attemptNo from Newperformancemaster npm where npm.candidateId=?1 and " +
			"npm.examId=?2 and npm.sectionId=?3"),
	@NamedQuery(name="Analysis-Newperformancemaster.sql6",
	query="SELECT npm from Newperformancemaster npm where npm.candidateId" +
			" =?1 and npm.sectionId=?2 and npm.examId=?3 and npm.attemptNo>=1"),//  " +
			//"group by npm.sectionId,npm.examId,npm.candidateId order by npm.examId,npm.attemptNo"),
	@NamedQuery(name="Analysis-Newperformancemaster.sql16",
	query="SELECT SUM(npm.totalQuestions) FROM Newperformancemaster npm WHERE "+
				"npm.candidateId=?1 and npm.examId=?2"),
	@NamedQuery(name="Analysis-Newperformancemaster.sql17",
	query="SELECT sum(npm.noOfWrong) FROM Newperformancemaster npm WHERE "+
				"npm.candidateId=?1 and npm.examId=?2"),
	@NamedQuery(name="Analysis-Newperformancemaster.sql18",
	query="SELECT sum(npm.noOfCorrect) FROM Newperformancemaster npm WHERE "+
				"npm.candidateId=?1 and npm.examId=?2"),
	@NamedQuery(name="Analysis-Newperformancemaster.sql19",
	query="SELECT sum(npm.score) FROM Newperformancemaster npm WHERE "+
				"npm.candidateId=?1 and npm.examId=?2"),
	@NamedQuery(name="CandiadateList-Newperformancemaster.sql1",
	query="Select nxd.noOfQuestions,nxd.levelId from Newexamdetails nxd where nxd.examId=?1"),
	@NamedQuery(name="CandiadateList-Newperformancemaster.sql2",
	query="SELECT npm.result FROM Newperformancemaster npm"+
	" WHERE npm.examId=?1 AND npm.sectionId=?2 AND npm.candidateId=?3")
				
				
				
				
	})

/*@NamedNativeQuery(name="Analysis-Newperformancemaster.sql7",query="SELECT sum(TotalQuestions) as TotalQuestions,sum(NoOfWrong) as NoOfWrong,"+
				"sum(NoOfCorrect) as NoOfCorrect,sum(Score) as Score FROM NewPerformanceMaster WHERE "+
				"CandidateID=:cid and ExamID=:examid group by SectionID")*/


@Table(name="NewPerformanceMaster"
    ,catalog="nectar"
)

public class Newperformancemaster  implements java.io.Serializable {


    // Fields    

     private Integer historyId;
     private Integer candidateId;
     private Integer sectionId;
     private Integer codeGroupId;
     private Integer examId;
     private Date date;
     private Time time;
     private Integer totalQuestions;
     private Integer noOfWrong;
     private Integer noOfCorrect;
     private Float score;
     private Integer result;
     private Integer attemptNo;


    // Constructors

    /** default constructor */
    public Newperformancemaster() {
    }

	/** minimal constructor */
    public Newperformancemaster(Integer candidateId, Integer sectionId, Integer codeGroupId, Integer examId, Date date, Time time, Integer totalQuestions, Integer noOfWrong, Integer noOfCorrect, Float score, Integer result) {
        this.candidateId = candidateId;
        this.sectionId = sectionId;
        this.codeGroupId = codeGroupId;
        this.examId = examId;
        this.date = date;
        this.time = time;
        this.totalQuestions = totalQuestions;
        this.noOfWrong = noOfWrong;
        this.noOfCorrect = noOfCorrect;
        this.score = score;
        this.result = result;
    }
    
    /** full constructor */
    public Newperformancemaster(Integer candidateId, Integer sectionId, Integer codeGroupId, Integer examId, Date date, Time time, Integer totalQuestions, Integer noOfWrong, Integer noOfCorrect, Float score, Integer result, Integer attemptNo) {
        this.candidateId = candidateId;
        this.sectionId = sectionId;
        this.codeGroupId = codeGroupId;
        this.examId = examId;
        this.date = date;
        this.time = time;
        this.totalQuestions = totalQuestions;
        this.noOfWrong = noOfWrong;
        this.noOfCorrect = noOfCorrect;
        this.score = score;
        this.result = result;
        this.attemptNo = attemptNo;
    }

   
    // Property accessors
    @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="HistoryID", unique=true, nullable=false)

    public Integer getHistoryId() {
        return this.historyId;
    }
    
    public void setHistoryId(Integer historyId) {
        this.historyId = historyId;
    }
    
    @Column(name="CandidateID", nullable=false)

    public Integer getCandidateId() {
        return this.candidateId;
    }
    
    public void setCandidateId(Integer candidateId) {
        this.candidateId = candidateId;
    }
    
    @Column(name="SectionID", nullable=false)

    public Integer getSectionId() {
        return this.sectionId;
    }
    
    public void setSectionId(Integer sectionId) {
        this.sectionId = sectionId;
    }
    
    @Column(name="CodeGroupID", nullable=false)

    public Integer getCodeGroupId() {
        return this.codeGroupId;
    }
    
    public void setCodeGroupId(Integer codeGroupId) {
        this.codeGroupId = codeGroupId;
    }
    
    @Column(name="ExamID", nullable=false)

    public Integer getExamId() {
        return this.examId;
    }
    
    public void setExamId(Integer examId) {
        this.examId = examId;
    }
    @Temporal(TemporalType.DATE)
    @Column(name="Date", nullable=false, length=10)

    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    @Column(name="Time", nullable=false, length=8)

    public Time getTime() {
        return this.time;
    }
    
    public void setTime(Time time) {
        this.time = time;
    }
    
    @Column(name="TotalQuestions", nullable=false)

    public Integer getTotalQuestions() {
        return this.totalQuestions;
    }
    
    public void setTotalQuestions(Integer totalQuestions) {
        this.totalQuestions = totalQuestions;
    }
    
    @Column(name="NoOfWrong", nullable=false)

    public Integer getNoOfWrong() {
        return this.noOfWrong;
    }
    
    public void setNoOfWrong(Integer noOfWrong) {
        this.noOfWrong = noOfWrong;
    }
    
    @Column(name="NoOfCorrect", nullable=false)

    public Integer getNoOfCorrect() {
        return this.noOfCorrect;
    }
    
    public void setNoOfCorrect(Integer noOfCorrect) {
        this.noOfCorrect = noOfCorrect;
    }
    
    @Column(name="Score", nullable=false, precision=4)

    public Float getScore() {
        return this.score;
    }
    
    public void setScore(Float score) {
        this.score = score;
    }
    
    @Column(name="Result", nullable=false)

    public Integer getResult() {
        return this.result;
    }
    
    public void setResult(Integer result) {
        this.result = result;
    }
    
    @Column(name="AttemptNo")

    public Integer getAttemptNo() {
        return this.attemptNo;
    }
    
    public void setAttemptNo(Integer attemptNo) {
        this.attemptNo = attemptNo;
    }
   








}