package com.ngs.entity;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.*;

import com.ntw.Emp;


/**
 * Candidatemaster entity. @author MyEclipse Persistence Tools
 */
@Entity
@NamedQueries({
	@NamedQuery(name="Userdetails-Candidatemaster.sql3",
				query="select c from Candidatemaster c where c.clientId=?1 and c.scheduleId=?2 order by c.candidateId"),
	@NamedQuery(name="RegistrationKey-Candidatemaster.sql2",
				query="SELECT cm FROM Candidatemaster cm WHERE cm.candidateId=:cid"),
	@NamedQuery(name="RegistrationKey-Candidatemaster.sql7",
				query="SELECT cm.candidateId FROM Candidatemaster cm WHERE cm.candidateId=:cid"),
	@NamedQuery(name="RegistrationKey-Candidatemaster.sql8",
				query="SELECT cm.clientId FROM Candidatemaster cm WHERE cm.candidateId=:cid"),
	@NamedQuery(name="AddressManager-Candidatemaster.sql1",
				query="SELECT cm.firstName,cm.lastName FROM Candidatemaster cm WHERE cm.candidateId=:cid"),
	@NamedQuery(name="Analysis-Candidatemaster.sql1",
				query="SELECT cm.firstName,cm.lastName,cm.candidateId from Candidatemaster cm where cm.candidateId =:cid"),
	@NamedQuery(name="CandidateList-Candidatemaster.sql1",
				query="select s.scheduleDate,c.candidateId,c.firstName,c.lastName,c.clientId,s.scheduleId,clm.clientName " +
				  "from Candidatemaster c, Schedule s,Clientmaster clm "+
				  "where s.scheduleDate>=?1 and s.scheduleDate<=?2 and c.scheduleId=s.scheduleId and c.clientId=clm.clientId " +
				  "group by c.candidateId,s.scheduleDate,c.firstName,clm.clientName, " +
				  "c.lastName,c.clientId,s.scheduleId order by s.scheduleDate,c.candidateId"),
	@NamedQuery(name="Assigncenter-Candidatemaster.sql1",
			query="SELECT A FROM Candidatemaster A,Usergroupxref B WHERE A.username=B.username and B.groupId=?1" +
					"ORDER BY A.firstName"),
	@NamedQuery(name="Monthly_Summary-Candidatemaster.sql1",
			query="SELECT cm FROM Candidatemaster cm WHERE cm.scheduleId IN (?1) AND cm.clientId=?2"),
	@NamedQuery(name="Monthly_Summary-Candidatemaster.sql2",
			query=("SELECT cm FROM Candidatemaster cm WHERE cm.scheduleId IN (SELECT s.scheduleId FROM Schedule s " +
				   "WHERE s.scheduleDate>=?1 and s.scheduleDate<=?2 and s.scheduleDate <= CURRENT_DATE) and " +
				   "cm.candidateId >3 and cm.scheduleId>0 and cm.clientId>0"))
				  
})


@Table(name = "CandidateMaster", catalog = "nectar", uniqueConstraints = @UniqueConstraint(columnNames = "Username"))
public class Candidatemaster implements java.io.Serializable {

	// Fields

	private Integer candidateId;
	private Integer scheduleId;
	private String username;
	private String password;
	private String typeOfUser;
	private String firstName;
	private String lastName;
	private Date dateOfBirth;
	private Integer sex;
	private String designation;
	private Integer clientId;
	private String email;
	private Integer experience;
	private Integer centreOfRegistration;
	private Date dateOfRegistration;
	private Integer isTableCreated;
	private String hintQuestion;
	private String hintAnswer;
	private Integer status;

	// Constructors

	/** default constructor */
	public Candidatemaster() {
	}

	/** minimal constructor */
	public Candidatemaster(Integer scheduleId, String username,
			String typeOfUser, String firstName, String lastName,
			Date dateOfBirth, Integer sex, String email,
			Integer centreOfRegistration, Date dateOfRegistration,
			Integer isTableCreated, String hintQuestion, String hintAnswer,
			Integer status) {
		this.scheduleId = scheduleId;
		this.username = username;
		this.typeOfUser = typeOfUser;
		this.firstName = firstName;
		this.lastName = lastName;
		this.dateOfBirth = dateOfBirth;
		this.sex = sex;
		this.email = email;
		this.centreOfRegistration = centreOfRegistration;
		this.dateOfRegistration = dateOfRegistration;
		this.isTableCreated = isTableCreated;
		this.hintQuestion = hintQuestion;
		this.hintAnswer = hintAnswer;
		this.status = status;
	}

