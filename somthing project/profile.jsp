<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.nothing.dao.DBConnection" %>
<%
    String ctx = request.getContextPath();
    String userName = (String) session.getAttribute("userName");
    
    // Redirect to login if user is not authenticated
    if (userName == null) {
        response.sendRedirect(ctx + "/login.jsp");
        return;
    }
    
    String address = "No address on file.";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT address FROM users WHERE name = ?")) {
         stmt.setString(1, userName);
         try (ResultSet rs = stmt.executeQuery()) {
             if (rs.next()) {
                 String dbAddr = rs.getString("address");
                 if (dbAddr != null && !dbAddr.trim().isEmpty()) {
                     address = dbAddr;
                 }
             }
         }
    } catch(Exception e) { }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Profile — NothingStore</title>
    
    <link rel="stylesheet" href="<%=ctx%>/css/style.css?v=3">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <style>
        .profile-container {
            max-width: 900px;
            margin: 140px auto 80px;
            padding: 0 40px;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 60px;
        }
        .profile-header h1 {
            font-size: 48px;
            font-weight: 600;
            letter-spacing: -2px;
            margin-bottom: 15px;
        }
        .profile-header p {
            color: #666;
            font-size: 16px;
        }
        .profile-section {
            margin-bottom: 50px;
        }
        .profile-section h2 {
            font-size: 20px;
            font-weight: 500;
            border-bottom: 1px solid var(--border);
            padding-bottom: 15px;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .address-card {
            border: 1px solid var(--border);
            background: #fafafa;
            padding: 30px;
            font-size: 15px;
            line-height: 1.6;
            color: #333;
        }
        
        .order-card {
            border: 1px solid var(--border);
            background: white;
            padding: 30px;
            margin-bottom: 20px;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        .order-meta {
            font-size: 13px;
            color: #666;
            display: flex;
            gap: 30px;
        }
        .order-meta div span {
            display: block;
            font-weight: 600;
            color: black;
            margin-bottom: 4px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 11px;
        }
        .order-items {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        .order-item {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .order-item img {
            width: 60px;
            height: 60px;
            object-fit: contain;
            background: #f7f7f7;
            padding: 5px;
        }
        .order-item-info h4 {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 4px;
        }
        .order-item-info p {
            font-size: 13px;
            color: #666;
            margin: 0;
        }
        .no-orders {
            text-align: center;
            padding: 60px 0;
            border: 1px solid var(--border);
            background: #fafafa;
        }
    </style>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<header class="navbar" id="navbar">
    <div class="logo">
        <a href="<%=ctx%>/index.jsp">SOMETHING</a>
    </div>
    <nav id="navLinks">
        <a href="<%=ctx%>/index.jsp">Home</a>
        <a href="<%=ctx%>/products.jsp">Products</a>
        <a href="<%=ctx%>/community.jsp">Community</a>
        <a href="<%=ctx%>/cart.jsp" id="nav-cart-link" style="position:relative;">
            Cart
            <span id="nav-cart-badge" style="display:none;position:absolute;top:-8px;right:-12px;background:black;color:white;border-radius:50%;width:16px;height:16px;font-size:10px;line-height:16px;text-align:center;"></span>
        </a>
        <a href="<%=ctx%>/profile.jsp">Profile</a>
        <a href="<%=ctx%>/LogoutServlet">Logout</a>
    </nav>
</header>

<!-- ===== PROFILE PAGE ===== -->
<main class="profile-container">
    <div class="profile-header">
        <h1>Hello, <%= userName %>.</h1>
        <p>Welcome to your personal account.</p>
    </div>
    
    <div class="profile-section">
        <h2>Shipping Address</h2>
        <div class="address-card">
            <%= address.replace("\n", "<br>") %>
        </div>
    </div>
    
    <div class="profile-section">
        <h2>Order History</h2>
        
        <%
            boolean hasOrders = false;
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM orders WHERE user_name = ? ORDER BY order_date DESC")) {
                 stmt.setString(1, userName);
                 try (ResultSet rs = stmt.executeQuery()) {
                     while(rs.next()) {
                         hasOrders = true;
                         int id = rs.getInt("id");
                         Timestamp date = rs.getTimestamp("order_date");
                         double total = rs.getDouble("total_amount");
                         String detailsJson = rs.getString("order_data");
        %>
        
        <div class="order-card">
            <div class="order-header">
                <div class="order-meta">
                    <div><span>Order Placed</span><%= new java.text.SimpleDateFormat("dd MMM yyyy").format(date) %></div>
                    <div><span>Total</span>₹<%= String.format("%.0f", total) %></div>
                    <div><span>Order #</span>SMT-<%= 10000 + id %></div>
                </div>
            </div>
            <div class="order-items" id="order-items-<%=id%>">
                <!-- Items populated by JS -->
            </div>
            <script>
                (function() {
                    const container = document.getElementById('order-items-<%=id%>');
                    try {
                        const items = <%= detailsJson != null ? detailsJson : "[]" %>;
                        items.forEach(item => {
                            container.innerHTML += `
                                <div class="order-item">
                                    <img src="\${item.image}" alt="\${item.name}" onerror="this.src='<%=ctx%>/images/placeholder.png'">
                                    <div class="order-item-info">
                                        <h4>\${item.name}</h4>
                                        <p>Qty: \${item.qty}</p>
                                    </div>
                                </div>
                            `;
                        });
                    } catch(e) { }
                })();
            </script>
        </div>
        
        <%
                     }
                 }
            } catch(Exception e) {
                out.print("<p>Could not load orders.</p>");
            }
            
            if (!hasOrders) {
        %>
            <div class="no-orders">
                <p>You haven't placed any orders yet.</p>
                <br>
                <a href="<%=ctx%>/products.jsp" class="btn-black" style="background: black; color: white; padding: 12px 24px; text-decoration: none; font-size: 12px; letter-spacing: 1px; text-transform: uppercase;">Shop Collection</a>
            </div>
        <%
            }
        %>
    </div>
</main>

<!-- ===== FOOTER ===== -->
<footer>
    <p>© 2026 Something Technology Ltd.</p>
</footer>

<script src="<%=ctx%>/js/script.js"></script>
<script>
    // Initialize Cart Badge
    const cart = JSON.parse(localStorage.getItem('nothingCart') || '[]');
    const total = cart.reduce((s, i) => s + i.qty, 0);
    if (total > 0) {
        document.getElementById('nav-cart-badge').textContent = total;
        document.getElementById('nav-cart-badge').style.display = 'inline-block';
    }
</script>

</body>
</html>