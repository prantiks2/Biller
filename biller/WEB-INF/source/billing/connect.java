package billing;
import java.sql.*;
public class connect
{
public Connection con=null;
void main(String args[])
{
try
{
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306","root","pran1849"); 
}
catch(Exception e)
{
System.out.println("Exception at connect.java:"+e);
}
}
}