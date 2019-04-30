<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%
            final DefaultPieDataset data = new DefaultPieDataset();
            data.setValue("One", new Double(43.2));
            data.setValue("Two", new Double(10.0));
            data.setValue("Three", new Double(27.5));
            data.setValue("Four", new Double(17.5));
            data.setValue("Five", new Double(11.0));
            data.setValue("Six", new Double(19.4));
            JFreeChart chart = ChartFactory.createPieChart
            ("Pie Chart ", data, true, true, false);
            try {
                final ChartRenderingInfo info = new 
              ChartRenderingInfo(new StandardEntityCollection()); 
                final File file1 = new File("piechart.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
            } catch (Exception e) {
                out.println(e);
            }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <IMG SRC="piechart.png" WIDTH="600" HEIGHT="400" 
         BORDER="0" USEMAP="#chart">
    </body>
</html> 