<head>
<link rel="stylesheet" type="text/css" href="css/insertvendorbill_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="vnb" class="biller.Vbill" scope="page"/>
<jsp:setProperty name="vnb" property="*"/>
<%
int t=vnb.insertVbillToDb();
if(t>0)
{
response.sendRedirect("viewvendor.jsp?vid="+request.getParameter("vid"));
}
else
{
%>
<div id="fail">Unable to add Vendor bill!</div><font color=red>
<%
}
if(!vnb.excep.equals(""))
out.println("An Exception Occured:-"+vnb.excep);
%></font>
<a id="gotochome" href=# onclick="window.history.back()">Go back</a>