package com.ngs;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.ngs.dao.ImageinfoDAO;
import com.ngs.entity.Imageinfo;

public class InsertPicture {
  public static void main(String[] args) throws Exception, IOException, SQLException {
	  
	int questionId =3210;Query query=null;
	Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/nectar", "nectar", "nec76tar");
    String INSERT_PICTURE = "INSERT INTO imageinfo (id,questionId,optionno,image) VALUES (?,?,?,?)";
    FileInputStream fis = null;
    PreparedStatement ps = null;
    try {
      conn.setAutoCommit(false);
      File file = new File("C:\\Users\\Makarand\\Pictures\\cheque.jpg");
      fis = new FileInputStream(file);
      ps = conn.prepareStatement(INSERT_PICTURE);
      ps.setInt(1, 5);
      ps.setInt(2, questionId);
      ps.setBinaryStream(4, fis, (int) file.length());
      ps.setInt(3, 1);
      ps.executeUpdate();
      conn.commit();
    } finally {
      ps.close();
      fis.close();
    }

  }
}