package menu;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import java.io.File;
import java.io.IOException;
import java.util.*;

import org.w3c.dom.*;

public class XMLMenuBuilder implements MenuBuilder
{
    private int coord=0;
    private ArrayList topMenus = new ArrayList();
    private String xmlfile;
    public XMLMenuBuilder(String xmlfile)
    {
           this.xmlfile = xmlfile;
    }

    public String renderMenu() throws MenuException
    {
        DocumentBuilderFactory factory =
        DocumentBuilderFactory.newInstance();
        try
        {
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse( new File(xmlfile) );
            String str = renderMenu(document);
            //System.out.println(str);
            return str;
        }
        catch (SAXException sxe)
        {
            // Error generated during parsing)
            Exception  x = sxe;
            if (sxe.getException() != null)
            x = sxe.getException();
            x.printStackTrace();
            throw new MenuException("Error processing the document", x);

        }
        catch (Exception ex)
        {
            throw new MenuException("Error processing the document", ex);
        }
    }



    private String renderMenu(Document document)throws Exception
    {
        StringBuffer sb = new StringBuffer();
        buildMenu(document, null);
        int j=1;
        for (int i=0;i<topMenus.size();i++)
        {
            Menu menu = (Menu)topMenus.get(i);
            menu.setLevelCoord(Integer.toString(j));
            j++;
            sb.append(menu.render());
        }

        return sb.toString();

    }

    private void buildMenu(Node nodesrc, CompositeMenu comSrc) throws Exception
    {
        NodeList list = nodesrc.getChildNodes();
        int k=0;
        int m=0;
        for (int i=0; i<list.getLength(); i++)
        {
            Attr attr = null;
            String name = null;
            String id = null;
            String url = null;

            Node node = list.item(i);
            Node parentNode  = node.getParentNode();

            if (node.getNodeType() == Node.ELEMENT_NODE)
            {
                Element elem = (Element)node;
                if ((attr = elem.getAttributeNode("name")) != null)
                name =attr.getValue();
                if ((attr = elem.getAttributeNode("id")) != null)
                id =attr.getValue();

                if ((attr = elem.getAttributeNode("href")) != null)
                url =attr.getValue();

                if (parentNode != null && parentNode.getNodeType()== Node.ELEMENT_NODE && parentNode.getNodeName().equals("menus"))
                {
                    //System.out.println(parentNode.getNodeName() + " " + node.getNodeName());
                    //System.out.println("Top level menu");
                    CompositeMenu topMenu = new CompositeMenu(id, name);
                    comSrc = topMenu;
                    topMenus.add(topMenu);
                    buildMenu(node, topMenu);
                    continue;

                }//~if (parentNode != null &...

                if (node.getChildNodes().getLength() >0)
                {
                    CompositeMenu comMenu =null;
                    comMenu = new CompositeMenu(id, name);
                    if (comSrc != null)
                    comSrc.add(comMenu);
                    buildMenu(node, comMenu);
                    continue;

                }//~if (node.getChildNodes()...

                StringBuffer sb = new StringBuffer();
                Menu menu1 = new SimpleMenu(id, name,  url);
                comSrc.add(menu1);

            }//~if (node.getNodeType() =...
        }//~for (int i=0; i<list.get...
    }//~public void buildMenu(No...

    public static void main(String argv[]) throws Exception
    {
        if (argv.length < 1)
        {
            System.err.println("Usage: MenuBuilder filename");
            System.exit(1);
        }

        XMLMenuBuilder builder = new XMLMenuBuilder(argv[0]);
        builder.renderMenu();

        }

}
