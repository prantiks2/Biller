/*
place the class file of this java file in "C:\Program Files\MySQL\MySQL Server 5.7\bin" where mysqldump.exe file is present.
create a batch file that will run the class file.
*/
import java.io.*; 
public class doscmd 
{ 
public static void main(String args[]) 
{ 
try 
{
BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
System.out.print("Enter backupfile name:");
String bfile=br.readLine();
Process p=Runtime.getRuntime().exec("cmd /c mysqldump -u root -ppran1849 biller > C:\\Users\\Prantik\\Documents\\"+bfile+".sql"); 
p.waitFor(); 
BufferedReader reader=new BufferedReader(new InputStreamReader(p.getInputStream())); 
String line=reader.readLine(); 
while(line!=null) 
{ 
System.out.println(line); 
line=reader.readLine(); 
}
System.out.println("File saved to C:\\Users\\Prantik\\Documents\\ ");
System.out.print("press enter to continue....");
br.read();
} 
catch(IOException e1) {} 
catch(InterruptedException e2) {} 

System.out.println("Done"); 
} 
} 
