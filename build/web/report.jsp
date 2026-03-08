<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Login.DBConnection"%>

<%
if(session.getAttribute("userEmail")==null){
 response.sendRedirect("index.html");
 return;
}

request.setAttribute("activePage","report");

String email=(String)session.getAttribute("userEmail");
Connection con=DBConnection.getConnection();

double total=0;

Statement st1=con.createStatement();
ResultSet rs1=st1.executeQuery(
"SELECT SUM(amount) FROM expenses WHERE user_email='"+email+"'");

if(rs1.next()) total=rs1.getDouble(1);
%>

<html>
<head>
<style>

body{
 margin:0;
 font-family:Arial;
 background:#f3f4f6;
}

.main{
 margin-left:270px;
 padding:20px;
}

.top{
 background:linear-gradient(#2E86C1,#3498db);
 color:white;
 padding:25px;
 border-radius:20px;
 text-align:center;
 margin-bottom:20px;
}

.cat{
 background:white;
 padding:15px;
 border-radius:12px;
 margin-bottom:12px;
 display:flex;
 justify-content:space-between;
 box-shadow:0 2px 8px rgba(0,0,0,0.1);
}

.circle{
 width:35px;
 height:35px;
 border:3px solid #2E86C1;
 border-radius:50%;
 margin-right:10px;
 display:flex;
 align-items:center;
 justify-content:center;
 font-size:18px;
}

</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<div class="top">
<h3>Total Expense</h3>
<h1>₹ <%=String.format("%.0f",total)%></h1>
</div>

<%
Statement st2=con.createStatement();
ResultSet rs2=st2.executeQuery(
"SELECT category,SUM(amount) totalCat FROM expenses WHERE user_email='"+email+"' GROUP BY category");

while(rs2.next()){

String cat=rs2.getString("category");
double amt=rs2.getDouble("totalCat");

double per=0;
if(total>0){
 per=(amt/total)*100;
}

/* Emoji logic */
String emoji="💰";

if(cat.equalsIgnoreCase("Food")) emoji="🍔";
else if(cat.equalsIgnoreCase("Travel")) emoji="✈️";
else if(cat.equalsIgnoreCase("Shopping")) emoji="🛍️";
else if(cat.equalsIgnoreCase("Bills")) emoji="📄";
else if(cat.equalsIgnoreCase("Entertainment")) emoji="🎬";
else if(cat.equalsIgnoreCase("Hospitals")) emoji="💊";
else if(cat.equalsIgnoreCase("Education")) emoji="📚";
else if(cat.equalsIgnoreCase("Transport")) emoji="🚗";
%>

<div class="cat">

<div style="display:flex;">
<div class="circle"><%=emoji%></div>

<div>
<b><%=cat%></b><br>
<%=String.format("%.0f",per)%>% of budget
</div>
</div>

<div>₹ <%=String.format("%.0f",amt)%></div>

</div>

<% } %>

</div>
</body>
</html>