package com.ngs.entity;

import java.util.List;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Addressdetails entity. @author MyEclipse Persistence Tools
 * @param <Cndmaster>
 * @param <objCndmaster>
 */
@Entity
@Table(name = "AddressDetails", catalog = "nectar")
public class Addressdetails implements java.io.Serializable {

	// Fields

	private Integer mailAddress;
	private String address;
	private String city;
	private Integer stateId;
	private Integer countryId;
	private String pincode;
	private String phone;
	private String fax;
	private String mobileNo;
	private Integer candidateId;
	private Integer typeOfAddress;
	
	//@ManyToOne
	//@JoinColumn(name="CandidateID")
	private Candidatemaster objCandidatemaster;

	// Constructors

	/** default constructor */
	public Addressdetails() {
	}

	/** minimal constructor */
	public Addressdetails(String address, String city,Integer stateId,
			Integer countryId,Integer candidateId, Integer typeOfAddress) {

		this.address = address;
		this.stateId = stateId;
		this.countryId = countryId;
		this.candidateId = candidateId;
		this.typeOfAddress = typeOfAddress;
		this.city = city;
	}

	/** full constructor */
	public Addressdetails(Integer candidateId, Integer typeOfAddress, Integer mailAddress,
			String address, String city, Integer stateId, Integer countryId, String pincode,
			String phone, String fax, String mobileNo) {
		this.candidateId = candidateId;
		this.typeOfAddress = typeOfAddress;
		this.mailAddress = mailAddress;
		this.address = address;
		this.city = city;
		this.stateId = stateId;
		this.countryId = countryId;
		this.pincode = pincode;
		this.phone = phone;
		this.fax = fax;
		this.mobileNo = mobileNo;
	}

	@Id
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

	@Column(name = "MailAddress")
	public Integer getMailAddress() {
		return this.mailAddress;
	}

	public void setMailAddress(Integer mailAddress) {
		this.mailAddress = mailAddress;
	}

	@Column(name = "Address", nullable = false)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Column(name = "City", nullable = false)
	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "StateID", nullable = false)
	public Integer getStateId() {
		return this.stateId;
	}

	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}

	@Column(name = "CountryID", nullable = false)
	public Integer getCountryId() {
		return this.countryId;
	}

	public void setCountryId(Integer countryId) {
		this.countryId = countryId;
	}

	@Column(name = "Pincode", length = 6)
	public String getPincode() {
		return this.pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Column(name = "Phone", length = 20)
	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "Fax", length = 20)
	public String getFax() {
		return this.fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	@Column(name = "MobileNo", length = 20)
	public String getMobileNo() {
		return this.mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

}