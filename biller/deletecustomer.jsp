<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/deletecustomer_style.css" />
</head>
<jsp:useBean id="dc" class="biller.Customer" scope="page"/>
<%
dc.setCid(Integer.parseInt(request.getParameter("cid")));
int t=dc.deleteCustomer();
if(t>0)
{
response.sendRedirect("customerhome.jsp?search=");
}
else
{
%>
<div id=delfail>Unable to delete customer!</div><font color=red>
<%
}
if(!dc.excep.equals(""))
out.println("An Exception Occured:-"+dc.excep);
%></font>