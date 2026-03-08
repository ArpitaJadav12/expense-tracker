<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Expense Tracker - Register</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins', sans-serif;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background: linear-gradient(135deg, #141E30, #243B55);
    overflow:hidden;
}

/* Animated background circles */

body::before, body::after{
    content:"";
    position:absolute;
    width:500px;
    height:500px;
    background:rgba(255,255,255,0.05);
    border-radius:50%;
    animation: float 8s infinite alternate;
}

body::before{
    top:-150px;
    left:-150px;
}

body::after{
    bottom:-150px;
    right:-150px;
}

@keyframes float{
    from{transform:translateY(0px);}
    to{transform:translateY(50px);}
}

/* Register Card */

.register-card{
    position:relative;
    width:380px;
    padding:45px;
    border-radius:20px;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(25px);
    box-shadow:0 25px 45px rgba(0,0,0,0.4);
    color:white;
}

.register-card h2{
    text-align:center;
    margin-bottom:35px;
    font-weight:600;
    letter-spacing:1px;
}

/* Input fields */

.input-group{
    position:relative;
    margin-bottom:25px;
}

.input-group input{
    width:100%;
    padding:14px;
    border:none;
    outline:none;
    border-radius:10px;
    background:rgba(255,255,255,0.15);
    color:white;
    font-size:14px;
}

.input-group label{
    position:absolute;
    left:14px;
    top:14px;
    color:#ddd;
    font-size:14px;
    transition:0.3s;
    pointer-events:none;
}

.input-group input:focus + label,
.input-group input:valid + label{
    top:-10px;
    left:10px;
    font-size:12px;
    background:#243B55;
    padding:2px 8px;
    border-radius:6px;
}

/* Button */

button{
    width:100%;
    padding:14px;
    border:none;
    border-radius:10px;
    background:linear-gradient(45deg, #00c6ff, #0072ff);
    color:white;
    font-weight:600;
    cursor:pointer;
    transition:0.3s;
    letter-spacing:1px;
}

button:hover{
    transform:scale(1.05);
    box-shadow:0 10px 20px rgba(0,0,0,0.4);
}

/* Login link */

.login{
    text-align:center;
    margin-top:18px;
    font-size:14px;
}

.login a{
    color:#00c6ff;
    font-weight:600;
    text-decoration:none;
}

.login a:hover{
    text-decoration:underline;
}

</style>

<script>
function validateForm(){

    var password=document.forms["regForm"]["password"].value;
    var confirm=document.forms["regForm"]["confirm"].value;

    if(password!==confirm){
        alert("Passwords do not match!");
        return false;
    }

    return true;
}
</script>

</head>

<body>

<div class="register-card">

<h2>Expense Tracker</h2>

<form name="regForm" action="RegisterServlet" method="post" onsubmit="return validateForm()">

<div class="input-group">
<input type="text" name="firstName" required>
<label>First Name</label>
</div>

<div class="input-group">
<input type="text" name="lastName" required>
<label>Last Name</label>
</div>

<div class="input-group">
<input type="email" name="email" required>
<label>Email Address</label>
</div>

<div class="input-group">
<input type="password" name="password" required>
<label>Password</label>
</div>

<div class="input-group">
<input type="password" name="confirm" required>
<label>Confirm Password</label>
</div>

<button type="submit">REGISTER</button>

</form>

<div class="login">
Already have account? <a href="index.html">Login</a>
</div>

</div>

</body>
</html>