package com.ngs;

import java.sql.*;
import java.io.*;
import org.jfree.ui.*;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.*;
import org.jfree.data.jdbc.JDBCPieDataset;

public class PieChart {
	public static void main(String[] args) throws Exception {

		String query = "SELECT * FROM newexamtestingdetails;";
		JDBCPieDataset dataset = new JDBCPieDataset(
				"jdbc:mysql://localhost:3306/nectar", "com.mysql.jdbc.Driver",
				"nectar", "nec76tar");

		dataset.executeQuery(query);
		JFreeChart chart = ChartFactory.createPieChart("Test", dataset, true,
				true, false);
		ChartPanel chartPanel = new ChartPanel(chart);
		chartPanel.setPreferredSize(new java.awt.Dimension(500, 270));
		ApplicationFrame f = new ApplicationFrame("Chart");
		f.setContentPane(chartPanel);
		f.pack();
		f.setVisible(true);

	}
}