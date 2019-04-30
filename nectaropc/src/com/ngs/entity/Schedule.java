package com.ngs.entity;

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Schedule entity. @author MyEclipse Persistence Toolss
 */
@SuppressWarnings("serial")
@Entity
@NamedQueries({
	@NamedQuery(name="UserDetails-Schedule.sql1",
	query="SELECT s FROM Schedule s where s.clientId=?1 and s.scheduleDate >=CURRENT_DATE ORDER BY s.scheduleDate"),
	@NamedQuery(name="Userdetails-Schedule.sql2",
	query="SELECT s FROM Schedule s where s.scheduleDate=?1 and s.clientId =?2 ORDER BY s.scheduleDate"),
	@NamedQuery(name="AddScheduleForm-ScheduleId.sql1",
	query="SELECT max(s.scheduleId) from Schedule s"),
	@NamedQuery(name="AddScheduleForm-ScheduleId.sql4",
	query="SELECT s.noOfSeats,s.clientId FROM Schedule s where s.scheduleDate=?1 and s.clientId =?2"),
	@NamedQuery(name="AddScheduleForm-ScheduleId.sql5",
	query="SELECT s FROM Schedule s where s.scheduleDate=?1 and s.clientId =?2"),
	@NamedQuery(name="AddScheduleForm-ScheduleId.sql6",
	query="SELECT s FROM Schedule s where s.clientId= ?1"),
	@NamedQuery(name="NewScheduleManager-Schedule.sql2",
	query="SELECT distinct s.scheduleDate FROM Schedule s where s.scheduleDate>=CURRENT_DATE ORDER BY s.scheduleDate"),
	@NamedQuery(name="NewScheduleManager-Schedule.sql3",
	query="SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<?2" +
	  " ORDER BY s.scheduleDate"),
	@NamedQuery(name="NewScheduleManager-Schedule.sql4",
	query="SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and  s.scheduleDate<?2 and s.clientId = ?3 ORDER BY s.scheduleDate"),
	@NamedQuery(name="SlotManager-Schedule.sql1",
	query="SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<?2"+
		  " ORDER BY s.scheduleDate, s.timeFrom, s.timeTo"),
	@NamedQuery(name="SlotManager-Schedule.sql2",
	query="SELECT s FROM Schedule s WHERE s.scheduleDate>=?1 and s.scheduleDate<?2"+
			   " and s.clientId =?3 ORDER BY s.scheduleDate, s.timeFrom, s.timeTo")
	})
	
	


@Table(name = "Schedule", catalog = "nectar")
public class Schedule implements java.io.Serializable {

	private Integer scheduleId;
	private Integer clientId;
	private Integer examId;
	private Integer sectionId;
	private Date scheduleDate;
	private String timeFrom;
	private String timeTo;
	private Integer noOfSeats;
	
	


	// Constructors

	/** default constructor */
	public Schedule() {
	}

	/** full constructor */
	public Schedule(Integer scheduleId, Integer clientId, Integer examId,
			Integer sectionId, Date scheduleDate, String timeFrom,
			String timeTo, Integer noOfSeats) {
		this.scheduleId = scheduleId;
		this.clientId = clientId;
		this.examId = examId;
		this.sectionId = sectionId;
		this.scheduleDate = scheduleDate;
		this.timeFrom = timeFrom;
		this.timeTo = timeTo;
		this.noOfSeats = noOfSeats;
	}

	// Property accessors
	@Id
	@JoinColumn(name = "ScheduleID", nullable = false)
	public Integer getScheduleId() {
		return this.scheduleId;
	}

	public void setScheduleId(Integer scheduleId) {
		this.scheduleId = scheduleId;
	}

	@Column(name = "ClientID", nullable = false)
	public Integer getClientId() {
		return this.clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	@Column(name = "ExamID", nullable = false)
	public Integer getExamId() {
		return this.examId;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	@Column(name = "SectionID", nullable = false)
	public Integer getSectionId() {
		return this.sectionId;
	}

	public void setSectionId(Integer sectionId) {
		this.sectionId = sectionId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "ScheduleDate", nullable = false, length = 10)
	public Date getScheduleDate() {
		return this.scheduleDate;
	}

	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}

	@Column(name = "TimeFrom", nullable = false, length = 10)
	public String getTimeFrom() {
		return this.timeFrom;
	}

	public void setTimeFrom(String timeFrom) {
		this.timeFrom = timeFrom;
	}

	@Column(name = "TimeTo", nullable = false, length = 10)
	public String getTimeTo() {
		return this.timeTo;
	}

	public void setTimeTo(String timeTo) {
		this.timeTo = timeTo;
	}

	@Column(name = "NoOfSeats", nullable = false)
	public Integer getNoOfSeats() {
		return this.noOfSeats;
	}

	public void setNoOfSeats(Integer noOfSeats) {
		this.noOfSeats = noOfSeats;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Schedule))
			return false;
		Schedule castOther = (Schedule) other;

		return ((this.getScheduleId() == castOther.getScheduleId()) || (this
				.getScheduleId() != null
				&& castOther.getScheduleId() != null && this.getScheduleId()
				.equals(castOther.getScheduleId())))
				&& ((this.getClientId() == castOther.getClientId()) || (this
						.getClientId() != null
						&& castOther.getClientId() != null && this
						.getClientId().equals(castOther.getClientId())))
				&& ((this.getExamId() == castOther.getExamId()) || (this
						.getExamId() != null
						&& castOther.getExamId() != null && this.getExamId()
						.equals(castOther.getExamId())))
				&& ((this.getSectionId() == castOther.getSectionId()) || (this
						.getSectionId() != null
						&& castOther.getSectionId() != null && this
						.getSectionId().equals(castOther.getSectionId())))
				&& ((this.getScheduleDate() == castOther.getScheduleDate()) || (this
						.getScheduleDate() != null
						&& castOther.getScheduleDate() != null && this
						.getScheduleDate().equals(castOther.getScheduleDate())))
				&& ((this.getTimeFrom() == castOther.getTimeFrom()) || (this
						.getTimeFrom() != null
						&& castOther.getTimeFrom() != null && this
						.getTimeFrom().equals(castOther.getTimeFrom())))
				&& ((this.getTimeTo() == castOther.getTimeTo()) || (this
						.getTimeTo() != null
						&& castOther.getTimeTo() != null && this.getTimeTo()
						.equals(castOther.getTimeTo())))
				&& ((this.getNoOfSeats() == castOther.getNoOfSeats()) || (this
						.getNoOfSeats() != null
						&& castOther.getNoOfSeats() != null && this
						.getNoOfSeats().equals(castOther.getNoOfSeats())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getScheduleId() == null ? 0 : this.getScheduleId()
						.hashCode());
		result = 37 * result
				+ (getClientId() == null ? 0 : this.getClientId().hashCode());
		result = 37 * result
				+ (getExamId() == null ? 0 : this.getExamId().hashCode());
		result = 37 * result
				+ (getSectionId() == null ? 0 : this.getSectionId().hashCode());
		result = 37
				* result
				+ (getScheduleDate() == null ? 0 : this.getScheduleDate()
						.hashCode());
		result = 37 * result
				+ (getTimeFrom() == null ? 0 : this.getTimeFrom().hashCode());
		result = 37 * result
				+ (getTimeTo() == null ? 0 : this.getTimeTo().hashCode());
		result = 37 * result
				+ (getNoOfSeats() == null ? 0 : this.getNoOfSeats().hashCode());
		return result;
	}

}