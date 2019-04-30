package com.ngs.entity;
// default package

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Slotregisteration entity. @author MyEclipse Persistence Tools
 */
@Entity

@NamedQueries({@NamedQuery(name="SlotRegistration-Slotregisteration.sql1",
		query="SELECT count(sr.scheduleId) FROM Slotregisteration sr WHERE sr.scheduleId=?1")
		})
		
@Table(name = "SlotRegisteration", catalog = "nectar")
public class Slotregisteration implements java.io.Serializable {

	// Fields

	private Integer scheduleId;
	private Integer candidateId;
	private Integer attended;

	// Constructors

	/** default constructor */
	public Slotregisteration() {
	}

	/** full constructor */
	public Slotregisteration(Integer scheduleId, Integer candidateId, Integer attended) {
		this.scheduleId = scheduleId;
		this.candidateId = candidateId;
		this.attended = attended;
	}


	// Property accessors
	@Id
	@Column(name = "ScheduleID", nullable = false)
	public Integer getScheduleId() {
		return this.scheduleId;
	}

	public void setScheduleId(Integer scheduleId) {
		this.scheduleId = scheduleId;
	}

	@Column(name = "CandidateID", nullable = false)
	public Integer getCandidateId() {
		return this.candidateId;
	}

	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}
	
	@Column(name = "Attended", nullable = false)
	public Integer getAttended() {
		return this.attended;
	}

	public void setAttended(Integer attended) {
		this.attended = attended;
	}
	

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Slotregisteration))
			return false;
		Slotregisteration castOther = (Slotregisteration) other;

		return ((this.getScheduleId() == castOther.getScheduleId()) || (this
				.getScheduleId() != null
				&& castOther.getScheduleId() != null && this.getScheduleId()
				.equals(castOther.getScheduleId())))
				&& ((this.getCandidateId() == castOther.getCandidateId()) || (this
						.getCandidateId() != null
						&& castOther.getCandidateId() != null && this
						.getCandidateId().equals(castOther.getCandidateId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getScheduleId() == null ? 0 : this.getScheduleId()
						.hashCode());
		result = 37
				* result
				+ (getCandidateId() == null ? 0 : this.getCandidateId()
						.hashCode());
		return result;
	}

}