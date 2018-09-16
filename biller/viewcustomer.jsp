<%@page import="java.sql.*"%>
<%@include file="menu.jsp"%>
<head>
<link rel="stylesheet" type="text/css" href="css/viewcustomer_style.css"/>
<script language="javascript">
function verifyform()
{
var cname=document.getElementById("cname").value;
var cmob=document.getElementById("cmob").value;
var cphn=document.getElementById("cphn").value;
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
if(cphn=="")
document.getElementById("cphn").value="N.A.";
}
</script>
</head>
<jsp:useBean id="cust" class="biller.Customer" scope="page"/>
<jsp:useBean id="binfo" class="biller.Bill" scope="page"/>
<%
int cu=Integer.parseInt(request.getParameter("cid"));
cust.setCid(cu);
int t=cust.getCustomer();
if(t>0)
{
%>
<form action=updatecustomer.jsp method=post name=f1 onsubmit="return verifyform()">
<table id="customerentry">
<tr><td>Customer ID<font color=red>*</font></td><td><input type=text name=cid id=cid value=<%=cust.getCid()%> readonly></td></tr>
<tr><td>Name<font color=red>*</font></td><td><input type=text name=cname id=cname value="<%=cust.getCname()%>"><div id="cnamealert"></div></td></tr>
<tr><td>Mobile No.<font color=red>*</font></td><td><input type=text name=cmob id=cmob value=<%=cust.getCmob()%>><div id="cmobalert"></div></td></tr>
<tr><td>GSTIN</td><td><input type=text name=cgstin id=cphn><div id="cphnalert" value=<%=cust.getCgstin()%>></div></td></tr>
<tr><td>Address</td><td><textarea name=caddr cols=22><%=cust.getCaddr()%></textarea></td></tr>
<tr><td>Amount Due</td><td><input type=text name=camtdue value=<%=cust.getCamtdue()%> readonly></td></tr>
<tr><td><input type=reset  value=reset></td><td align=right><input type=submit value="Update"></td></tr>
</table>
<div id="tableinfo">
Fields marked with <font color=red>*</font> cannot be empty.
</div>
</form>
<div id="info">Invoices for <%=cust.getCname()%></div>
<table id="bills">
<tr><th id=res>Bill Id</th><th id=res>Bill Date</th><th id=res>Bill Amount</th><th id=res>Amount Paid</th><th id=res>Amount Due</th><th id=res>Delete Bill</th></tr>
<%
try
{
ResultSet rs=binfo.getBillListByCid(cu);
while(rs.next())
{
%>
<tr id=resrow>
<td id=res><a id=itemlink href=updatebill.jsp?bid=<%=rs.getInt(1)%>><%=rs.getInt(1)%></a></td>
<td id=res><%=rs.getString(3)%></td>
<td id=res><%=rs.getString(7)%></td>
<td id=res><%=rs.getString(8)%></td>
<td id=res><%=rs.getString(9)%></td>
<td id=res><a id=itemlink href=deletebill.jsp?bid=<%=rs.getInt(1)%>&cid=<%=cu%> onclick="return confirm('Are you sure you want to delete bill with bill id:<%=rs.getInt(1)%>?')">delete</a></td>
</tr>
<%
}
%>
</table>
<%
}
catch(Exception e){out.println(e);}
}
else
{
%>
<div id="fail">Unable to fetch customer information!</div><font color=red>
<%
}
if(!cust.excep.equals(""))
out.println("An Exception Occured:-"+cust.excep);
if(!binfo.excep.equals(""))
out.println("An Exception Occured:-"+binfo.excep);
%></font>