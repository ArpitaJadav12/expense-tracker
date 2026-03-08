<%-- 
    Document   : HistoryComparison
    Author     : ARPITA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Login.DBConnection"%>
<%@page import="java.util.Calendar"%>

<%
request.setAttribute("activePage","history");

String email=(String)session.getAttribute("userEmail");

Connection con=DBConnection.getConnection();
Statement st=con.createStatement();

double current=0,last=0;

/* ===== CURRENT MONTH ===== */
ResultSet r1=st.executeQuery(
"SELECT SUM(amount) FROM expenses " +
"WHERE MONTH(expense_date)=MONTH(CURDATE()) " +
"AND YEAR(expense_date)=YEAR(CURDATE()) " +
"AND user_email='"+email+"'");

if(r1.next()) current=r1.getDouble(1);

/* ===== LAST MONTH ===== */
ResultSet r2=st.executeQuery(
"SELECT SUM(amount) FROM expenses " +
"WHERE MONTH(expense_date)=MONTH(CURDATE()-INTERVAL 1 MONTH) " +
"AND YEAR(expense_date)=YEAR(CURDATE()-INTERVAL 1 MONTH) " +
"AND user_email='"+email+"'");

if(r2.next()) last=r2.getDouble(1);

double diff=current-last;

/* ===== MONTH NAME LOGIC ===== */
Calendar cal = Calendar.getInstance();

String[] months = {
 "January","February","March","April","May","June",
 "July","August","September","October","November","December"
};

int currentMonthIndex = cal.get(Calendar.MONTH);
int lastMonthIndex = (currentMonthIndex - 1 + 12) % 12;

String currentMonthName = months[currentMonthIndex];
String lastMonthName = months[lastMonthIndex];

/* ===== HISTORY (ALL MONTHS WITH EXPENSE) ===== */
ResultSet history=st.executeQuery(
"SELECT YEAR(expense_date) AS yr, " +
"MONTH(expense_date) AS mno, " +
"MONTHNAME(expense_date) AS mname, " +
"SUM(amount) AS total " +
"FROM expenses " +
"WHERE user_email='"+email+"' " +
"AND expense_date IS NOT NULL " +
"GROUP BY YEAR(expense_date), MONTH(expense_date), MONTHNAME(expense_date) " +
"ORDER BY YEAR(expense_date), MONTH(expense_date)");
%>

<html>
<head>
<style>
body{
 margin:0;
 font-family:'Segoe UI';
 background:#f4f6fb;
}

.main{
 margin-left:260px;
 padding:25px;
}

/* ===== TOP CARDS ===== */
.row{
 display:flex;
 gap:20px;
 margin-bottom:25px;
}

.small-card{
 flex:1;
 background:linear-gradient(135deg,#3b82f6,#2563eb);
 color:white;
 border-radius:16px;
 padding:22px;
 box-shadow:0 6px 16px rgba(0,0,0,0.12);
}

.small-card h3{
 margin:0 0 8px;
 font-size:18px;
}

.small-card h2{
 margin:0;
 font-size:28px;
}

/* ===== MAIN CARD ===== */
.card{
 background:white;
 border-radius:16px;
 padding:20px;
 box-shadow:0 4px 12px rgba(0,0,0,0.08);
}

table{
 width:100%;
 border-collapse:collapse;
 margin-top:10px;
}

th,td{
 padding:12px;
 text-align:left;
 border-bottom:1px solid #eee;
}

th{
 background:#f8fafc;
}
</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<h2>📊 Analytics Dashboard</h2>

<!-- ===== TOP ANALYTICS CARDS ===== -->
<div class="row">

<div class="small-card">
<h3><%=currentMonthName%> (This Month)</h3>
<h2>₹ <%=current%></h2>
</div>

<div class="small-card">
<h3><%=lastMonthName%> (Last Month)</h3>
<h2>₹ <%=last%></h2>
</div>

<div class="small-card">
<h3>Difference</h3>
<h2>₹ <%=diff%></h2>
</div>

</div>

<!-- ===== HISTORY TABLE ===== -->
<div class="card">

<h3>📅 Monthly Expense History</h3>

<table>
<tr>
<th>Month</th>
<th>Total Expense</th>
</tr>

<% while(history.next()){ %>
<tr>
<td>
<%=history.getString("mname")%> <%=history.getInt("yr")%>
</td>
<td>
₹ <%=history.getDouble("total")%>
</td>
</tr>
<% } %>

</table>

</div>

</div>

</body>
</html>