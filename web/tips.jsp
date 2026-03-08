<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<title>Saving Tips</title>

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

.tip-box{
    background:white;
    padding:20px;
    border-radius:12px;
    margin-bottom:15px;
    box-shadow:0 3px 10px rgba(0,0,0,0.08);
}

h2{
    color:#2E86C1;
}
</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<h2>💰 Smart Tips for Saving Money</h2>

<div class="tip-box">
<b>1. Track Every Expense</b><br>
Monitor daily spending to understand where your money goes.
</div>

<div class="tip-box">
<b>2. Follow 50/30/20 Rule</b><br>
50% needs, 30% wants, 20% savings.
</div>

<div class="tip-box">
<b>3. Set Monthly Budget</b><br>
Always plan expenses before the month starts.
</div>

<div class="tip-box">
<b>4. Avoid Impulse Buying</b><br>
Wait 24 hours before purchasing non-essential items.
</div>

<div class="tip-box">
<b>5. Automate Savings</b><br>
Transfer fixed amount to savings account automatically.
</div>

<div class="tip-box">
<b>6. Reduce Subscriptions</b><br>
Cancel unused apps and memberships.
</div>

<div class="tip-box">
<b>7. Compare Before Buying</b><br>
Check prices online before making purchase.
</div>

<div class="tip-box">
<b>8. Emergency Fund</b><br>
Keep at least 3–6 months expenses saved.
</div>

<div class="tip-box">
<b>9. Invest Wisely</b><br>
Start SIP or low-risk investments early.
</div>

<div class="tip-box">
<b>10. Review Monthly Reports</b><br>
Analyze your financial reports and improve weak areas.
</div>

</div>

</body>
</html>