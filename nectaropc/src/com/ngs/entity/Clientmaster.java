package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Clientmaster entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@NamedQueries({@NamedQuery(name="RegistrationKey-Clientmaster.sql3",
		query="SELECT cm.locationId FROM Clientmaster cm WHERE cm.clientId= :clientid"),
		@NamedQuery(name="AddScheduleForm-Clientmaster.sql2",
		query="SELECT cm.clientId,cm.clientName,cm.availableSeats FROM Clientmaster cm"),
		@NamedQuery(name="NewScheduleManager-Clientmaster.sql1",
		query="select distinct c.clientName,c.clientId from Clientmaster c,Schedule s"+ 
		  " where c.clientId=s.clientId and c.clientId IN"+
		  " (SELECT distinct s1.clientId FROM Schedule s1"+
		  " where s1.scheduleDate>= CURRENT_DATE)")
		
			
		})

@Table(name = "ClientMaster", catalog = "nectar")
public class Clientmaster implements java.io.Serializable {

	// Fields

	private Integer clientId;
	private String clientCode;
	private String clientName;
	private String username;
	private String password;
	private String address;
	private String pincode;
	private Integer locationId;
	private String phone1;
	private String phone2;
	private String fax;
	private String email;
	private String url;
	private Integer availableSeats;
	private Integer clientType;

	// Constructors

	/** default constructor */
	public Clientmaster() {
	}

	/** full constructor */
	public Clientmaster(Integer clientId, String clientCode, String clientName,
			String username, String password, String address, String pincode,
			Integer locationId, String phone1, String phone2, String fax,
			String email, String url, Integer availableSeats, Integer clientType) {
		this.clientId = clientId;
		this.clientCode = clientCode;
		this.clientName = clientName;
		this.username = username;
		this.password = password;
		this.address = address;
		this.pincode = pincode;
		this.locationId = locationId;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.fax = fax;
		this.email = email;
		this.url = url;
		this.availableSeats = availableSeats;
		this.clientType = clientType;
	}

	// Property accessors
	@Id
	@JoinColumn(name = "ClientID", unique = true, nullable = false)
	public Integer getClientId() {
		return this.clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	@Column(name = "ClientCode", nullable = false, length = 4)
	public String getClientCode() {
		return this.clientCode;
	}

	public void setClientCode(String clientCode) {
		this.clientCode = clientCode;
	}

	@Column(name = "ClientName", nullable = false)
	public String getClientName() {
		return this.clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	@Column(name = "Username", nullable = false, length = 10)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "Password", nullable = false, length = 50)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "Address", nullable = false)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "Pincode", nullable = false, length = 6)
	public String getPincode() {
		return this.pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Column(name = "LocationID", nullable = false)
	public Integer getLocationId() {
		return this.locationId;
	}

	public void setLocationId(Integer locationId) {
		this.locationId = locationId;
	}

	@Column(name = "Phone1", nullable = false, length = 20)
	public String getPhone1() {
		return this.phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	@Column(name = "Phone2", nullable = false, length = 20)
	public String getPhone2() {
		return this.phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	@Column(name = "Fax", nullable = false, length = 20)
	public String getFax() {
		return this.fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	@Column(name = "Email", nullable = false, length = 50)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "Url", nullable = false)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "AvailableSeats", nullable = false)
	public Integer getAvailableSeats() {
		return this.availableSeats;
	}

	public void setAvailableSeats(Integer availableSeats) {
		this.availableSeats = availableSeats;
	}

	@Column(name = "ClientType", nullable = false)
	public Integer getClientType() {
		return this.clientType;
	}

	public void setClientType(Integer clientType) {
		this.clientType = clientType;
	}

}