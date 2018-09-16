<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/viewproduct_style.css"/>
<script language="javascript">
function verifyform()
{
var upc=document.getElementById("upc").value;
var pname=document.getElementById("pname").value;
var pcomp=document.getElementById("pcomp").value;
var pcat=document.getElementById("pcat").value;
var pty=document.getElementById("pty").value;
var pmrp=document.getElementById("pmrp").value;
var pcp=document.getElementById("pcp").value;
var psp=document.getElementById("psp").value;
var pcgst=document.getElementById("pcgst").value;
var psgst=document.getElementById("psgst").value;
var f=0;
if(upc=="")
{
document.getElementById("upcalert").innerHTML="<font color=red>Enter UPC of product!</font>";
f=1;
}
else
{
document.getElementById("upcalert").innerHTML="";
}
if(pname=="")
{
document.getElementById("pnamealert").innerHTML="<font color=red>Enter product name!</font>";
f=1;
}
else
{
document.getElementById("pnamealert").innerHTML="";
}
if(pcomp=="")
{
document.getElementById("pcompalert").innerHTML="<font color=red>Enter company/manufacturer of product!</font>";
f=1;
}
else
{
document.getElementById("pcompalert").innerHTML="";
}
if(pcat=="")
{
document.getElementById("pcatalert").innerHTML="<font color=red>Enter product category like cosmetics or baby care etc!</font>";
f=1;
}
else
{
document.getElementById("pcatalert").innerHTML="";
}
if(pty=="")
{
document.getElementById("ptyalert").innerHTML="<font color=red>Enter product type like shampoo or diaper etc!</font>";
f=1;
}
else
{
document.getElementById("ptyalert").innerHTML="";
}
if(pmrp==""||(isNaN(pmrp)))
{
document.getElementById("pmrpalert").innerHTML="<font color=red>Enter a valid MRP of product!</font>";
f=1;
}
else
{
document.getElementById("pmrpalert").innerHTML="";
}
if(pcp==""||(isNaN(pcp)))
{
document.getElementById("pcpalert").innerHTML="<font color=red>Enter a valid Cost price of product!</font>";
f=1;
}
else
{
document.getElementById("pcpalert").innerHTML="";
}
if(psp==""||(isNaN(psp)))
{
document.getElementById("pspalert").innerHTML="<font color=red>Enter a valid default discount of product!</font>";
f=1;
}
else
{
document.getElementById("pspalert").innerHTML="";
}
if(pcgst==""||(isNaN(pcgst))||pcgst>100)
{
document.getElementById("pcgstalert").innerHTML="<font color=red>Enter a valid CGST rate of product!</font>";
f=1;
}
else
{
document.getElementById("pcgstalert").innerHTML="";
}
if(psgst==""||(isNaN(psgst))||psgst>100)
{
document.getElementById("psgstalert").innerHTML="<font color=red>Enter a valid SGST rate of product!</font>";
f=1;
}
else
{
document.getElementById("psgstalert").innerHTML="";
}

if(f==1)
{
return false;
}
}
</script>
</head>
<jsp:useBean id="vp" class="biller.Product" scope="page"/>
<%
vp.setUpc(request.getParameter("upc"));
int t=vp.getProduct();
if(t>0)
{
%>
<form action=updateproduct.jsp method=post name=f1 onsubmit="return verifyform()">
<table id="productentry">
<tr><td>UPC<font color=red>*</font></td><td><input type=text name=upc id=upc value=<%=vp.getUpc()%> readonly><div id="upcalert"></div></td></tr>
<tr><td>Name/HSN<font color=red>*</font></td><td><input type=text name=pname id=pname value="<%=vp.getPname()%>"><div id="pnamealert"></div></td></tr>
<tr><td>Company<font color=red>*</font></td><td><input type=text name=pcomp id=pcomp value="<%=vp.getPcomp()%>"><div id="pcompalert"></div></td></tr>
<tr><td>Description</td><td><textarea name=pdesc cols=22><%=vp.getPdesc()%></textarea></td></tr>
<tr><td>Category<font color=red>*</font></td><td><input type=text name=pcat id=pcat value="<%=vp.getPcat()%>"><div id="pcatalert"></div></td></tr>
<tr><td>Type<font color=red>*</font></td><td><input type=text name=pty id=pty value="<%=vp.getPty()%>"><div id="ptyalert"></div></td></tr>
<tr><td>MRP<font color=red>*</font></td><td><input type=text name=pmrp id=pmrp value=<%=vp.getPmrp()%>><div id="pmrpalert"></div></td></tr>
<tr><td>Cost Price<font color=red>*</font></td><td><input type=text name=pcp id=pcp value=<%=vp.getPcp()%>><div id="pcpalert"></div></td></tr>
<tr><td>Sale Price<font color=red>*</font></td><td><input type=text name=psp id=psp value=<%=vp.getPsp()%>><div id="pspalert"></div></td></tr>
<tr><td>CGST<font color=red>*</font></td><td><input type=text name=pcgst id=pcgst value=<%=vp.getPcgst()%>><div id="pcgstalert"></div></td></tr>
<tr><td>SGST<font color=red>*</font></td><td><input type=text name=psgst id=psgst value=<%=vp.getPsgst()%>><div id="psgstalert"></div></td></tr>
<tr><td>Units Sold</td><td><input type=text name=punt id=punt value=<%=vp.getPunt()%> readonly></td></tr>
<tr><td><input type=reset  value=reset></td><td align=right><input type=submit value="Update"></td></tr>
</table>
<div id="tableinfo">
Fields marked with <font color=red>*</font> cannot be empty. Don't enter "%" sign for CGST and SGST
</div>
</form>
<%
}
else
{
%>
<div id="fail">Unable to fetch product information!</div><font color=red>
<%
}
if(!vp.excep.equals(""))
out.println("An Exception Occured:-"+vp.excep);
%></font>