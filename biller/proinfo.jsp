<jsp:useBean id="test" class="biller.Product" scope="page"/>
<%  
String pid=request.getParameter("id");
String prop=request.getParameter("attr");
if(pid==null || pid.trim().equals(""))
{  
out.print("Please enter id");  
}
else
{  
test.setUpc(pid);
test.getProduct();
if(prop.equals("name"))
out.print(test.getPname());
else if(prop.equals("mrp"))
out.print(test.getPmrp());
else if(prop.equals("cp"))
out.print(test.getPcp());
else if(prop.equals("sp"))
out.print(test.getPsp());
}  
%>  