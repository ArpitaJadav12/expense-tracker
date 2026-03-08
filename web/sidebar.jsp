<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String activePage=(String)request.getAttribute("activePage");
if(activePage==null) activePage="";
%>

<style>
.sidebar{
    width:250px;
    height:100vh;
    background:#17233c;
    color:white;
    position:fixed;
    left:0;
    top:0;
    display:flex;
    flex-direction:column;
}

.sidebar h2{
    margin:20px;
    margin-bottom:10px;
    font-size:18px;
}

.menu{
    flex:1;
    overflow-y:auto;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:12px 20px;
    font-size:16px;
    transition:0.3s;
}

.sidebar a:hover{
    background:#243552;
}

.active{
    background:#2E86C1;
    font-weight:bold;
}

.bottom{
    border-top:1px solid rgba(255,255,255,0.2);
}
</style>

<div class="sidebar">

    <h2>Welcome, <%=session.getAttribute("userName")%></h2>

    <div class="menu">

        <!-- 1️⃣ PROFILE FIRST -->
        <a href="profile.jsp" class="<%=activePage.equals("profile")?"active":""%>">
            👤 Profile
        </a>

        <!-- 2️⃣ DASHBOARD -->
        <a href="home.jsp" class="<%=activePage.equals("home")?"active":""%>">
            🏠 Dashboard
        </a>

        <!-- 3️⃣ ADD EXPENSE -->
        <a href="addExpense.jsp" class="<%=activePage.equals("add")?"active":""%>">
            ➕ Add Expense
        </a>

        <!-- 4️⃣ VIEW EXPENSE -->
        <a href="viewExpense.jsp" class="<%=activePage.equals("view")?"active":""%>">
            📋 View Expenses
        </a>

        <!-- 6️⃣ MONTHLY REPORT -->
        <a href="report.jsp" class="<%=activePage.equals("report")?"active":""%>">
            📑 Monthly Report
        </a>

        <!-- 7️⃣ HISTORY COMPARISON -->
        <a href="HistoryComparison.jsp">
            📈 History Comparison
        </a>

        <!-- 8️⃣ BUDGET SEARCH -->
        <a href="budgetSearch.jsp">
            🔍 Budget Search
        </a>

        <!-- 9️⃣ SAVING TIPS -->
        <a href="tips.jsp" class="<%=activePage.equals("tips")?"active":""%>">
            💡 Saving Tips
        </a>

        <!-- 🔟 GOALS -->
        <a href="goals.jsp" class="<%=activePage.equals("goals")?"active":""%>">
            🏆 Saving Goals
        </a>

        <!-- 1️⃣1️⃣ EMI CALCULATOR -->
        <a href="emiCalculator.jsp" class="<%=activePage.equals("emi")?"active":""%>">
            🧮 EMI Calculator
        </a>

    </div>

    <!-- Bottom Section -->
    <div class="bottom">

        <a href="settings.jsp" class="<%=activePage.equals("settings")?"active":""%>">
            ⚙ Settings
        </a>

        <a href="#" onclick="showLogoutPopup();">
            🚪 Logout
        </a>

    </div>

</div>

<!-- Logout Popup -->
<div id="logoutPopup" style="
display:none;
position:fixed;
top:0;
left:0;
width:100%;
height:100%;
background:rgba(0,0,0,0.5);
justify-content:center;
align-items:center;
z-index:2000;
">
    <div style="
    background:white;
    padding:20px;
    border-radius:8px;
    text-align:center;
    width:300px;
    ">
        <p style="color:black; font-size:16px;">
            Are you sure you want to logout?
        </p>

        <button onclick="confirmLogout()"
                style="background:#e74c3c; color:white; border:none; padding:8px 15px; margin:5px; cursor:pointer;">
            Yes
        </button>

        <button onclick="closeLogoutPopup()"
                style="background:gray; color:white; border:none; padding:8px 15px; margin:5px; cursor:pointer;">
            No
        </button>
    </div>
</div>

<script>
function showLogoutPopup(){
    document.getElementById("logoutPopup").style.display="flex";
}
function closeLogoutPopup(){
    document.getElementById("logoutPopup").style.display="none";
}
function confirmLogout(){
    window.location.href="LogoutServlet";
}
</script>