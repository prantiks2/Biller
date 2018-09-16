<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/deletebill_style.css" />
</head>
<jsp:useBean id="dc" class="biller.Bill" scope="page"/>
<%
dc.setBid(Integer.parseInt(request.getParameter("bid")));
int t=dc.deleteBill();
String c=request.getParameter("cid");
if(t>0)
{
if(c==null||c.equals(""))
response.sendRedirect("invoicehome.jsp?sortval=bid&d=");
else
response.sendRedirect("viewcustomer.jsp?cid="+c);
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