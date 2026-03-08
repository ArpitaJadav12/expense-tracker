<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage","goals");

if(session.getAttribute("goals")==null){
session.setAttribute("goals", new java.util.ArrayList<String>());
}

java.util.List<String> goals =
(java.util.List<String>)session.getAttribute("goals");

if(request.getParameter("goalName")!=null){
String g = request.getParameter("goalName");
goals.add(g);
response.sendRedirect("goals.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<style>
body{margin:0;font-family:Segoe UI;background:#f4f6f9;}
.main{margin-left:240px;padding:20px;}
.card{background:white;padding:20px;margin-bottom:15px;
border-radius:10px;box-shadow:0 3px 8px rgba(0,0,0,0.1);}
button{padding:6px 12px;background:#2E86C1;color:white;border:none;border-radius:5px;}
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
for(String g : goals){
%>
<div class="card">
<h3><%=g%></h3>
</div>
<%
}
%>

</div>
</body>
</html>