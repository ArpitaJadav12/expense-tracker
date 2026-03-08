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

            if(amt > 0){   // ✅ amount must be greater than zero

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
}
.card{
    background:white;
    padding:30px;
    width:350px;
    border-radius:10px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}
input,select{
    width:100%;
    padding:8px;
    margin-bottom:15px;
    box-sizing:border-box;   /* ✅ makes all fields same size */
}
button{
    width:100%;
    padding:10px;
    background:#2196F3;
    color:white;
    border:none;
    cursor:pointer;
}
</style>

</head>
<body>
<jsp:include page="sidebar.jsp"/>

<div class="card">
<h3>Add Expense</h3>

<form method="post">

<select name="category" required>
<option value="">Select</option>
<option value="Food">Food</option>
<option value="Travel">Travel</option>
<option value="Shopping">Shopping</option>
<option value="Bills">Bills</option>
<option value="Hospitals">Hospitals</option>
<option value="Stationary">Stationary</option>
<option value="Other">Other</option>
</select>

<input type="number" name="amount" min="1" required>  <!-- ✅ HTML validation -->

<input type="date" name="date" required>

<button type="submit">Add</button>

</form>
</div>

</body>
</html>