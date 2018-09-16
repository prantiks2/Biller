<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/deletevbill_style.css" />
</head>
<jsp:useBean id="dvb" class="biller.Vbill" scope="page"/>
<%
dvb.setVbid(Integer.parseInt(request.getParameter("vbid")));
dvb.setVid(Integer.parseInt(request.getParameter("vid")));
int t=dvb.deleteVbill();
if(t>0)
{
response.sendRedirect("viewvendor.jsp?vid="+request.getParameter("vid"));
}
else
{
%>
<div id=delfail>Unable to delete vendor bill!</div><font color=red>
<%
}
if(!dvb.excep.equals(""))
out.println("An Exception Occured:-"+dvb.excep);
%></font>