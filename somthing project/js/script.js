// ===== NAVBAR SCROLL (SMOOTH + CLEAN) =====
const navbar = document.getElementById('navbar');
let lastScroll = 0;

window.addEventListener('scroll', () => {
    const current = window.scrollY;

    if (!navbar) return;

    // subtle background change
    if (current > 40) {
        navbar.style.background = "rgba(255,255,255,0.85)";
        navbar.style.backdropFilter = "blur(12px)";
    } else {
        navbar.style.background = "transparent";
    }

    // hide on scroll down (smooth)
    if (current > lastScroll && current > 120) {
        navbar.style.transform = "translateY(-100%)";
    } else {
        navbar.style.transform = "translateY(0)";
    }

    lastScroll = current;
});


// ===== HAMBURGER MENU (CLEAN) =====
const hamburger = document.getElementById('hamburger');
const navLinks  = document.getElementById('navLinks');

if (hamburger && navLinks) {
    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('active');
        hamburger.classList.toggle('active');
    });
}


// ===== SCROLL REVEAL (SUBTLE FADE) =====
const revealEls = document.querySelectorAll(
    '.card, .hero h1, .hero p'
);

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('show');
            observer.unobserve(entry.target);
        }
    });
}, { threshold: 0.2 });

revealEls.forEach(el => {
    el.classList.add('hidden');
    observer.observe(el);
});


// ===== LIGHT PARALLAX (VERY SUBTLE) =====
const hero = document.querySelector('.hero');

if (hero) {
    hero.addEventListener('mousemove', (e) => {

        const x = (e.clientX / window.innerWidth - 0.5) * 10;
        const y = (e.clientY / window.innerHeight - 0.5) * 10;

        const img = document.querySelector('.main-img');
        if (img) {
            img.style.transform = `translate(${x}px, ${y}px)`;
        }
    });
}


// ===== PRODUCT HOVER (REDUCED INTENSITY) =====
document.querySelectorAll('.card').forEach(card => {

    card.addEventListener('mousemove', function(e) {
        const rect = this.getBoundingClientRect();

        const x = (e.clientX - rect.left) / rect.width - 0.5;
        const y = (e.clientY - rect.top) / rect.height - 0.5;

        this.style.transform = `
            perspective(800px)
            rotateY(${x * 4}deg)
            rotateX(${-y * 4}deg)
        `;
    });

    card.addEventListener('mouseleave', function() {
        this.style.transform = 'none';
    });
});


// ===== BUTTON RIPPLE (OPTIONAL MINIMAL) =====
document.querySelectorAll('button').forEach(btn => {
    btn.addEventListener('click', function(e) {

        const circle = document.createElement('span');
        const diameter = Math.max(this.clientWidth, this.clientHeight);

        circle.style.width = circle.style.height = `${diameter}px`;
        circle.style.left = `${e.offsetX - diameter / 2}px`;
        circle.style.top = `${e.offsetY - diameter / 2}px`;

        circle.classList.add('ripple');

        const old = this.querySelector('.ripple');
        if (old) old.remove();

        this.appendChild(circle);
    });
});


// ===== CONFIRM PASSWORD VALIDATION =====
function validatePasswords() {
    const password = document.querySelector('input[name="password"]');
    const confirmPassword = document.querySelector('input[name="confirmPassword"]');

    if (!password || !confirmPassword) return true;

    // Reset styles
    password.style.borderColor = "";
    confirmPassword.style.borderColor = "";
    password.setCustomValidity("");
    confirmPassword.setCustomValidity("");

    const value = password.value;

    // Strong password regex
    const strongPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

    if (!strongPassword.test(value)) {
        password.style.borderColor = "red";
        password.setCustomValidity(
            "Password must be at least 8 characters and include uppercase, lowercase, number, and special character."
        );
        password.reportValidity();
        return false;
    }

    if (value !== confirmPassword.value) {
        confirmPassword.style.borderColor = "red";
        confirmPassword.setCustomValidity("Passwords do not match.");
        confirmPassword.reportValidity();
        return false;
    }

    return true;
}

// ===== LIVE CONFIRM PASSWORD CHECK =====
const confirmInput = document.querySelector('input[name="confirmPassword"]');
const passwordInput = document.querySelector('input[name="password"]');

if (confirmInput && passwordInput) {

    // Live feedback as user types in confirm field
    confirmInput.addEventListener('input', () => {
        confirmInput.setCustomValidity("");
        if (confirmInput.value === "") {
            confirmInput.style.borderColor = "";
        } else if (confirmInput.value !== passwordInput.value) {
            confirmInput.style.borderColor = "red";
        } else {
            confirmInput.style.borderColor = "green";
        }
    });

    // Reset confirm border if user edits the original password
    passwordInput.addEventListener('input', () => {
        passwordInput.setCustomValidity("");
        if (confirmInput.value !== "") {
            if (confirmInput.value !== passwordInput.value) {
                confirmInput.style.borderColor = "red";
            } else {
                confirmInput.style.borderColor = "green";
            }
        }
    });

    // Hook into the signup form submit
    const signupForm = document.getElementById('signupForm');
    if (signupForm) {
        signupForm.addEventListener('submit', function(e) {
            if (!validatePasswords()) {
                e.preventDefault();
            }
        });
    }
}