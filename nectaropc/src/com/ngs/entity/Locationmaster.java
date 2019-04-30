package com.ngs.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Locationmaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({@NamedQuery(name="RegistrationKey-Locationmaster.sql4",
		query="SELECT lm FROM Locationmaster lm WHERE lm.locationId=:lid"),
		@NamedQuery(name="RegistrationKey-Locationmaster.sql5",
				query="SELECT lm FROM Locationmaster lm WHERE lm.locationId=?1 and lm.areaId=?2"),
		@NamedQuery(name="RegistrationKey-Locationmaster.sql6",
				query="SELECT lm FROM Locationmaster lm WHERE lm.countryId=?1 and lm.cityId=?2 and lm.areaId=0"),
		@NamedQuery(name="RegistrationKey-Locationmaster.sql11",
				query="SELECT lm.code FROM Locationmaster lm WHERE lm.locationId=?1 and lm.areaId=?2"),	
		@NamedQuery(name="RegistrationKey-Locationmaster.sql12",
				query="SELECT lm.code,lm.countryId FROM Locationmaster lm WHERE lm.countryId=?1 and lm.cityId=?2 and lm.stateId=?3 and lm.areaId=0"),
		@NamedQuery(name="AddressManager-Locationmaster.sql2",
				query="SELECT lm.locationId,lm.locationName from Locationmaster lm WHERE lm.cityId>=1 and lm.areaId=0"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster1.sql1",
				query="select distinct lm.countryId,lm.locationId,lm.stateId,lm.cityId,lm.areaId,lm.locationName from Locationmaster lm where lm.stateId != 0 and lm.cityId != 0 and lm.areaId!=0 GROUP BY lm.countryId,lm.locationId,lm.stateId,lm.cityId,lm.areaId,lm.locationName ORDER BY lm.locationName"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster1.sql2",
				query="select distinct lm.countryId,lm.areaId,lm.locationName from Locationmaster lm where lm.areaId >0 GROUP BY lm.countryId,lm.areaId,lm.locationName ORDER BY lm.locationName"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster1.sql3",
				query="select distinct lm.countryId,lm.locationId,lm.locationName FROM Locationmaster lm where lm.stateId >0 GROUP BY lm.countryId,lm.locationId,lm.locationName ORDER BY lm.locationName"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster1.sql4",
				query="select distinct lm.countryId,lm.locationId,lm.locationName from Locationmaster lm GROUP BY lm.countryId,lm.locationId,lm.locationName ORDER BY lm.locationName"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster.sql1",
				query="SELECT lm.countryId FROM Locationmaster lm WHERE lm.locationId=?1"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster.sql2",
				query="SELECT lm.stateId FROM Locationmaster lm WHERE lm.locationId=?1 and lm.countryId=?2"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster.sql3",
				query="SELECT lm.cityId FROM Locationmaster lm WHERE lm.locationId=?1 and lm.countryId=?2 and lm.stateId=?3"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster.sql4",
				query="SELECT lm.areaId FROM Locationmaster lm WHERE lm.locationId=?1 and lm.countryId=?2 and lm.stateId=?3 and lm.cityId=?4"),
		@NamedQuery(name="ClientRegistrationForm-Locationmaster.sql5",
				query="SELECT lm.locationId FROM Locationmaster lm WHERE lm.countryId=?1 and lm.stateId=?2 and lm.cityId=?3 and lm.areaId=?4")
				
				

		})
@Table(name = "LocationMaster", catalog = "nectar")
public class Locationmaster implements java.io.Serializable {

	// Fields

	private Integer locationId;
	private Integer countryId;
	private Integer stateId;
	private Integer cityId;
	private Integer areaId;
	private String code;
	private String locationName;

	// Constructors

	/** default constructor */
	public Locationmaster() {
	}

	/** minimal constructor */
	public Locationmaster(Integer locationId, Integer countryId,
			Integer stateId, Integer cityId, Integer areaId, String locationName) {
		this.locationId = locationId;
		this.countryId = countryId;
		this.stateId = stateId;
		this.cityId = cityId;
		this.areaId = areaId;
		this.locationName = locationName;
	}

	/** full constructor */
	public Locationmaster(Integer locationId, Integer countryId,
			Integer stateId, Integer cityId, Integer areaId, String code,
			String locationName) {
		this.locationId = locationId;
		this.countryId = countryId;
		this.stateId = stateId;
		this.cityId = cityId;
		this.areaId = areaId;
		this.code = code;
		this.locationName = locationName;
	}

	// Property accessors
	@Id
	@Column(name = "LocationID", unique = true, nullable = false)
	public Integer getLocationId() {
		return this.locationId;
	}

	public void setLocationId(Integer locationId) {
		this.locationId = locationId;
	}

	@Column(name = "CountryID", nullable = false)
	public Integer getCountryId() {
		return this.countryId;
	}

	public void setCountryId(Integer countryId) {
		this.countryId = countryId;
	}

	@Column(name = "StateID", nullable = false)
	public Integer getStateId() {
		return this.stateId;
	}

	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}

	@Column(name = "CityID", nullable = false)
	public Integer getCityId() {
		return this.cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

	@Column(name = "AreaID", nullable = false)
	public Integer getAreaId() {
		return this.areaId;
	}

	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}

	@Column(name = "Code", length = 5)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "LocationName", nullable = false, length = 30)
	public String getLocationName() {
		return this.locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

}