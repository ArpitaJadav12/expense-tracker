<%-- 
    Document   : settings
    Created on : 8 Mar 2026, 1:39:39 pm
    Author     : ARPITA
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setAttribute("activePage","settings");

if(session.getAttribute("userEmail")==null){
    response.sendRedirect("index.html");
    return;
}

String userName = (String)session.getAttribute("userName");
if(userName == null) userName="";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Settings</title>

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

.section{
    background:white;
    border-radius:12px;
    margin-bottom:15px;
    box-shadow:0 3px 10px rgba(0,0,0,0.08);
    overflow:hidden;
}

.section-header{
    padding:15px 20px;
    cursor:pointer;
    font-weight:600;
    color:#2E86C1;
    background:#f9fbfd;
}

.section-header:hover{
    background:#eef4fb;
}

.section-content{
    display:none;
    padding:20px;
    border-top:1px solid #eee;
}

.option{
    margin:10px 0;
}

input[type="text"], input[type="email"], select{
    padding:6px;
    width:250px;
}

button{
    padding:6px 12px;
    background:#2E86C1;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
}

.toggle{
    transform:scale(1.1);
}

.hidden{
    display:none;
}

.slider{
    width:300px;
}

.danger{
    background:#e74c3c;
}
</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">
<h2>Application Settings</h2>

<!-- 1 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">1. Manage Your Account</div>
<div class="section-content">

<div class="option">
Name:
<input type="text" value="<%=userName%>" id="nameField">
<button id="saveBtn" class="hidden">Save</button>
</div>

<div class="option">
Email:
<input type="email" value="<%=session.getAttribute("userEmail")%>" readonly>
</div>

<div class="option">
<button>Export CSV</button>
<button>Export PDF</button>
</div>

<div class="option">
Cloud Sync
<input type="checkbox" class="toggle" onclick="showSync(this)">
<span id="syncText" class="hidden">Last synced: 2 mins ago</span>
</div>

<div class="option">
Account Status:
<select>
<option>Active</option>
<option>Private</option>
<option>Hidden</option>
</select>
</div>

</div>
</div>

<!-- 2 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">2. Account & Security</div>
<div class="section-content">

<div class="option">Privacy Mode <input type="checkbox" class="toggle"></div>

<div class="option">
Two-Factor Auth
<input type="checkbox" class="toggle" onclick="show2FA(this)">
<div id="twofaBox" class="hidden">
<br>Enter Code: <input type="text">
</div>
</div>

<div class="option">
Session Timeout:
<input type="range" min="5" max="60" value="15" class="slider">
</div>

<div class="option">Remember Me <input type="checkbox" class="toggle"></div>

</div>
</div>

<!-- 3 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">3. Notification & Smart Alerts</div>
<div class="section-content">

<div class="option">
Alert me when I spend over:
<input type="checkbox" class="toggle">
<input type="text" placeholder="₹ 500">
</div>

<div class="option">Weekly Digest <input type="checkbox" class="toggle"></div>
<div class="option">Smart Subscription Detection <input type="checkbox" class="toggle"></div>
<div class="option">Browser Push Notifications <input type="checkbox" class="toggle"></div>

</div>
</div>

<!-- 4 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">4. Advanced Financial Tools</div>
<div class="section-content">

<div class="option">Auto-Categorization <input type="checkbox" class="toggle"></div>

<div class="option">
Round Up Transactions
<input type="checkbox" class="toggle" onclick="showRound(this)">
<select id="roundBox" class="hidden">
<option>$1.00</option>
<option>$5.00</option>
<option>$10.00</option>
</select>
</div>

<div class="option">
Multi-Currency Support
<input type="checkbox" class="toggle" onclick="showCurrency(this)">
<div id="currencyBox" class="hidden">
<br>
<input type="checkbox"> USD
<input type="checkbox"> EUR
<input type="checkbox"> GBP
</div>
</div>

<div class="option">Tax Mode <input type="checkbox" class="toggle"></div>

</div>
</div>

<!-- 5 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">5. Appearance & Personalization</div>
<div class="section-content">
<div class="option">Dark Mode <input type="checkbox" class="toggle"></div>
<div class="option">
Theme Color
<select>
<option>Blue</option>
<option>Green</option>
<option>Purple</option>
</select>
</div>
<div class="option">
Font Size
<select>
<option>Small</option>
<option>Medium</option>
<option>Large</option>
</select>
</div>
</div>
</div>

<!-- 6 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">6. Payment & Banking</div>
<div class="section-content">
<div class="option">
Default Payment
<select>
<option>UPI</option>
<option>Card</option>
<option>Cash</option>
</select>
</div>
<div class="option">Recurring Expense Auto Add <input type="checkbox" class="toggle"></div>
<div class="option">EMI Tracker <input type="checkbox" class="toggle"></div>
</div>
</div>

<!-- 7 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">7. Data & Backup</div>
<div class="section-content">
<div class="option">
Auto Backup
<select>
<option>Daily</option>
<option>Weekly</option>
<option>Monthly</option>
</select>
</div>
<div class="option"><button class="danger">Delete All Data</button></div>
<div class="option"><button>Restore Backup</button></div>
</div>
</div>

<!-- 8 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">8. AI Smart Controls</div>
<div class="section-content">
<div class="option">Smart Budget Suggestion <input type="checkbox" class="toggle"></div>
<div class="option">Expense Pattern Prediction <input type="checkbox" class="toggle"></div>
<div class="option">Unusual Spending Alert <input type="checkbox" class="toggle"></div>
</div>
</div>

<!-- 9 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">9. Regional & Currency</div>
<div class="section-content">
<div class="option">
Default Currency
<select>
<option>₹ INR</option>
<option>$ USD</option>
<option>€ EUR</option>
</select>
</div>

<div class="option">
Language
<select>
<option>English</option>
<option>Hindi</option>
<option>Gujarati</option>
</select>
</div>

<div class="option">
Financial Year Start
<select>
<option>January</option>
<option>February</option>
<option>March</option>
<option>April</option>
<option>May</option>
<option>June</option>
<option>July</option>
<option>August</option>
<option>September</option>
<option>October</option>
<option>November</option>
<option>December</option>
</select>
</div>

</div>
</div>

<!-- 10 -->
<div class="section">
<div class="section-header" onclick="toggleSection(this)">10. Extra Security</div>
<div class="section-content">
<div class="option">Login Activity Log <button>View</button></div>
<div class="option">Device Management <button>Manage</button></div>
<div class="option">Security Alert Email <input type="checkbox" class="toggle"></div>
</div>
</div>

</div>

<script>
function toggleSection(header){

    var content = header.nextElementSibling;
    var isOpen = content.style.display === "block";

    var allSections = document.querySelectorAll(".section-content");
    for(var i=0; i<allSections.length; i++){
        allSections[i].style.display = "none";
    }

    if(!isOpen){
        content.style.display = "block";
    }
}

document.getElementById("nameField").addEventListener("input",function(){
document.getElementById("saveBtn").classList.remove("hidden");
});

function showSync(el){
document.getElementById("syncText").classList.toggle("hidden",!el.checked);
}
function show2FA(el){
document.getElementById("twofaBox").classList.toggle("hidden",!el.checked);
}
function showRound(el){
document.getElementById("roundBox").classList.toggle("hidden",!el.checked);
}
function showCurrency(el){
document.getElementById("currencyBox").classList.toggle("hidden",!el.checked);
}
</script>

</body>
</html>