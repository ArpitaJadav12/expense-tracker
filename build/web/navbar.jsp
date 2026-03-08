<%
    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null) {
        activePage = "";
    }
%>
<style>
    /* Remove default browser spacing */
    html, body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
    }

    /* Top Navigation Bar */
    .topnav {
        background-color: #2E86C1;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 55px;
        display: flex;
        align-items: center;
        z-index: 1000;
    }

    /* Links */
    .topnav a {
        color: white;
        padding: 18px 22px;
        text-decoration: none;
        font-weight: bold;
    }

    /* Hover */
    .topnav a:hover {
        background-color: #1B4F72;
    }
    .active{
    background:#222;
    color:white !important;
    padding:8px 12px;
    border-radius:6px;
}
</style>

<div class="topnav">
    <a href="home.jsp" class="<%= activePage.equals("home") ? "active" : ""%>">Home</a>
    <a href="addExpense.jsp" class="<%= activePage.equals("add") ? "active" : ""%>">Add Expense</a>
    <a href="viewExpense.jsp" class="<%= activePage.equals("view") ? "active" : ""%>">View Expense</a>
    <a href="report.jsp" class="<%= activePage.equals("report") ? "active" : ""%>">Report</a>
    

    
    
    <%-- <a href="home.jsp">Dashboard</a>
    <a href="addExpense.jsp">Add Expense</a>
    <a href="viewExpense.jsp">View Expense</a>
    <a href="report.jsp">Report</a>
    <a href="LogoutServlet">Logout</a> --%>
</div>