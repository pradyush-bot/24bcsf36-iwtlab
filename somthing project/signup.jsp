<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");

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
    <title>Sign Up — Something</title>

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
        <h1>Join<br>Something.</h1>
        <p>Create your account and experience the future.</p>
    </div>

</div>

<!-- ===== RIGHT SIDE ===== -->
<div class="auth-right">

    <div class="auth-card">

        <h2>Create Account</h2>

        <% if (error != null) { %>
            <div class="auth-alert error">
                <%= error %>
            </div>
        <% } %>

        <form action="signupProcess.jsp" method="post" id="signupForm">

            <div class="field-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Your Name" required>
            </div>

            <div class="field-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="you@nothing.com" required>
            </div>
            
            <div class="field-group">
                <label>Shipping Address</label>
                <textarea name="address" placeholder="Enter your full shipping address" required style="width: 100%; padding: 14px; border: 1px solid var(--border); font-family: 'Inter', sans-serif; resize: vertical; min-height: 80px;"></textarea>
            </div>

            <div class="field-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <input type="password" name="password" id="signup-password" placeholder="Min. 8 characters" required>
                    <button type="button" class="toggle-password" onclick="togglePassword('signup-password', this)"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/><path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/></svg></button>
                </div>
                <div style="font-size: 11px; color: #666; margin-top: 8px;">
                    Must contain at least 8 characters, one uppercase, one lowercase, one number, and one special character.
                </div>
            </div>
            <div class="field-group">
                <label>Confirm Password</label>
                <div class="input-wrapper">
                    <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Re-enter password" required>
                    <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword', this)"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/><path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/></svg></button>
                </div>
            </div>

           <button type="submit" class="btn-auth" onclick="return validatePasswords()">
    Create Account →
</button>

        </form>

        <p class="auth-switch">
            Already have an account?
            <a href="login.jsp">Sign in</a>
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
    
    function validatePasswords() {
        const p1 = document.getElementById('signup-password').value;
        const p2 = document.getElementById('confirmPassword').value;
        
        // Regex: At least 8 chars, 1 uppercase, 1 lowercase, 1 number, 1 special char
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z0-9]).{8,}$/;
        
        if (!passwordRegex.test(p1)) {
            alert("Password must contain at least 8 characters, including uppercase, lowercase, a number, and a special character.");
            return false;
        }
        
        if (p1 !== p2) {
            alert("Passwords do not match!");
            return false;
        }
        return true;
    }
</script>

</body>
</html>