	/** full constructor */
	public Candidatemaster(Integer scheduleId, String username,
			String password, String typeOfUser, String firstName,
			String lastName, Date dateOfBirth, Integer sex, String designation,
			Integer clientId, String email, Integer experience,
			Integer centreOfRegistration, Date dateOfRegistration,
			Integer isTableCreated, String hintQuestion, String hintAnswer,
			Integer status) {
		this.scheduleId = scheduleId;
		this.username = username;
		this.password = password;
		this.typeOfUser = typeOfUser;
		this.firstName = firstName;
		this.lastName = lastName;
		this.dateOfBirth = dateOfBirth;
		this.sex = sex;
		this.designation = designation;
		this.clientId = clientId;
		this.email = email;
		this.experience = experience;
		this.centreOfRegistration = centreOfRegistration;
		this.dateOfRegistration = dateOfRegistration;
		this.isTableCreated = isTableCreated;
		this.hintQuestion = hintQuestion;
		this.hintAnswer = hintAnswer;
		this.status = status;
	}

	
	// Property accessors
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "CandidateID", unique = true, nullable = false)
    public Integer getCandidateId() {
		return this.candidateId;
	}
	
	//@OneToMany(mappedBy="objCandidatemaster")
	List<Addressdetails> listAddressdetails= new ArrayList<Addressdetails>();
	
	
	
	
	public void setCandidateId(Integer candidateId) {
		this.candidateId = candidateId;
	}
	
	
	
	
	@Column(name = "ScheduleID", nullable = false)
	public Integer getScheduleId() {
		return this.scheduleId;
	}

	public void setScheduleId(Integer scheduleId) {
		this.scheduleId = scheduleId;
	}

	@Column(name = "Username", unique = true, nullable = false, length = 40)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password", length = 50)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "TypeOfUser", nullable = false, length = 2)
	public String getTypeOfUser() {
		return this.typeOfUser;
	}

	public void setTypeOfUser(String typeOfUser) {
		this.typeOfUser = typeOfUser;
	}

	@Column(name = "FirstName", nullable = false, length = 20)
	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	@Column(name = "LastName", nullable = false, length = 20)
	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "DateOfBirth", nullable = false, length = 10)
	public Date getDateOfBirth() {
		return this.dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	@Column(name = "Sex", nullable = false)
	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	@Column(name = "Designation", length = 50)
	public String getDesignation() {
		return this.designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	@Column(name = "ClientID")
	public Integer getClientId() {
		return this.clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	@Column(name = "Email", nullable = false, length = 30)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "Experience")
	public Integer getExperience() {
		return this.experience;
	}

	public void setExperience(Integer experience) {
		this.experience = experience;
	}

	@Column(name = "CentreOfRegistration", nullable = false)
	public Integer getCentreOfRegistration() {
		return this.centreOfRegistration;
	}

	public void setCentreOfRegistration(Integer centreOfRegistration) {
		this.centreOfRegistration = centreOfRegistration;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "DateOfRegistration", nullable = false, length = 10)
	public Date getDateOfRegistration() {
		return this.dateOfRegistration;
	}

	public void setDateOfRegistration(Date dateOfRegistration) {
		this.dateOfRegistration = dateOfRegistration;
	}

	@Column(name = "isTableCreated", nullable = false)
	public Integer getIsTableCreated() {
		return this.isTableCreated;
	}

	public void setIsTableCreated(Integer isTableCreated) {
		this.isTableCreated = isTableCreated;
	}

	@Column(name = "HintQuestion", nullable = false)
	public String getHintQuestion() {
		return this.hintQuestion;
	}

	public void setHintQuestion(String hintQuestion) {
		this.hintQuestion = hintQuestion;
	}

	@Column(name = "HintAnswer", nullable = false, length = 15)
	public String getHintAnswer() {
		return this.hintAnswer;
	}

	public void setHintAnswer(String hintAnswer) {
		this.hintAnswer = hintAnswer;
	}

	@Column(name = "Status", nullable = false)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public List<Addressdetails> getAddressdetails() {
		  return listAddressdetails;
	}
		    
	public void setAddressdetails(Addressdetails objAddressdetails) {
		this.listAddressdetails = listAddressdetails;
	}


}