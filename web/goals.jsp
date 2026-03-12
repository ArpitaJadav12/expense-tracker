<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
request.setAttribute("activePage","goals");

if(session.getAttribute("goals")==null){
    session.setAttribute("goals", new java.util.ArrayList<String>());
}

java.util.List<String> goals =
(java.util.List<String>)session.getAttribute("goals");

/* Add new goal */
if(request.getParameter("goalName")!=null){
    String g = request.getParameter("goalName") + "|pending";
    goals.add(g);
    response.sendRedirect("goals.jsp");
}

/* Toggle goal status */
if(request.getParameter("toggle")!=null){

    int index = Integer.parseInt(request.getParameter("toggle"));

    String item = goals.get(index);
    String[] parts = item.split("\\|");

    String name = parts[0];
    String status = "pending";

    if(parts.length > 1){
        status = parts[1];
    }

    String newStatus = status.equals("completed") ? "pending" : "completed";

    goals.set(index, name + "|" + newStatus);

    response.sendRedirect("goals.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>

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
padding:20px;
margin-bottom:15px;
border-radius:10px;
box-shadow:0 3px 8px rgba(0,0,0,0.1);
}

button{
padding:6px 12px;
background:#2E86C1;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
}

.goal-row{
display:flex;
justify-content:space-between;
align-items:center;
}

.completed{
text-decoration:line-through;
color:gray;
}

.status{
font-size:13px;
padding:4px 8px;
border-radius:5px;
}

.pending{
background:#fce4ec;
color:#c2185b;
}

.done{
background:#e8f5e9;
color:#2e7d32;
}

</style>

</head>

<body>

<jsp:include page="sidebar.jsp"/>

<div class="main">

<h2>🏆 Saving Goals</h2>

<div class="card">

<form method="post">

Add New Goal:
<input type="text" name="goalName" required>

<button>Add Goal</button>

</form>

</div>

<%
int i = 0;

for(String g : goals){

String[] parts = g.split("\\|");

String name = parts[0];
String status = "pending";

if(parts.length > 1){
    status = parts[1];
}
%>

<div class="card">

<div class="goal-row">

<h3 class="<%=status.equals("completed") ? "completed" : ""%>">
<%=name%>
</h3>

<span class="status <%=status.equals("completed") ? "done" : "pending"%>">
<%=status.equals("completed") ? "Completed" : "Pending"%>
</span>

<form method="post" style="margin-left:15px;">
<input type="hidden" name="toggle" value="<%=i%>">
<button type="submit">
<%=status.equals("completed") ? "Undo" : "Mark Done"%>
</button>
</form>

</div>

</div>

<%
i++;
}
%>

</div>

</body>
</html>