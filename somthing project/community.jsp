<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community — something</title>

    <!-- ✅ FIXED CSS PATH -->
    <link rel="stylesheet" href="<%=ctx%>/css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>

<body>

<!-- ===== NAVBAR (FIXED) ===== -->
<header class="navbar">
    <div class="logo">
        <a href="<%=ctx%>/index.jsp">SOMETHING</a>
    </div>

    <nav>
        <a href="<%=ctx%>/index.jsp">Home</a>
        <a href="<%=ctx%>/products.jsp">Products</a>
        <a href="<%=ctx%>/community.jsp">Community</a>
        <a href="<%=ctx%>/about.jsp">About</a>

        <% if (userName != null) { %>
            <a href="<%=ctx%>/profile.jsp">Profile</a>
            <a href="<%=ctx%>/LogoutServlet">Logout</a>
        <% } else { %>
            <a href="<%=ctx%>/login.jsp">Login</a>
        <% } %>
    </nav>
</header>

<!-- ===== HERO ===== -->
<section class="hero" style="height:60vh;">
    <h1>Community</h1>
    <p>Connect. Share. Build together.</p>
</section>

<!-- ===== POSTS ===== -->
<section class="products">

    <h2>Latest Discussions</h2>

    <div class="product-grid">

        <div class="card">
            <h3>Phone (2) Experience</h3>
            <p>Users share real-world performance insights.</p>
            <button onclick="alert('Feature coming soon')">Read →</button>
        </div>

        <div class="card">
            <h3>Something OS Tips</h3>
            <p>Hidden features you didn’t know.</p>
            <button onclick="alert('Feature coming soon')">Explore →</button>
        </div>

        <div class="card">
            <h3>Design Talks</h3>
            <p>Minimalism and future tech discussions.</p>
            <button onclick="alert('Feature coming soon')">Join →</button>
        </div>

    </div>

</section>

<!-- ===== CTA ===== -->
<section class="hero" style="height:50vh;">
    <h1 style="font-size:40px;">Join the Conversation</h1>

    <!-- ✅ FIXED BUTTON LINK -->
    <button onclick="location.href='<%=ctx%>/signup.jsp'">
        Get Started →
    </button>
</section>

<!-- ===== FOOTER ===== -->
<footer>
    <p>© 2026 something Technology Ltd.</p>
</footer>

</body>
</html>