package net.codejava.applet;
 
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
 
import javax.swing.JApplet;
import javax.swing.JLabel;
 
public class MyApplet extends JApplet {
     
    private JLabel label = new JLabel();
     
    public void init() {
        label.setHorizontalAlignment(JLabel.CENTER);
        label.setFont(new Font("Arial", Font.BOLD, 20));
        label.setForeground(Color.BLUE);
         
        setLayout(new BorderLayout());
        add(label, BorderLayout.CENTER);
    }
     
    public void start() {
        String firstName = getParameter("firstName");
        String lastName = getParameter("lastName");
        label.setText("Hello " + firstName + " " + lastName);
    }
}