package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * Countrymaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="CountryMaster"
    ,catalog="nectar"
)

public class Countrymaster  implements java.io.Serializable {


    // Fields    

     private String countryCode;
     private String name;


    // Constructors

    /** default constructor */
    public Countrymaster() {
    }

    
    /** full constructor */
    public Countrymaster(String countryCode, String name) {
        this.countryCode = countryCode;
        this.name = name;
    }

   
    // Property accessors
    @Id 
    
    @Column(name="CountryCode", unique=true, nullable=false, length=2)

    public String getCountryCode() {
        return this.countryCode;
    }
    
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
    
    @Column(name="Name", nullable=false, length=70)

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
   








}