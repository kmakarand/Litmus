package com.ngs.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;



/**
 * Qualificationmaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="QualificationMaster"
    ,catalog="nectar"
)

public class Qualificationmaster  implements java.io.Serializable {


    // Fields    

     private QualificationmasterId id;


    // Constructors

    /** default constructor */
    public Qualificationmaster() {
    }

    
    /** full constructor */
    public Qualificationmaster(QualificationmasterId id) {
        this.id = id;
    }

   
    // Property accessors
    @EmbeddedId
    
    @AttributeOverrides( {
        @AttributeOverride(name="qualificationId", column=@Column(name="QualificationID", nullable=false) ), 
        @AttributeOverride(name="qualification", column=@Column(name="Qualification", nullable=false) ) } )

    public QualificationmasterId getId() {
        return this.id;
    }
    
    public void setId(QualificationmasterId id) {
        this.id = id;
    }
   








}