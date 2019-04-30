package menu;

public class XMLMenuTag extends MenuTag
{
        private String xmlfile;
    public XMLMenuTag(){
    }

    public String getXmlFilename(){
            return xmlfile;
    }

    public void setXmlFilename(String xmlfile){
            this.xmlfile = xmlfile;
    }

    protected String getMenu() throws MenuException{
            XMLMenuBuilder builder = new XMLMenuBuilder(xmlfile);
            return builder.renderMenu();
    }

}