<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/deletevendor_style.css" />
</head>
<jsp:useBean id="dv" class="biller.Vendor" scope="page"/>
<%
dv.setVid(Integer.parseInt(request.getParameter("vid")));
int t=dv.deleteVendorByVid();
if(t>0)
{
response.sendRedirect("vendorhome.jsp?search=");
}
else
{
%>
<div id=delfail>Unable to delete Vendor!</div><font color=red>
<%
}
if(!dv.excep.equals(""))
out.println("An Exception Occured:-"+dv.excep);
%></font>