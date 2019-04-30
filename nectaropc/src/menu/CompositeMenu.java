package menu;

import java.util.Vector;
import java.util.*;
import java.util.NoSuchElementException;
import java.util.Iterator;

public class CompositeMenu extends Menu
{
    private Vector list = new Vector();

    /** @link aggregationByValue */
    /*# Menu lnkMenu; */

    public CompositeMenu(String menuId, String menuName)
    {
        super(menuId, menuName);
    }


    public CompositeMenu(String menuId, String menuName,String url)
    {
        super(menuId, menuName,url);
    }

    /**
     * Returns the list of child menus
     * @return collection of child menus
    */
    public Collection listChildMenus()
    {
        return list;
    }

    /**
     * Returns the child
     * @param functionid as string
     * @return the child
    */
    public Menu getChild(String s)
    {
        return null;
    }

  /**
     * Renders the section menus
     * @return String containing the section menus.
    */
    public String render()
    {
        StringBuffer sb = new StringBuffer();


        sb.append("addmenuitem(");
        sb.append("\"" + getLevelCoord() + "\",");
        sb.append("\"" + getMenuName() + "\",");
     //   System.out.println(getUrl() + " "  + getMenuName());
        if (null == getUrl())
            sb.append("null" + ",");
         else
                sb.append("\"" + getUrl() + "\",");


        sb.append("\"grey\",\"FAEBD7\",\"white\",\"3366CC\",\"lightblue\",\"3366CC\",\"font-family:Tahoma, Verdana, Arial; font-size:12px;font-weight:normal,text-decoration:none;padding: 4px\");");
        sb.append("\n");


        Iterator it = list.iterator();
        int i=1;
        while(it.hasNext())
        {
            Menu menu = (Menu)it.next();

            //menu.setLevelCoord(getLevelCoord()+ i);
            menu.setLevelCoord(getLevelCoord() + "," + i);
            sb.append(menu.render());
            i++;
        }

        return sb.toString();
    }//~public String render()...

    /**
     * Adds the menu to the list
     * @param Menu object
     * @return boolean value for success or failure.
     * @exception NoSuchElementException
    */
    public  boolean add(Menu menu) throws NoSuchElementException
    {
        list.add(menu);
        return true;
    }

  /**
     * Removes the menu from the list
     * @param menu object
     * @exception NoSuchElementException
    */
    public void remove(Menu menu) throws NoSuchElementException
    {
        list.remove(menu);
    }


}//~public class CompositeMe...

