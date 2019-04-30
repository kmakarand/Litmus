package menu;

import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.sql.*;

import org.w3c.dom.*;

import com.ngs.gbl.ConnectionPool;

public class JDBCMenuBuilder implements MenuBuilder
{
    private int coord=0;
    private String driver;
    private String url;
    private String username;
    private String password;
    private ArrayList topMenus = new ArrayList();
    int q=0;
	int rights=0;
	Connection con=null;
	Statement stmt,stmt1,stmt2,stmt3=null;
	ResultSet rs,rs1,rs2,rs3=null; 
	String user = "";
	String groupid="",menuid="",mainGroupid="",groupxid="";
	PreparedStatement ps = null;
    
    public JDBCMenuBuilder(String driver, String url, String username, String password)
    {
    	try{
           this.driver = driver;
           this.url = url;
           this.username = username;
           this.password = password;
           Class.forName("com.mysql.jdbc.Driver");
    	}catch(Exception e){e.printStackTrace();}
    }
    
        
    public String getGroupID()
    {
    	try{
    		
		user = JDBCMenuTag.loginuser;
		//System.out.println("groupxid user :"+user);
		//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nectar", "nectar", "nec76tar");
		con = DriverManager.getConnection(url,username,password);
        ps = con.prepareStatement("select * from CandidateMaster where Username=?");
        ps.setString(1, user);
        //stmt1 = con.createStatement();
	    rs1 = ps.executeQuery();
		if(rs1.next()){
		mainGroupid=rs1.getString("Username");
		//System.out.println("got groupxid 1:"+mainGroupid);
		}//end of if(con!=null) to get the group ID
		else
		{	
			 //System.out.println("inside groupxid 2:");
			 ps = con.prepareStatement("select * from ClientMaster where Username=?");
	         ps.setString(1, user);
	         //stmt1 = con.createStatement();
		     rs1 = ps.executeQuery();
			 if(rs1.next()){
				mainGroupid=rs1.getString("Username");	
				//System.out.println("got groupxid 2:"+mainGroupid);
		    }//end of if(con!=null) to get the group ID
		}

		stmt = con.createStatement();
		stmt3 = con.createStatement();
		//System.out.println("groupxid 1:");
		rs3=stmt3.executeQuery("select * from UserGroupXRef where Username=\'"+mainGroupid+"\' ");
		while(rs3.next()){
			groupxid=rs3.getString("GroupID");
			//System.out.println("got groupxid :"+groupxid);
			}
		
		}catch(Exception e){e.printStackTrace();}
		
		return groupxid;
	}

    public String renderMenu() throws MenuException
    {
            String str = buildTopMenu();
            return str;
    }

    private String buildTopMenu() throws MenuException{
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection con = null;
        try{
        		con = DriverManager.getConnection(url, username, password);
        		String groupid = getGroupID();
        		ps = con.prepareStatement("select menuid, menuname, url from HierarchyMenu hm where exists ( select * from HiermenuRights hr where hm.menuid=hr.menuid and hr.groupid=? and parentmenuid is null) order by menuord");
        		//ps = con.prepareStatement("select menuid, menuname, url from HierarchyMenu where parentmenuid is null order by menuord");
        		ps.setString(1, groupid);
        		rs = ps.executeQuery();
                while(rs.next()){
                     CompositeMenu aTopMenu = new CompositeMenu(rs.getString(1), rs.getString(2), rs.getString(3));
                     topMenus.add(aTopMenu);
                }
        }
        catch(Exception ex)
        {
                throw new MenuException("Unable to get root menu from the database", ex);
        }
        finally
        {
             try{
             if (rs != null){
                rs.close();
                rs=null;
             }
             if (ps != null){
                ps.close();
                ps=null;
             }
             if (con != null){
                con.close();
                con=null;
             }
             }catch(Exception e){}
        }

        StringBuffer sb = new StringBuffer();
        int j=1;
        for (int i=0;i<topMenus.size();i++)
        {
         CompositeMenu menu = (CompositeMenu)topMenus.get(i);
         menu.setLevelCoord(Integer.toString(j));
         j++;
         buildMenu(menu.getMenuId(), menu);
         sb.append(menu.render());
     }
        //System.out.println(sb.toString());
        return sb.toString();
    }

    private boolean isLeaf(String menuId)throws MenuException
    {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection con = null;
        //System.out.println(menuId);
        boolean isLeaf = false;
        try{
                //Class.forName(driver);
                con = DriverManager.getConnection(url, username, password);
                ps = con.prepareStatement("select count(menuid) from HierarchyMenu where parentmenuid =?");
                ps.setString(1, menuId.trim());
                rs = ps.executeQuery();
                if (rs.next()){
                        //leaf node
                        int i = rs.getInt(1);
                        if (i < 1)
                           isLeaf = true;
                }
                return isLeaf;
        }
        catch(Exception ex)
        {
                throw new MenuException("Unable to get data from the database", ex);
        }
        finally
        {
             try{
             if (rs != null){
                rs.close();
                rs=null;
             }
             if (ps != null){
                ps.close();
                ps=null;
             }
             if (con != null){
                con.close();
                con=null;
             }
           }catch(Exception e){}
        }

    }

    private void buildMenu(String menuId, CompositeMenu comSrc) throws MenuException
    {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection con = null;
        //System.out.println("menuId	"+menuId);
        String groupid = getGroupID();
        //System.out.println("groupid	"+groupid);
        
        try{
                //Class.forName(driver);
                con = DriverManager.getConnection(url, username, password);
                ps = con.prepareStatement("select menuid, menuname, url, parentmenuid from HierarchyMenu hm where exists ( select * from HiermenuRights hr where hm.menuid=hr.menuid and hr.groupid=? and hm.parentmenuid =?) order by menuord");
                //ps = con.prepareStatement("select menuid, menuname, url, parentmenuid from HierarchyMenu where parentmenuid =? order by menuord");
                ps.setString(1, groupid);
                ps.setString(2, menuId.trim());
                rs = ps.executeQuery();
                while(rs.next()){
                     String childMenuId = rs.getString(1);
                     String menuName = rs.getString(2);
                     String href = rs.getString(3);
                     String parentId = rs.getString(4);
                     //System.out.println(childMenuId + " " + menuName + " " + parentId + " " + href);
                     if (isLeaf(childMenuId)) //simple menu
                     {
                            SimpleMenu sm = new SimpleMenu(childMenuId , menuName, href);
                            comSrc.add(sm);
                     }
                     else
                     {
                        //System.out.println("inside submenu" + childMenuId);
                        CompositeMenu aParentMenu = new CompositeMenu(childMenuId, menuName);
                        comSrc.add(aParentMenu);
                        buildMenu(childMenuId, aParentMenu);
                     }
                }
        }
        catch(Exception ex)
        {
                throw new MenuException("Unable to get data from the database", ex);
        }
        finally
        {
             try{
             if (rs != null){
                rs.close();
                rs=null;
             }
             if (ps != null){
                ps.close();
                ps=null;
             }
             if (con != null){
                con.close();
                con=null;
             }
           }catch(Exception e){}
        }
    }



    public static void main(String argv[]) throws Exception
    {
        JDBCMenuBuilder builder = new JDBCMenuBuilder("com.mysql.jdbc.Driver", "jdbc:mysql://localhost:3306/nectar?autoReconnect=true", "nectar", "nec76tar");
        String FinalMenu = builder.renderMenu();
        //System.out.println("FinalMenu" + FinalMenu);
    }

}
