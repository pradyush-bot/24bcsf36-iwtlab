<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error   = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");

    if (session.getAttribute("userName") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Something</title>

    <link rel="stylesheet" href="css/style.css?v=3">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>

<body class="auth-page">

<!-- ===== LEFT SIDE ===== -->
<div class="auth-left">

    <div class="auth-brand">
        <a href="index.jsp" class="auth-logo">SOMETHING</a>
    </div>

    <div class="auth-tagline">
        <h1>Welcome<br>back.</h1>
        <p>Sign in to continue your experience.</p>
    </div>

</div>

<!-- ===== RIGHT SIDE ===== -->
<div class="auth-right">

    <div class="auth-card">

        <h2>Sign In</h2>

        <% if (error != null) { %>
            <div class="auth-alert error">
                <%= error %>
            </div>
        <% } %>

        <% if (success != null) { %>
            <div class="auth-alert success">
                <%= success %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post" id="loginForm">

            <div class="field-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="you@nothing.com" required>
            </div>

            <div class="field-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <input type="password" name="password" id="login-password" placeholder="••••••••" required>
                    <button type="button" class="toggle-password" onclick="togglePassword('login-password', this)"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/><path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/></svg></button>
                </div>
            </div>

            <button type="submit" class="btn-auth">
                Sign In →
            </button>

        </form>

        <p class="auth-switch">
            Don’t have an account?
            <a href="signup.jsp">Create one</a>
        </p>

    </div>

</div>

<script src="js/script.js"></script>
<script>
    const eyeIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/><path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/></svg>';
    const eyeSlashIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7.028 7.028 0 0 0-2.79.588l.77.771A5.944 5.944 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.134 13.134 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755-.165.165-.337.328-.517.486z"/><path d="M11.297 9.176a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.829 2.829zm-2.943 1.299.822.822a3.5 3.5 0 0 1-4.474-4.474l.823.823a2.5 2.5 0 0 0 2.829 2.829"/><path d="M3.35 5.47c-.18.16-.353.322-.518.487A13.134 13.134 0 0 0 1.172 8l.195.288c.335.48.83 1.12 1.465 1.755C4.121 11.332 5.881 12.5 8 12.5c.716 0 1.39-.133 2.02-.36l.77.772A7.029 7.029 0 0 1 8 13.5C3 13.5 0 8 0 8s.939-1.721 2.641-3.238l.708.709zm10.296 8.884-12-12 .708-.708 12 12-.708.708"/></svg>';

    function togglePassword(inputId, btn) {
        const input = document.getElementById(inputId);
        if (input.type === 'password') {
            input.type = 'text';
            btn.innerHTML = eyeSlashIcon;
        } else {
            input.type = 'password';
            btn.innerHTML = eyeIcon;
        }
    }
</script>

</body>
</html>