<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart — NothingStore</title>
    <link rel="stylesheet" href="<%=ctx%>/css/style.css?v=3">
    <style>
        /* ===== CART PAGE ===== */
        .cart-page {
            padding: 140px 80px 80px;
            min-height: 100vh;
        }

        .cart-page h1 {
            font-size: 36px;
            font-weight: 600;
            letter-spacing: -1px;
            margin-bottom: 50px;
        }

        .cart-layout {
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 40px;
            align-items: start;
        }

        /* ===== CART ITEMS ===== */
        .cart-items {
            border-top: 1px solid rgba(0,0,0,0.1);
        }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 1fr auto;
            gap: 24px;
            align-items: center;
            padding: 28px 0;
            border-bottom: 1px solid rgba(0,0,0,0.08);
            animation: fadeIn 0.35s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .cart-item img {
            width: 100px;
            height: 100px;
            object-fit: contain;
            background: #f7f7f7;
            padding: 8px;
        }

        .cart-item-info h3 {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .cart-item-info .item-price {
            font-size: 13px;
            color: #666;
            margin-bottom: 14px;
        }

        /* Quantity control */
        .qty-control {
            display: flex;
            align-items: center;
            gap: 0;
            border: 1px solid rgba(0,0,0,0.15);
            width: fit-content;
        }

        .qty-btn {
            width: 32px;
            height: 32px;
            padding: 0;
            margin: 0;
            border: none;
            background: white;
            color: black;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s;
        }

        .qty-btn:hover {
            background: #f0f0f0;
            color: black;
        }

        .qty-value {
            width: 36px;
            text-align: center;
            font-size: 13px;
            font-weight: 600;
            border-left: 1px solid rgba(0,0,0,0.1);
            border-right: 1px solid rgba(0,0,0,0.1);
            padding: 6px 0;
        }

        /* Right side of item */
        .cart-item-right {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 12px;
        }

        .item-total {
            font-size: 15px;
            font-weight: 600;
        }

        .remove-btn {
            background: none;
            border: none;
            color: #999;
            font-size: 11px;
            letter-spacing: 1px;
            cursor: pointer;
            padding: 0;
            margin: 0;
            text-transform: uppercase;
            transition: color 0.2s;
        }

        .remove-btn:hover {
            color: black;
            background: none;
        }

        /* ===== EMPTY CART ===== */
        .cart-empty {
            text-align: center;
            padding: 80px 0;
        }

        .cart-empty h2 {
            font-size: 24px;
            font-weight: 400;
            margin-bottom: 20px;
            color: #555;
        }

        /* ===== ORDER SUMMARY ===== */
        .order-summary {
            background: #fafafa;
            border: 1px solid rgba(0,0,0,0.08);
            padding: 32px;
            position: sticky;
            top: 100px;
        }

        .order-summary h2 {
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 28px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #555;
            margin-bottom: 14px;
        }

        .summary-divider {
            border: none;
            border-top: 1px solid rgba(0,0,0,0.1);
            margin: 20px 0;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 28px;
        }

        .checkout-btn {
            width: 100%;
            padding: 15px;
            font-size: 13px;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            background: black;
            color: white;
            border: 1px solid black;
            margin: 0;
            transition: background 0.25s, color 0.25s;
        }

        .checkout-btn:hover {
            background: white;
            color: black;
        }

        .continue-link {
            display: block;
            text-align: center;
            margin-top: 16px;
            font-size: 12px;
            color: #777;
            text-decoration: underline;
            cursor: pointer;
        }

        /* ===== TOAST NOTIFICATION ===== */
        .toast {
            position: fixed;
            bottom: 40px;
            right: 40px;
            background: black;
            color: white;
            font-size: 12px;
            letter-spacing: 1px;
            padding: 14px 24px;
            z-index: 9999;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
            pointer-events: none;
        }

        .toast.show {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 900px) {
            .cart-page { padding: 120px 20px 60px; }
            .cart-layout { grid-template-columns: 1fr; }
            .order-summary { position: static; }
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<header>
<nav class="navbar">
    <div class="logo">
        <a href="<%=ctx%>/index.jsp">SOMETHING</a>
    </div>
    <nav>
        <a href="<%=ctx%>/index.jsp">Home</a>
        <a href="<%=ctx%>/products.jsp">Products</a>
        <a href="<%=ctx%>/community.jsp">Community</a>
        <a href="<%=ctx%>/about.jsp">About</a>
        <a href="<%=ctx%>/cart.jsp" id="nav-cart-link" style="position:relative;">
            Cart
            <span id="nav-cart-badge" style="
                display:none;
                position:absolute;
                top:-8px;right:-12px;
                background:black;color:white;
                border-radius:50%;width:16px;height:16px;
                font-size:10px;line-height:16px;text-align:center;
            "></span>
        </a>
        <a href="<%=ctx%>/login.jsp">Login</a>
    </nav>
</nav>
</header>

<!-- TOAST -->
<div class="toast" id="toast"></div>

<!-- CART PAGE -->
<main class="cart-page">
    <h1>Your Cart</h1>

    <div class="cart-layout">

        <!-- LEFT: items list -->
        <div>
            <div class="cart-items" id="cart-items-container"></div>
        </div>

        <!-- RIGHT: summary -->
        <div class="order-summary">
            <h2>Order Summary</h2>
            <div class="summary-row"><span>Subtotal</span><span id="summary-subtotal">₹0</span></div>
            <div class="summary-row"><span>Shipping</span><span id="summary-shipping">FREE</span></div>
            <div class="summary-row"><span>Tax (18% GST)</span><span id="summary-tax">₹0</span></div>
            <hr class="summary-divider">
            <div class="summary-total"><span>Total</span><span id="summary-total">₹0</span></div>
            <button class="checkout-btn" onclick="checkout()">Checkout →</button>
            <a class="continue-link" href="<%=ctx%>/products.jsp">← Continue Shopping</a>
        </div>
    </div>
</main>

<footer>
    <p>© 2026 Something Technology Ltd.</p>
</footer>

<script>
// ============================================================
//  CART UTILITIES
// ============================================================
function getCart() {
    return JSON.parse(localStorage.getItem('nothingCart') || '[]');
}
function saveCart(cart) {
    localStorage.setItem('nothingCart', JSON.stringify(cart));
}

// Format price as Indian currency
function fmt(n) {
    return '₹' + Number(n).toLocaleString('en-IN', { maximumFractionDigits: 0 });
}

// Show toast message
function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 2500);
}

