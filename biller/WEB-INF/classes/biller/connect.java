package biller;
import java.sql.*;
public class connect
{
Connection con=null;
public Connection getConnection()
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
return con;
}
}