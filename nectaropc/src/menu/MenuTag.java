package menu;

import java.io.*;
import java.util.*;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.*;
import javax.servlet.http.HttpSession;

public abstract class MenuTag extends TagSupport
{
    /**
     * Called when the start of the tag in encountered
     * @return EVAL_BODY_INCLUDE(int) signals the container to evaluate
     * the body of the jsp page and include it in the o/p stream
     * @exception JspTagException if the jsp page page produces any errors
    */
    public int doStartTag() throws JspTagException
    {
        return EVAL_BODY_INCLUDE;
    }

    /**
     *  Called when the end of tag is encountered.
     *  Retrieves menu hierarchy from the MenuFacade render method and writes it to the JSP page.
     *  @return EVAL_PAGE(int) signals the container to evaluate the rest of the page
     *  @exception JspTagException if the jsp page page produces any errors
    */
    public int doEndTag() throws JspTagException
    {
        StringBuffer sbscript = new StringBuffer();
        JspWriter out = pageContext.getOut();
        try
        {
            sbscript.append("<STYLE TYPE=\"text/css\">classes.GREENBOLD.all.color = \"#44CC22\";");
            sbscript.append("</STYLE>");
            sbscript.append("<script language=\"JavaScript\" src=\"..\\js\\dynamicmenu.js\"></script>");
            sbscript.append("<script language=\"javascript\">");
            sbscript.append("initmenu(7,20,150,100,\"horizontal\");");
            sbscript.append(getMenu());
            sbscript.append("createmenu();");
            sbscript.append("add10xitems();");
            sbscript.append("</script>");

            sbscript.append("<TABLE cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"560\" align=\"center\">");
            sbscript.append("<TR><TD colspan=\"2\"> </TD><TD colspan=\"3\"></TD></TR><TR>");
            sbscript.append("<TD colspan=\"5\" id=\"holdmenu\" style=\"POSITION: relative\" valign=\"top\">&nbsp;</TD></TR></table>");
            sbscript.append("<script language=\"javascript\">");
            //sbscript.append("MENU_POS['block_left'][0]=610;");for trial menu
            sbscript.append("MENU_POS['block_left'][0]=450;");
            sbscript.append("MENU_POS['block_top'][0]=65;");//document.getElementById('holdmenu').offsetTop;");
            //sbscript.append("MENU_POS['block_top'][0]=20;"); for trial menu
            sbscript.append("new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);</script>");
            out.print(sbscript);
            out.flush();
        }//~try...
        catch (MenuException ex)
        {
                Exception wrappedex = ex.getWrappedEx();
                wrappedex.printStackTrace();
                throw new Error("Unable to Print the Menu.");

        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            throw new Error("Unable to Print the Menu.");

        }

        return EVAL_PAGE;
    }

    protected abstract String getMenu() throws MenuException;
}

