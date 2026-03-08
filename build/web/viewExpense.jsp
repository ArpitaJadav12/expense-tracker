<%-- viewExpense.jsp --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Login.DBConnection"%>

<%
if(session.getAttribute("userEmail")==null){
    response.sendRedirect("index.html");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Expenses</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#f5f5f5;
    margin:0;
    padding:0;
}

.container{
    margin-left:260px;
    margin-top:20px;
    width:calc(100% - 300px);
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
}

h2{
    text-align:center;
}

table{
    width:100%;
    border-collapse:collapse;
}

th, td{
    padding:10px;
    border:1px solid #ddd;
    text-align:center;
}

th{
    background:#4CAF50;
    color:white;
}

.delete-btn{
    background:#2196F3;
    color:white;
    border:none;
    padding:6px 12px;
    border-radius:5px;
    cursor:pointer;
}

.delete-btn:hover{
    background:#1976D2;
}

.add-expense-section{
    margin-top:20px;
    text-align:center;
}

.yes-btn{
    background:#4CAF50;
    color:white;
    border:none;
    padding:8px 16px;
    border-radius:5px;
    cursor:pointer;
}

.no-btn{
    background:#607D8B;
    color:white;
    border:none;
    padding:8px 16px;
    border-radius:5px;
    cursor:pointer;
}

</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="container">

<h2>Your Expenses</h2>

<table>
<tr>
    <th>ID</th>
    <th>Category</th>   <!-- ⭐ ADDED -->
    <th>Amount</th>
    <th>Date</th>
    <th>Action</th>
</tr>

<%
Connection con = DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement("SELECT * FROM expenses WHERE user_email=?");

ps.setString(1, session.getAttribute("userEmail").toString());

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
    <td><%= rs.getInt("id") %></td>

    <!-- ⭐ CATEGORY DISPLAY -->
    <td><%= rs.getString("category") %></td>

    <td>₹ <%= rs.getDouble("amount") %></td>
    <td><%= rs.getDate("expense_date") %></td>

    <td>
        <form action="DeleteExpenseServlet" method="post"
              onsubmit="return confirm('Delete this expense?');">

            <input type="hidden"
                   name="id"
                   value="<%= rs.getInt("id") %>">

            <input type="submit"
                   value="Delete"
                   class="delete-btn">
        </form>
    </td>
</tr>

<%
}
rs.close();
ps.close();
con.close();
%>

</table>

<div class="add-expense-section">
    <h3>Do you want to add another expense?</h3>

    <a href="addExpense.jsp">
        <button type="button" class="yes-btn">Yes</button>
    </a>

    <button type="button" class="no-btn"
        onclick="alert('Okay 👍 Continue viewing expenses');">
        No
    </button>
</div>

</div>
</body>
</html>