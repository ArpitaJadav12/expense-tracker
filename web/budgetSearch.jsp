<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Login.DBConnection"%>

<%
if(session.getAttribute("userEmail")==null){
    response.sendRedirect("index.html");
    return;
}

request.setAttribute("activePage","budget");

String email=(String)session.getAttribute("userEmail");

Connection con=DBConnection.getConnection();

/* ================= SAVE / UPDATE BUDGET ================= */

String newBudget=request.getParameter("newBudget");

if(newBudget!=null && !newBudget.trim().equals("")){

    double budgetValue = Double.parseDouble(newBudget);

    if(budgetValue >= 0){

        PreparedStatement check=con.prepareStatement(
        "SELECT * FROM budget WHERE user_email=?");

        check.setString(1,email);

        ResultSet rsCheck=check.executeQuery();

        if(rsCheck.next()){

            PreparedStatement update=con.prepareStatement(
            "UPDATE budget SET amount=? WHERE user_email=?");

            update.setDouble(1,budgetValue);
            update.setString(2,email);
            update.executeUpdate();

        }else{

            PreparedStatement insert=con.prepareStatement(
            "INSERT INTO budget(user_email,amount) VALUES(?,?)");

            insert.setString(1,email);
            insert.setDouble(2,budgetValue);
            insert.executeUpdate();
        }
    }
}

/* ================= FETCH BUDGET ================= */

double budget=0,total=0;

PreparedStatement b=con.prepareStatement(
"SELECT amount FROM budget WHERE user_email=?");

b.setString(1,email);

ResultSet rsBudget=b.executeQuery();

if(rsBudget.next())
    budget=rsBudget.getDouble(1);

/* ================= FETCH EXPENSE TOTAL ================= */

PreparedStatement t=con.prepareStatement(
"SELECT SUM(amount) FROM expenses WHERE user_email=?");

t.setString(1,email);

ResultSet rsTotal=t.executeQuery();

if(rsTotal.next())
    total=rsTotal.getDouble(1);

/* ================= CALCULATIONS ================= */

double remaining=budget-total;
double used=0;

if(budget>0)
    used=(total/budget)*100;

/* ================= STATUS ================= */

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

/* ================= SEARCH ================= */

String cat=request.getParameter("category");
String sDate=request.getParameter("searchDate");

PreparedStatement searchStmt=null;
ResultSet rsSearch=null;
boolean found=false;

if(cat!=null && sDate!=null && !cat.equals("") && !sDate.equals("")){

    searchStmt=con.prepareStatement(
    "SELECT amount FROM expenses WHERE user_email=? AND category=? AND expense_date=?");

    searchStmt.setString(1,email);
    searchStmt.setString(2,cat);
    searchStmt.setString(3,sDate);

    rsSearch=searchStmt.executeQuery();
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

button:hover{
background:#2563eb;
}

.result{
padding:10px;
border-bottom:1px solid #eee;
}

</style>

</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<h2>💰 Smart Budget System</h2>

<!-- ================= BUDGET ================= -->

<div class="card">

<h3>Set Monthly Budget</h3>

<form method="get">

<input type="number"
name="newBudget"
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

<div><b><%=msg%></b></div>

</div>

<!-- ================= SEARCH ================= -->

<div class="card">

<h3>🔎 Search Expense</h3>

<form method="get">

<select name="category" required>

<option value="">Select Category</option>

<option value="Food">Food</option>
<option value="Travel">Travel</option>
<option value="Shopping">Shopping</option>
<option value="Bills">Bills</option>
<option value="Hospitals">Hospitals</option>
<option value="Stationary">Stationary</option>
<option value="Other">Other</option>

</select>

<input type="date" name="searchDate" required>

<button>Search</button>

</form>

<br>

<%
if(rsSearch!=null){

while(rsSearch.next()){
found=true;
%>

<div class="result">

💰 Amount = ₹ <%=rsSearch.getDouble("amount")%>

</div>

<%
}

if(!found){
%>

<div style="color:red;font-weight:bold;">
No expense on this date for this category
</div>

<%
}
}
%>

</div>

</div>

</body>
</html>