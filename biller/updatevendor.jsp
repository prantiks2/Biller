<head>
<link rel="stylesheet" type="text/css" href="css/updatevendor_style.css" />
</head>
<%@include file="menu.jsp"%>
<jsp:useBean id="upv" class="biller.Vendor" scope="page"/>
<jsp:setProperty name="upv" property="*"/>
<%
int t=upv.updateVendor();
if(t>0)
{
%>
<div id="success">Vendor information updated Successfully</div>
<%
}
else
{
%>
<div id="fail">Unable to Update Vendor Information!</div><font color=red>
<%
}
if(!upv.excep.equals(""))
out.println("An Exception Occured:-"+upv.excep);
%></font>
<a id="gotochome" href=vendorhome.jsp?search=>Goto Vendor Menu</a>