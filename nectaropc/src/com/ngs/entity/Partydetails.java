package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Partydetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "PartyDetails", catalog = "nectar")
public class Partydetails implements java.io.Serializable {

	// Fields

	private Integer partyId;
	private String party;
	private String contact;
	private String address;
	private String street;
	private String area;
	private String city;
	private String pincode;
	private String state;
	private String country;
	private String phone1;
	private String phone2;
	private String fax;
	private String email;
	private String url;

	// Constructors

	/** default constructor */
	public Partydetails() {
	}

	/** minimal constructor */
	public Partydetails(String party, String contact, String address,
			String street, String city, String pincode, String state,
			String country, String phone1, String email) {
		this.party = party;
		this.contact = contact;
		this.address = address;
		this.street = street;
		this.city = city;
		this.pincode = pincode;
		this.state = state;
		this.country = country;
		this.phone1 = phone1;
		this.email = email;
	}

	/** full constructor */
	public Partydetails(String party, String contact, String address,
			String street, String area, String city, String pincode,
			String state, String country, String phone1, String phone2,
			String fax, String email, String url) {
		this.party = party;
		this.contact = contact;
		this.address = address;
		this.street = street;
		this.area = area;
		this.city = city;
		this.pincode = pincode;
		this.state = state;
		this.country = country;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.fax = fax;
		this.email = email;
		this.url = url;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "PartyID", unique = true, nullable = false)
	public Integer getPartyId() {
		return this.partyId;
	}

	public void setPartyId(Integer partyId) {
		this.partyId = partyId;
	}

	@Column(name = "Party", nullable = false, length = 100)
	public String getParty() {
		return this.party;
	}

	public void setParty(String party) {
		this.party = party;
	}

	@Column(name = "Contact", nullable = false, length = 35)
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Column(name = "Address", nullable = false, length = 50)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "Street", nullable = false, length = 50)
	public String getStreet() {
		return this.street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	@Column(name = "Area", length = 50)
	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Column(name = "City", nullable = false, length = 20)
	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "Pincode", nullable = false, length = 6)
	public String getPincode() {
		return this.pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Column(name = "State", nullable = false, length = 20)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "Country", nullable = false, length = 25)
	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	@Column(name = "Phone1", nullable = false, length = 16)
	public String getPhone1() {
		return this.phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	@Column(name = "Phone2", length = 16)
	public String getPhone2() {
		return this.phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	@Column(name = "Fax", length = 16)
	public String getFax() {
		return this.fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	@Column(name = "Email", nullable = false, length = 45)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "Url", length = 100)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}