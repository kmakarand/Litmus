package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

/**
 * AddressdetailsId entity. @author MyEclipse Persistence Tools
 */
@Embeddable
@NamedQueries({@NamedQuery(name="AddressManager-AddressdetailsId.sql2",
		query="SELECT a.candidateId,a.typeOfAddress FROM AddressdetailsId a WHERE a.candidateId=:cid and a.typeOfAddress=:typeofadd")
		
		})
public class AddressdetailsId implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer typeOfAddress;

	// Constructors

	/** default constructor */
	public AddressdetailsId() {
	}

	/** full constructor */
	public AddressdetailsId(Integer candidateId, Integer typeOfAddress) {
		this.candidateId = candidateId;
		this.typeOfAddress = typeOfAddress;
	}

	// Property accessors

	@Column(name = "CandidateID", nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}

	@Column(name = "TypeOfAddress", nullable = false)
	public Integer getTypeOfAddress() {
		return this.typeOfAddress;
	}

	public void setTypeOfAddress(Integer typeOfAddress) {
		this.typeOfAddress = typeOfAddress;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof AddressdetailsId))
			return false;
		AddressdetailsId castOther = (AddressdetailsId) other;

		return ((this.getCandidateId() == castOther.getCandidateId()) || (this
				.getCandidateId() != null
				&& castOther.getCandidateId() != null && this.getCandidateId()
				.equals(castOther.getCandidateId())))
				&& ((this.getTypeOfAddress() == castOther.getTypeOfAddress()) || (this
						.getTypeOfAddress() != null
						&& castOther.getTypeOfAddress() != null && this
						.getTypeOfAddress()
						.equals(castOther.getTypeOfAddress())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getCandidateId() == null ? 0 : this.getCandidateId()
						.hashCode());
		result = 37
				* result
				+ (getTypeOfAddress() == null ? 0 : this.getTypeOfAddress()
						.hashCode());
		return result;
	}

}