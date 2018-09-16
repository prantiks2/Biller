<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/deleteproduct_style.css" />
</head>
<jsp:useBean id="dp" class="biller.Product" scope="page"/>
<%
dp.setUpc(request.getParameter("upc"));
int t=dp.deleteProduct();
if(t>0)
{
response.sendRedirect("producthome.jsp?search=&field=pname");
}
else
{
%>
<div id=delfail>Unable to delete item!</div><font color=red>
<%
}
if(!dp.excep.equals(""))
out.println("An Exception Occured:-"+dp.excep);
%></font>