// ============================================================
//  BADGE UPDATE
// ============================================================
function updateBadge() {
    const cart  = getCart();
    const total = cart.reduce((s, i) => s + i.qty, 0);
    const badge = document.getElementById('nav-cart-badge');
    if (badge) {
        badge.textContent = total;
        badge.style.display = total > 0 ? 'inline-block' : 'none';
    }
}

// ============================================================
//  RENDER CART
// ============================================================
function renderCart() {
    const cart      = getCart();
    const container = document.getElementById('cart-items-container');
    updateBadge();

    if (cart.length === 0) {
        container.innerHTML = `
            <div class="cart-empty">
                <h2>Your cart is empty.</h2>
                <button onclick="location.href='<%=ctx%>/products.jsp'" style="margin-top:10px;">
                    Shop Products →
                </button>
            </div>`;
        updateSummary(0);
        return;
    }

    container.innerHTML = cart.map((item, idx) => 
        '<div class="cart-item" id="item-' + idx + '">' +
            '<img src="' + item.image + '" alt="' + item.name + '" onerror="this.src=\'<%=ctx%>/images/placeholder.png\'">' +
            '<div class="cart-item-info">' +
                '<h3>' + item.name + '</h3>' +
                '<div class="item-price">' + fmt(item.price) + '</div>' +
                '<div class="qty-control">' +
                    '<button class="qty-btn" onclick="changeQty(' + idx + ', -1)">−</button>' +
                    '<div class="qty-value">' + item.qty + '</div>' +
                    '<button class="qty-btn" onclick="changeQty(' + idx + ', 1)">+</button>' +
                '</div>' +
            '</div>' +
            '<div class="cart-item-right">' +
                '<div class="item-total">' + fmt(item.price * item.qty) + '</div>' +
                '<button class="remove-btn" onclick="removeItem(' + idx + ')">Remove</button>' +
            '</div>' +
        '</div>'
    ).join('');

    const subtotal = cart.reduce((s, i) => s + i.price * i.qty, 0);
    updateSummary(subtotal);
}

// ============================================================
//  SUMMARY
// ============================================================
function updateSummary(subtotal) {
    const tax   = Math.round(subtotal * 0.18);
    const total = subtotal + tax;
    document.getElementById('summary-subtotal').textContent = fmt(subtotal);
    document.getElementById('summary-tax').textContent      = fmt(tax);
    document.getElementById('summary-total').textContent    = fmt(total);
    document.getElementById('summary-shipping').textContent = subtotal > 0 ? 'FREE' : '₹0';
}

// ============================================================
//  ACTIONS
// ============================================================
function changeQty(idx, delta) {
    const cart = getCart();
    cart[idx].qty = Math.max(1, cart[idx].qty + delta);
    saveCart(cart);
    renderCart();
}

function removeItem(idx) {
    const cart = getCart();
    const name = cart[idx].name;
    cart.splice(idx, 1);
    saveCart(cart);
    renderCart();
    showToast(name + ' removed from cart');
}

async function checkout() {
    const cart = getCart();
    if (cart.length === 0) { showToast('Your cart is empty!'); return; }
    
    const subtotal = cart.reduce((s, i) => s + i.price * i.qty, 0);
    const tax = Math.round(subtotal * 0.18);
    const total = subtotal + tax;
    
    try {
        const response = await fetch('<%=ctx%>/process_checkout.jsp?total=' + total, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(cart)
        });
        
        if (response.status === 401) {
            window.location.href = '<%=ctx%>/login.jsp';
            return;
        }
        
        const result = await response.json();
        if (result.success) {
            showToast('Order placed! Thank you 🎉');
            setTimeout(() => {
                localStorage.removeItem('nothingCart');
                renderCart();
                window.location.href = '<%=ctx%>/profile.jsp';
            }, 2000);
        } else {
            showToast('Error: ' + result.message);
        }
    } catch (err) {
        showToast('Failed to process checkout.');
    }
}

// Init
renderCart();
</script>

</body>
</html>