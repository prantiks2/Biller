<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/insertvendor_style.css" />
<script language="javascript">
function verifyform()
{
var vname=document.getElementById("vname").value;
var f=0;
if(vname=="")
{
document.getElementById("vnamealert").innerHTML="<font color=red>Enter name of Vendor!</font>";
f=1;
}
else
{
document.getElementById("vnamealert").innerHTML="";
}
if(f==1)
{
return false;
}
}
</script>
</head>
<form action=insert_vendor_to_db.jsp method=post name=f1 onsubmit="return verifyform()">
<table id="vendorentry">
<tr><td>Name<font color=red>*</font></td><td><input type=text name=vname id=vname><div id="vnamealert"></div></td></tr>
<tr><td>Address</td><td><input type=text name=vaddress></td></tr>
<tr><td>GSTIN</td><td><input type=text name=vgst></td></tr>
<tr><td>Owner</td><td><input type=text name=vboss></td></tr>
<tr><td>Owner's No.</td><td><input type=text name=vbossno></td></tr>
<tr><td>Salesman</td><td><input type=text name=vsales></td></tr>
<tr><td>Salesman No.</td><td><input type=text name=vsalesno></td></tr>
<tr><td>Delivery Man</td><td><input type=text name=vdel></td></tr>
<tr><td>Delivery Man's No.</td><td><input type=text name=vdelno></td></tr>
<tr><td>Office No.</td><td><input type=text name=voffice></td></tr>
<tr><td><input type=reset  value=reset></td><td align=right><input type=submit value="add to database"></td></tr>
</table>
<div id="tableinfo">
Fields marked with <font color=red>*</font> cannot be empty.
</div>
</form>