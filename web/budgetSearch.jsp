<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Login.DBConnection"%>

<%
request.setAttribute("activePage","budget");

String email=(String)session.getAttribute("userEmail");

Connection con=DBConnection.getConnection();
Statement st=con.createStatement();

/* ===== SAVE / UPDATE BUDGET ===== */
String newBudget=request.getParameter("newBudget");

if(newBudget!=null && !newBudget.equals("")){

   double budgetValue = Double.parseDouble(newBudget);

   if(budgetValue >= 0){

      ResultSet check=st.executeQuery(
      "SELECT * FROM budget WHERE user_email='"+email+"'");

      if(check.next()){
         st.executeUpdate(
         "UPDATE budget SET amount="+budgetValue+
         " WHERE user_email='"+email+"'");
      }else{
         st.executeUpdate(
         "INSERT INTO budget(id,user_email,amount) VALUES(NULL,'"
         +email+"',"+budgetValue+")");
      }
   }
}

/* ===== FETCH BUDGET DATA ===== */
double budget=0,total=0;

ResultSet b=st.executeQuery(
"SELECT amount FROM budget WHERE user_email='"+email+"'");
if(b.next()) budget=b.getDouble(1);

ResultSet t=st.executeQuery(
"SELECT SUM(amount) FROM expenses WHERE user_email='"+email+"'");
if(t.next()) total=t.getDouble(1);

/* ===== CALCULATIONS ===== */
double remaining=budget-total;
double used=0;

if(budget!=0)
   used=(total/budget)*100;

/* ===== STATUS ===== */
String msg="";
String barColor="#3b82f6";

if(used>=100){
   msg="❌ Budget Exceeded!";
   barColor="#ef4444";
}
else if(used>=80){
   msg="⚠ Almost reaching budget";
   barColor="#f59e0b";
}
else{
   msg="✔ Budget Healthy";
}

/* ===== SEARCH (CATEGORY + DATE + AMOUNT) ===== */

String cat=request.getParameter("category");
String sDate=request.getParameter("searchDate");
String sAmount=request.getParameter("searchAmount");

String sql="SELECT * FROM expenses WHERE user_email='"+email+"'";

if(cat!=null && !cat.equals(""))
    sql += " AND category LIKE '%"+cat+"%'";

if(sDate!=null && !sDate.equals(""))
    sql += " AND expense_date='"+sDate+"'";

if(sAmount!=null && !sAmount.equals(""))
    sql += " AND amount="+sAmount;

ResultSet rsSearch=null;
boolean found=false;

if(cat!=null || sDate!=null || sAmount!=null){
   rsSearch=st.executeQuery(sql);
}
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

.card{
 background:white;
 border-radius:16px;
 padding:22px;
 margin-bottom:20px;
 box-shadow:0 4px 12px rgba(0,0,0,0.08);
}

.progress{
 width:100%;
 height:14px;
 background:#ddd;
 border-radius:10px;
 overflow:hidden;
}

.progress-bar{
 height:14px;
 border-radius:10px;
}

input,select{
 padding:10px;
 border:1px solid #ccc;
 border-radius:8px;
 margin-right:8px;
}

button{
 padding:10px 15px;
 background:#3b82f6;
 border:none;
 color:white;
 border-radius:8px;
 cursor:pointer;
}

.status{
 font-weight:bold;
 margin-top:10px;
}

.result{
 padding:8px 0;
 border-bottom:1px solid #eee;
}

</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<h2>💰 Smart Budget System</h2>

<!-- ===== BUDGET CARD ===== -->
<div class="card">

<h3>Set Monthly Budget</h3>

<form method="get">
<input type="number" name="newBudget"
       placeholder="Enter budget amount"
       min="0" required>
<button>Save Budget</button>
</form>

<hr>

<p><b>Total Budget:</b> ₹ <%=budget%></p>
<p><b>Spent:</b> ₹ <%=total%></p>
<p><b>Remaining:</b> ₹ <%=remaining%></p>

<div class="progress">
<div class="progress-bar"
style="width:<%=used%>%; background:<%=barColor%>;">
</div>
</div>

<p><%=String.format("%.1f",used)%>% used</p>
<div class="status"><%=msg%></div>

</div>

<!-- ===== SEARCH CARD ===== -->
<div class="card">

<h3>🔎 Search Expense</h3>

<form method="get">

<select name="category">
<option value="">All Categories</option>
<option value="Food">Food</option>
<option value="Travel">Travel</option>
<option value="Shopping">Shopping</option>
<option value="Bills">Bills</option>
<option value="Hospitals">Hospitals</option>
<option value="Stationary">Stationary</option>
<option value="Other">Other</option>
</select>

<input type="date" name="searchDate">

<input type="number" step="0.01"
name="searchAmount"
placeholder="Amount">

<button>Search</button>

</form>

<br>

<%
if(rsSearch!=null){

 while(rsSearch.next()){
   found=true;
%>

<div class="result">
<b><%=rsSearch.getString("category")%></b> —
₹ <%=rsSearch.getDouble("amount")%> —
<%=rsSearch.getString("expense_date")%>
</div>

<%
 }

 if(!found){
%>
<div style="color:red;font-weight:bold;">
No expenses found.
</div>
<%
 }
}
%>

</div>

</div>

</body>
</html>