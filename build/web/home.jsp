<%@page import="java.sql.*"%>
<%@page import="Login.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
if(session.getAttribute("userEmail")==null){
    response.sendRedirect("index.html");
    return;
}

/* ✅ Active Page for Sidebar */
request.setAttribute("activePage","home");

Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
String email = (String)session.getAttribute("userEmail");

// TOTAL EXPENSE
ResultSet rsTotal = st.executeQuery(
"SELECT SUM(amount) AS total FROM expenses WHERE user_email='"+email+"'"
);
int totalExpense = 0;
if(rsTotal.next() && rsTotal.getInt("total")!=0){
    totalExpense = rsTotal.getInt("total");
}

// MONTH EXPENSE
ResultSet rsMonth = st.executeQuery(
"SELECT SUM(amount) AS monthTotal FROM expenses WHERE user_email='"+email+
"' AND MONTH(expense_date)=MONTH(CURDATE()) AND YEAR(expense_date)=YEAR(CURDATE())"
);
int monthExpense = 0;
if(rsMonth.next() && rsMonth.getInt("monthTotal")!=0){
    monthExpense = rsMonth.getInt("monthTotal");
}

// TODAY EXPENSE
ResultSet rsToday = st.executeQuery(
"SELECT SUM(amount) AS todayTotal FROM expenses WHERE user_email='"+email+
"' AND DATE(expense_date)=CURDATE()"
);
int todayExpense = 0;
if(rsToday.next() && rsToday.getInt("todayTotal")!=0){
    todayExpense = rsToday.getInt("todayTotal");
}

// CATEGORY DATA
int food=0, travel=0, shopping=0, bills=0, hospitals=0, stationary=0, other=0;

ResultSet rsCategory = st.executeQuery(
"SELECT category, SUM(amount) AS total FROM expenses WHERE user_email='"+email+"' GROUP BY category"
);

while(rsCategory.next()){
    String cat = rsCategory.getString("category").trim();
    int total = rsCategory.getInt("total");

    if(cat.equals("Food")) food = total;
    else if(cat.equals("Travel")) travel = total;
    else if(cat.equals("Shopping")) shopping = total;
    else if(cat.equals("Bills")) bills = total;
    else if(cat.equals("Hospitals")) hospitals = total;
    else if(cat.equals("Stationary")) stationary = total;
    else if(cat.equals("Other")) other = total;
}

String labels = "'Food','Travel','Shopping','Bills','Hospitals','Stationary','Other'";
String data = food+","+travel+","+shopping+","+bills+","+hospitals+","+stationary+","+other;

// MONTHLY DATA
ResultSet rsLine = st.executeQuery(
"SELECT MONTH(expense_date) AS month, SUM(amount) AS total FROM expenses WHERE user_email='"+email+"' GROUP BY MONTH(expense_date)"
);

int[] monthly = new int[12];
while(rsLine.next()){
    monthly[rsLine.getInt("month")-1] = rsLine.getInt("total");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

<style>
body{
    margin:0;
    font-family:Arial;
    background:#f4f6f9;
    overflow:hidden;
}
.main{
    margin-left:240px;
    padding:15px;
    height:100vh;
    box-sizing:border-box;
}
.cards{
    display:flex;
    justify-content:space-between;
}
.card{
    background:white;
    width:32%;
    padding:15px;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
    text-align:center;
}
.charts{
    display:flex;
    margin-top:15px;
    height:60vh;
}
.left-chart{
    width:35%;
    background:white;
    border-radius:10px;
    padding:15px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
    display:flex;
    align-items:center;
    justify-content:center;
}
.right-chart{
    width:63%;
    margin-left:2%;
    background:white;
    border-radius:10px;
    padding:15px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
}
canvas{
    max-height:100%;
}
</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<h3>Welcome, <%=session.getAttribute("userName")%></h3>

<div class="cards">
    <div class="card">
        <h4>Total Expense</h4>
        <h2>₹ <%=totalExpense%></h2>
    </div>

    <div class="card">
        <h4>This Month</h4>
        <h2>₹ <%=monthExpense%></h2>
    </div>

    <div class="card">
        <h4>Today</h4>
        <h2>₹ <%=todayExpense%></h2>
    </div>
</div>

<div class="charts">

<div class="left-chart">
<canvas id="pieChart"></canvas>
</div>

<div class="right-chart">
<canvas id="lineChart"></canvas>
</div>

</div>

<!-- ✅ Saving Tips Button Added -->
<hr>
<div style="margin-top:15px;">
    <a href="tips.jsp">
        <button style="padding:8px 15px; background:#2E86C1; color:white; border:none; border-radius:5px;">
            💰 Saving Tips
        </button>
    </a>
</div>

</div>

<script>

Chart.register(ChartDataLabels);

// PIE CHART
new Chart(document.getElementById("pieChart"),{
    type:'pie',
    data:{
        labels:[<%=labels%>],
        datasets:[{
            data:[<%=data%>],
            backgroundColor:[
                '#4CAF50','#2196F3','#FF9800',
                '#E91E63','#9C27B0','#009688','#795548'
            ]
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false,
        plugins:{
            legend:{
                position:'right',
                align:'end'
            },
            datalabels:{
                color:'#fff',
                font:{weight:'bold',size:13},
                formatter:function(value,context){
                    if(value===0) return "";
                    let data=context.chart.data.datasets[0].data;
                    let total=data.reduce((a,b)=>a+b,0);
                    return ((value*100)/total).toFixed(1)+"%";
                }
            }
        }
    }
});

// LINE CHART
new Chart(document.getElementById("lineChart"),{
    type:'line',
    data:{
        labels:["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
        datasets:[{
            label:"Monthly Expense",
            data:[
                <%=monthly[0]%>,<%=monthly[1]%>,<%=monthly[2]%>,
                <%=monthly[3]%>,<%=monthly[4]%>,<%=monthly[5]%>,
                <%=monthly[6]%>,<%=monthly[7]%>,<%=monthly[8]%>,
                <%=monthly[9]%>,<%=monthly[10]%>,<%=monthly[11]%>
            ],
            borderColor:'#2196F3',
            tension:0.4,
            fill:false
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false
    }
});

</script>

</body>
</html>