<%-- 
    Document   : logout
    Created on : 8 Mar 2026, 1:41:05 pm
    Author     : ARPITA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Logged Out</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #2E86C1, #28B463);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.card {
    background: white;
    padding: 40px;
    width: 350px;
    text-align: center;
    border-radius: 10px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    background-color: #2E86C1;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
}

.btn:hover {
    background-color: #1B4F72;
}
</style>

</head>
<body>

<div class="card">
    <h2>Logged Out</h2>
    <hr>
    <p>You have successfully logged out.</p>
    <a href="index.html" class="btn">Login Again</a>
</div>

</body>
</html>

