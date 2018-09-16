<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/insertcustomer_style.css" />
<script language="javascript">
function verifyform()
{
var cname=document.getElementById("cname").value;
var cmob=document.getElementById("cmob").value;
var cphn=document.getElementById("cphn").value;
var caddr=document.getElementById("caddr").value;
var f=0;
if(cname=="")
{
document.getElementById("cnamealert").innerHTML="<font color=red>Enter name of customer!</font>";
f=1;
}
else
{
document.getElementById("cnamealert").innerHTML="";
}
if((cmob.length!=10)||(isNaN(cmob)))
{
document.getElementById("cmobalert").innerHTML="<font color=red>Enter a valid mobile number!</font>";
f=1;
}
else
{
document.getElementById("cmobalert").innerHTML="";
}
if((cphn!="")&&(cphn.length!=15))
{
document.getElementById("cphnalert").innerHTML="<font color=red>Enter a valid GST number!</font>";
f=1;
}
else
{
document.getElementById("cphnalert").innerHTML="";
}
if(f==1)
{
return false;
}
if(caddr=="")
document.getElementById("caddr").value="N.A.";
if(cphn=="")
document.getElementById("cphn").value="N.A.";
}
</script>
</head>
<form action=insert_customer_to_db.jsp method=post name=f1 onsubmit="return verifyform()">
<table id="customerentry">
<tr><td>Name<font color=red>*</font></td><td><input type=text name=cname id=cname><div id="cnamealert"></div></td></tr>
<tr><td>Mobile No.<font color=red>*</font></td><td><input type=text name=cmob id=cmob><div id="cmobalert"></div></td></tr>
<tr><td>GSTIN</td><td><input type=text name=cgstin id=cphn><div id="cphnalert"></div></td></tr>
<tr><td>Address</td><td><input type=text name=caddr id=caddr></td></tr>
<tr><td><input type=reset  value=reset></td><td align=right><input type=submit value="add to database"></td></tr>
</table>
<div id="tableinfo">
Fields marked with <font color=red>*</font> cannot be empty.
</div>
</form>