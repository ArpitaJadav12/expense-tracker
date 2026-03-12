<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Login.DBConnection" %>

<%
if(session.getAttribute("userEmail")==null){
    response.sendRedirect("index.html");
    return;
}

if("POST".equalsIgnoreCase(request.getMethod())){

    String email = (String)session.getAttribute("userEmail");
    String category = request.getParameter("category");
    String amount = request.getParameter("amount");
    String expenseDate = request.getParameter("date");

    if(category!=null && amount!=null && expenseDate!=null){

        try{
            int amt = Integer.parseInt(amount);

            if(amt > 0){

                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                "INSERT INTO expenses(user_email,category,amount,expense_date) VALUES (?,?,?,?)"
                );

                ps.setString(1,email);
                ps.setString(2,category.trim());
                ps.setInt(3,amt);
                ps.setString(4,expenseDate);

                ps.executeUpdate();
                response.sendRedirect("home.jsp");
                return;

            } else {
                out.println("<p style='color:red;text-align:center;'>Amount must be greater than 0</p>");
            }

        }catch(Exception e){
            out.println("<p style='color:red;text-align:center;'>Invalid Amount</p>");
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Expense</title>

<style>

body{
    margin:0;
    font-family:Arial;
    background:#f4f6f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    font-size:16px;
}

.card{
    background:white;
    padding:40px;
    width:420px;
    border-radius:12px;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
    margin:auto;
}

h2{
    margin-bottom:5px;
    font-size:24px;
}

.subtitle{
    color:#777;
    font-size:15px;
    margin-bottom:20px;
}

label{
    font-size:16px;
    color:#444;
}

input,select{
    width:100%;
    padding:10px;
    margin-top:5px;
    margin-bottom:15px;
    box-sizing:border-box;
    font-size:15px;
}

button{
    width:100%;
    padding:12px;
    background:#2196F3;
    color:white;
    border:none;
    cursor:pointer;
    border-radius:4px;
    font-size:16px;
}

button:hover{
    background:#1976D2;
}

.goal-btn{
    margin-top:10px;
}

.tips{
    margin-top:20px;
    font-size:14px;
    color:#666;
}

.tips ul{
    padding-left:18px;
    margin-top:8px;
}

</style>

</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="card">

<h2>Add Expense</h2>

<p class="subtitle">
Track your spending by adding a new expense.
</p>

<form method="post">

<label>Category</label>
<select name="category" required>
<option value="">Select Category</option>
<option value="Food">🍔 Food</option>
<option value="Travel">✈️ Travel</option>
<option value="Shopping">🛍 Shopping</option>
<option value="Bills">💡 Bills</option>
<option value="Hospitals">🏥 Hospitals</option>
<option value="Stationary">📚 Stationary</option>
<option value="Other">📦 Other</option>
</select>

<label>Amount</label>
<input type="number" name="amount" min="1" step="1" placeholder="Enter Amount" required>

<label>Date</label>
<input type="date" name="date" value="<%= java.time.LocalDate.now() %>" required>

<button type="submit">Add Expense</button>

</form>

<div class="tips">
<b>Tips:</b>
<ul>
<li>Add expenses daily to track spending better</li>
<li>Use the correct category for accurate reports</li>
<li>Review your expenses regularly</li>
</ul>
</div>

<a href="goals.jsp">
<button type="button" class="goal-btn">
🎯 Set / View Savings Goal
</button>
</a>

</div>

</body>
</html>