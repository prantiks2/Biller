<%@include file="menu.jsp"%>
<%@ page import = "java.util.*,java.text.*,java.sql.*"%>
<%!String cd="";%>
<%
java.util.Date d=new java.util.Date();
SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
cd=ft.format(d).toString();%>
<head>
<link rel="stylesheet" type="text/css" href="css/viewvendor_style.css" />
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
function verify()
{
var vbdate=document.getElementById("vbdate").value;
var vbamt=document.getElementById("vbamt").value;
var f=0;
if(vbdate=="")
{
document.getElementById("vbdatealert").innerHTML="<font color=red>Enter bill date!</font>";
f=1;
}
else
{
document.getElementById("vbdatealert").innerHTML="";
}
if(vbamt==""||isNaN(vbamt))
{
document.getElementById("vbamtalert").innerHTML="<font color=red>Enter a valid bill amount!</font>";
f=1;
}
else
{
document.getElementById("vbamtalert").innerHTML="";
}
if(f==1)
{
return false;
}
}
</script>
</head>
<jsp:useBean id="vend" class="biller.Vendor" scope="page"/>
<jsp:useBean id="vb" class="biller.Vbill" scope="page"/>
<%
int v=Integer.parseInt(request.getParameter("vid"));
vend.setVid(v);
int t=vend.getVendorByVid();
if(t>0)
{
%>
<form action=updatevendor.jsp method=post name=f1 onsubmit="return verifyform()">
<table id="vendorentry">
<tr>
<td>Name<font color=red>*</font></td><td><input type=text name=vname id=vname value="<%=vend.getVname()%>"><div id="vnamealert"></div></td>
<td>Owner</td><td><input type=text name=vboss value="<%=vend.getVboss()%>"></td>
<td>Salesman</td><td><input type=text name=vsales value="<%=vend.getVsales()%>"></td>
<td>Delivery Man</td><td><input type=text name=vdel value="<%=vend.getVdel()%>"></td>
</tr>
<tr>
<td>Address</td><td><textarea name=vaddress cols=22><%=vend.getVaddress()%></textarea></td>
<td>Owner's No.</td><td><input type=text name=vbossno value="<%=vend.getVbossno()%>"></td>
<td>Salesman No.</td><td><input type=text name=vsalesno value="<%=vend.getVsalesno()%>"></td>
<td>Delivery Man's No.</td><td><input type=text name=vdelno value="<%=vend.getVdelno()%>"></td>
</tr>
<tr>
<td>GSTIN</td><td><input type=text name=vgst value="<%=vend.getVgst()%>"></td>
<td>Office No.</td><td><input type=text name=voffice value="<%=vend.getVoffice()%>"></td>
<td>Total Amount Due</td><td><input type=text name=vtotdue value="<%=vend.getVtotdue()%>" readonly></td>
</tr>
<tr><td><input type=reset  value=reset></td><td></td><td></td><td></td><td></td><td></td><td></td>
<td align=right><input type=submit value="update vendor detail"></td></tr>
<input type=hidden name=vid  value=<%=vend.getVid()%>>
</table>
<div id="tableinfo">
Fields marked with <font color=red>*</font> cannot be empty.
</div>
</form>
<form action=insertvendorbill.jsp method=post onsubmit="return verify()">
<table id="vbillentry">
<caption>Add new vendor bill</caption>
<tr>
<th>Date</th>
<th>Amount</th>
</tr>
<tr>
<td><input type=date name=vbdate id=vbdate value="<%=cd%>"><div id=vbdatealert></div></td>
<td><input type=text name=vbamt id=vbamt><div id=vbamtalert></div></td>
</tr>
<tr><td><input type=reset  value=reset></td><td align=right><input type=submit value="add bill"></td></tr>
<input type=hidden name=vid  value=<%=vend.getVid()%>>
</table>
</form>
<table id="billlist">
<caption>List of bills of <%=vend.getVname()%></caption>
<tr><th id=res>Bill Id</th><th id=res>Bill Date</th><th id=res>Bill Amount</th><th id=res>Amount Paid</th><th id=res>Amount Due</th><th id=res>Delete Bill</th></tr>
<%
vb.setVid(vend.getVid());
try
{
ResultSet rs=vb.getVbillListByVid();
while(rs.next())
{
%>
<tr id=resrow>
<td id=res><a id=itemlink href=viewvbill.jsp?vbid=<%=rs.getInt(1)%>&vid=<%=vend.getVid()%>><%=rs.getInt(1)%></a></td>
<td id=res><%=rs.getString(3)%></td>
<td id=res><%=rs.getString(4)%></td>
<td id=res><%=rs.getString(5)%></td>
<td id=res><%=rs.getString(6)%></td>
<td id=res><a id=itemlink href=deletevbill.jsp?vbid=<%=rs.getInt(1)%>&vid=<%=vend.getVid()%> onclick="return confirm('Are you sure you want to delete bill with bill id:<%=rs.getInt(1)%>?')">delete</a></td>
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
if(!vend.excep.equals(""))
out.println("An Exception Occured:-"+vend.excep);
if(!vb.excep.equals(""))
out.println("An Exception Occured:-"+vb.excep);
%></font>