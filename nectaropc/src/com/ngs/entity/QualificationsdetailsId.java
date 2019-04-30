package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;


/**
 * QualificationsdetailsId entity. @author MyEclipse Persistence Tools
 */
@Embeddable

@NamedQueries({
	@NamedQuery(name="AddQualification-Qualificationsdetails.sql2",query="SELECT qdid.qualificationId,qdid.qualification " +
			"FROM QualificationsdetailsId qdid WHERE qdid.candidateId=:cid and qdid.qualificationId=:qid")
			})

public class QualificationsdetailsId  implements java.io.Serializable {


    // Fields    

     private Integer candidateId;
     private String qualification;
     private Integer qualificationId;
     private String yearOfPassing;
     private String percent;
     private String university;


    // Constructors

    /** default constructor */
    public QualificationsdetailsId() {
    }

	/** minimal constructor */
    public QualificationsdetailsId(Integer candidateId, Integer qualificationId, String yearOfPassing, String percent) {
        this.candidateId = candidateId;
        this.qualificationId = qualificationId;
        this.yearOfPassing = yearOfPassing;
        this.percent = percent;
    }
    
    /** full constructor */
    public QualificationsdetailsId(Integer candidateId, String qualification, Integer qualificationId, String yearOfPassing, String percent, String university) {
        this.candidateId = candidateId;
        this.qualification = qualification;
        this.qualificationId = qualificationId;
        this.yearOfPassing = yearOfPassing;
        this.percent = percent;
        this.university = university;
    }

   
    // Property accessors

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

    @Column(name="QualificationID", nullable=false)

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
   



   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof QualificationsdetailsId) ) return false;
		 QualificationsdetailsId castOther = ( QualificationsdetailsId ) other; 
         
		 return ( (this.getCandidateId()==castOther.getCandidateId()) || ( this.getCandidateId()!=null && castOther.getCandidateId()!=null && this.getCandidateId().equals(castOther.getCandidateId()) ) )
 && ( (this.getQualification()==castOther.getQualification()) || ( this.getQualification()!=null && castOther.getQualification()!=null && this.getQualification().equals(castOther.getQualification()) ) )
 && ( (this.getQualificationId()==castOther.getQualificationId()) || ( this.getQualificationId()!=null && castOther.getQualificationId()!=null && this.getQualificationId().equals(castOther.getQualificationId()) ) )
 && ( (this.getYearOfPassing()==castOther.getYearOfPassing()) || ( this.getYearOfPassing()!=null && castOther.getYearOfPassing()!=null && this.getYearOfPassing().equals(castOther.getYearOfPassing()) ) )
 && ( (this.getPercent()==castOther.getPercent()) || ( this.getPercent()!=null && castOther.getPercent()!=null && this.getPercent().equals(castOther.getPercent()) ) )
 && ( (this.getUniversity()==castOther.getUniversity()) || ( this.getUniversity()!=null && castOther.getUniversity()!=null && this.getUniversity().equals(castOther.getUniversity()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getCandidateId() == null ? 0 : this.getCandidateId().hashCode() );
         result = 37 * result + ( getQualification() == null ? 0 : this.getQualification().hashCode() );
         result = 37 * result + ( getQualificationId() == null ? 0 : this.getQualificationId().hashCode() );
         result = 37 * result + ( getYearOfPassing() == null ? 0 : this.getYearOfPassing().hashCode() );
         result = 37 * result + ( getPercent() == null ? 0 : this.getPercent().hashCode() );
         result = 37 * result + ( getUniversity() == null ? 0 : this.getUniversity().hashCode() );
         return result;
   }   





}