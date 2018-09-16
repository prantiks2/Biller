<jsp:useBean id="test" class="biller.Customer" scope="page"/>
<%  
String pid=request.getParameter("id");
if(pid==null || pid.trim().equals(""))
{  
out.print("Please enter customer id!");  
}
else
{  
test.setCid(Integer.parseInt(pid));
test.getCustomer();
String n=test.getCname();
if(n==null)
out.print("");
else
out.print(n);
}  
%>  