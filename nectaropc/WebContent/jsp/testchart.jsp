<%@page import="ChartDirector.*" %>
<%
// The data for the pie chart
double[] data = {25, 18, 15, 12, 8, 30, 35};

// The labels for the pie chart
String[] labels = {"Labor", "Licenses", "Taxes", "Legal", "Insurance", "Facilities", "Production"};

// Create a PieChart object of size 360 x 300 pixels
PieChart c = new PieChart(360, 300);

// Set the center of the pie at (180, 140) and the radius to 100 pixels
c.setPieSize(180, 140, 100);

// Set the pie data and the pie labels
c.setData(data, labels);

// Output the chart
String chart1URL = c.makeSession(request, "chart1");

// Include tool tip for the chart
String imageMap1 = c.getHTMLImageMap("", "", "title='{label}: US${value}K ({percent}%)'");
%>
<html>
<body style="margin:5px 0px 0px 5px">
<div style="font-size:18pt; font-family:verdana; font-weight:bold">
    Simple Pie Chart
</div>
<hr color="#000080">
<img src='<%=response.encodeURL("getchart.jsp?"+chart1URL)%>'
    border="0">

</body>
</html>