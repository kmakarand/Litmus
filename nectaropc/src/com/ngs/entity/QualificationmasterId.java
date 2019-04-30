package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;


/**
 * QualificationmasterId entity. @author MyEclipse Persistence Tools
 */
@Embeddable

@NamedQueries({
	@NamedQuery(name="AddQualification-QualificationmasterId.sql1",query="select qmid.qualificationId," +
			"qmid.qualification from QualificationmasterId qmid")
	
	
	})

public class QualificationmasterId  implements java.io.Serializable {


    // Fields    

     private Integer qualificationId;
     private String qualification;


    // Constructors

    /** default constructor */
    public QualificationmasterId() {
    }

    
    /** full constructor */
    public QualificationmasterId(Integer qualificationId, String qualification) {
        this.qualificationId = qualificationId;
        this.qualification = qualification;
    }

   
    // Property accessors

    @Column(name="QualificationID", nullable=false)

    public Integer getQualificationId() {
        return this.qualificationId;
    }
    
    public void setQualificationId(Integer qualificationId) {
        this.qualificationId = qualificationId;
    }

    @Column(name="Qualification", nullable=false)

    public String getQualification() {
        return this.qualification;
    }
    
    public void setQualification(String qualification) {
        this.qualification = qualification;
    }
   



   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof QualificationmasterId) ) return false;
		 QualificationmasterId castOther = ( QualificationmasterId ) other; 
         
		 return ( (this.getQualificationId()==castOther.getQualificationId()) || ( this.getQualificationId()!=null && castOther.getQualificationId()!=null && this.getQualificationId().equals(castOther.getQualificationId()) ) )
 && ( (this.getQualification()==castOther.getQualification()) || ( this.getQualification()!=null && castOther.getQualification()!=null && this.getQualification().equals(castOther.getQualification()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getQualificationId() == null ? 0 : this.getQualificationId().hashCode() );
         result = 37 * result + ( getQualification() == null ? 0 : this.getQualification().hashCode() );
         return result;
   }   





}