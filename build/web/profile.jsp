<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
request.setAttribute("activePage","profile");

String name = (String)session.getAttribute("userName");
if(name==null) name="User";

if(request.getParameter("newName")!=null){
session.setAttribute("userName", request.getParameter("newName"));
response.sendRedirect("profile.jsp");
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
<h2>👤 Profile</h2>

<div class="card">
<h3>Name: <%=name%></h3>
<form method="post">
<input type="text" name="newName" placeholder="Change Name">
<button>Update</button>
</form>
</div>

<div class="card">
<h3>Email</h3>
<p><%=session.getAttribute("userEmail")%></p>
</div>

<div class="card">
<h3>Account Type</h3>
<p>Premium User</p>
</div>

<div class="card">
<a href="logout.jsp"><button>Logout</button></a>
</div>

</div>
</body>
</html>