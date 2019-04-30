package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Registrationdetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({@NamedQuery(name="RegistrationKey-Registrationdetails.sql1",
		query="SELECT MAX(rd.serialNo) FROM Registrationdetails rd")
		
		
		})
@Table(name = "RegistrationDetails", catalog = "nectar")
public class Registrationdetails implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer clientId;
	private Integer locationId;
	private Integer serialNo;

	// Constructors

	/** default constructor */
	public Registrationdetails() {
	}

	/** full constructor */
	public Registrationdetails(Integer candidateId, Integer clientId,
			Integer locationId, Integer serialNo) {
		this.candidateId = candidateId;
		this.clientId = clientId;
		this.locationId = locationId;
		this.serialNo = serialNo;
	}

	// Property accessors
	@Id
	@Column(name = "CandidateID", unique = true, nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}

	@Column(name = "ClientID", nullable = false)
	public Integer getClientId() {
		return this.clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	@Column(name = "LocationID", nullable = false)
	public Integer getLocationId() {
		return this.locationId;
	}

	public void setLocationId(Integer locationId) {
		this.locationId = locationId;
	}

	@Column(name = "SerialNo", nullable = false)
	public Integer getSerialNo() {
		return this.serialNo;
	}

	public void setSerialNo(Integer serialNo) {
		this.serialNo = serialNo;
	}

}