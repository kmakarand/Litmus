import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import ChartDirector.*;

public class SimplePie //implements DemoModule
{
    //Name of demo program
    public String toString() { return "Simple Pie Chart"; }

    //Number of charts produced in this demo
    public int getNoOfCharts() { return 1; }

    //Main code for creating charts
    public void createChart(ChartViewer viewer, int chartIndex)
    {
        // The data for the pie chart
        double[] data = {25, 18, 15, 12, 8, 30, 35};

        // The labels for the pie chart
        String[] labels = {"Labor", "Licenses", "Taxes", "Legal", "Insurance", "Facilities",
            "Production"};

        // Create a PieChart object of size 360 x 300 pixels
        PieChart c = new PieChart(360, 300);

        // Set the center of the pie at (180, 140) and the radius to 100 pixels
        c.setPieSize(180, 140, 100);

        // Set the pie data and the pie labels
        c.setData(data, labels);

        // Output the chart
        viewer.setChart(c);

        //include tool tip for the chart
        viewer.setImageMap(c.getHTMLImageMap("clickable", "",
            "title='{label}: US${value}K ({percent}%)'"));
    }

    //Allow this module to run as standalone program for easy testing
    public static void main(String[] args)
    {
        //Instantiate an instance of this demo module
    	SimplePie demo = new SimplePie();

        //Create and set up the main window
        JFrame frame = new JFrame(demo.toString());
        frame.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {System.exit(0);} });
        frame.getContentPane().setBackground(Color.white);

        // Create the chart and put them in the content pane
        ChartViewer viewer = new ChartViewer();
        demo.createChart(viewer, 0);
        frame.getContentPane().add(viewer);

        // Display the window
        frame.pack();
        frame.setVisible(true);
    }
}