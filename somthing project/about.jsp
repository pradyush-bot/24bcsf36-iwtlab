<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About — Nothing</title>

    <!-- ✅ FIXED CSS PATH -->
    <link rel="stylesheet" href="<%=ctx%>/css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>

<body>

<!-- ===== NAVBAR (FIXED) ===== -->
<header class="navbar">
    <div class="logo">
        <a href="<%=ctx%>/index.jsp">NOTHING</a>
    </div>

    <nav>
        <a href="<%=ctx%>/index.jsp">Home</a>
        <a href="<%=ctx%>/products.jsp">Products</a>
        <a href="<%=ctx%>/community.jsp">Community</a>
        <a href="<%=ctx%>/about.jsp">About</a>
    </nav>
</header>

<!-- ===== HERO ===== -->
<section class="hero" style="height:60vh;">
    <h1>About</h1>
    <p>We remove the unnecessary.</p>
</section>

<!-- ===== CONTENT ===== -->
<section class="products" style="max-width:800px; margin:auto;">

    <h2>Our Philosophy</h2>
    <p style="margin-top:20px; color:#666; line-height:1.6;">
        Something is built on the idea that technology should feel effortless.
        We strip away the noise, leaving only what matters — design, performance,
        and a seamless experience.
    </p>

    <h2 style="margin-top:60px;">Design First</h2>
    <p style="margin-top:20px; color:#666; line-height:1.6;">
        Every product is crafted with precision. Transparent aesthetics,
        bold minimalism, and purposeful engineering define everything we create.
    </p>

    <h2 style="margin-top:60px;">Future Vision</h2>
    <p style="margin-top:20px; color:#666; line-height:1.6;">
        We aim to redefine how people interact with technology —
        making it more human, more intuitive, and more meaningful.
    </p>

</section>

<!-- ===== CTA ===== -->
<section class="hero" style="height:50vh;">
    <h1 style="font-size:40px;">Experience the Difference</h1>

    <!-- ✅ FIXED BUTTON LINK -->
    <button onclick="location.href='<%=ctx%>/products.jsp'">
        Explore Products →
    </button>
</section>

<!-- ===== FOOTER ===== -->
<footer>
    <p>© 2026 Something Technology Ltd.</p>
</footer>

</body>
</html>