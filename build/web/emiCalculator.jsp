<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage","emi");

if(session.getAttribute("userEmail")==null){
    response.sendRedirect("index.html");
    return;
}

double EMI = 0;
double totalPayment = 0;
double totalInterest = 0;
boolean calculated = false;
String errorMessage = "";

if(request.getParameter("loan") != null){

    try{

        double P = Double.parseDouble(request.getParameter("loan"));
        double annualRate = Double.parseDouble(request.getParameter("rate"));
        double N = Double.parseDouble(request.getParameter("time"));

        if(P < 0 || annualRate < 0 || N <= 0){
            errorMessage = "⚠ Negative values are not allowed.";
        }
        else{

            double R = annualRate / 1200;

            if(R == 0){
                EMI = P / N;
            }
            else{
                EMI = (P * R * Math.pow(1+R,N)) /
                      (Math.pow(1+R,N) - 1);
            }

            totalPayment = EMI * N;
            totalInterest = totalPayment - P;

            calculated = true;
        }

    }catch(Exception e){
        errorMessage = "⚠ Invalid input values.";
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>EMI Calculator</title>

<style>

body{
margin:0;
font-family:Segoe UI;
background:#f4f6f9;
}

.main{
margin-left:240px;
padding:20px;
}

.card{
background:white;
padding:25px;
border-radius:12px;
box-shadow:0 3px 10px rgba(0,0,0,0.1);
width:400px;
}

input{
width:100%;
padding:10px;
margin-bottom:15px;
border-radius:6px;
border:1px solid #ccc;
}

button{
padding:10px 15px;
background:#2E86C1;
color:white;
border:none;
border-radius:6px;
cursor:pointer;
}

button:hover{
background:#1f6392;
}

.result{
margin-top:20px;
background:#eef4fb;
padding:15px;
border-radius:8px;
}

.error{
margin-top:15px;
background:#ffe6e6;
padding:10px;
border-radius:6px;
color:red;
font-weight:500;
}

</style>

</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<h2>🧮 EMI Calculator</h2>

<div class="card">

<form method="post">

Loan Amount (₹):
<input type="number" name="loan" min="0" required>

Interest Rate (% per year):
<input type="number" step="0.01" name="rate" min="0" required>

Time (Months):
<input type="number" name="time" min="1" required>

<button type="submit">Calculate EMI</button>

</form>

<% if(!errorMessage.equals("")){ %>

<div class="error">
<%= errorMessage %>
</div>

<% } %>

<% if(calculated){ %>

<div class="result">

<h3>Monthly EMI: ₹ <%=String.format("%.2f", EMI)%></h3>

<p>Total Payment: ₹ <%=String.format("%.2f", totalPayment)%></p>

<p>Total Interest: ₹ <%=String.format("%.2f", totalInterest)%></p>

</div>

<% } %>

</div>
</div>

</body>
</html>