<%-- 
    Document   : resetPassword
    Created on : 16 Feb 2025, 3:05:47 pm
    Author     : NBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
        <style>
            /* Nền gradient cho toàn bộ trang */
            body {
                background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
                min-height: 100vh;
                margin: 0;
                padding: 0;
            }

            section {
                background: transparent;
                padding: 0;
            }

            .container {
                background: transparent;
                padding: 0;
            }

            .card {
                background: rgba(255, 255, 255, 0.9);
                border: none;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                margin-top: 150px;
            }

            .btn-primary {
                background: linear-gradient(90deg, #3a7bd5, #00d2ff);
                border: none;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background: linear-gradient(90deg, #2a5298, #3a7bd5);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 210, 255, 0.4);
            }

            /* CSS cho thông báo nổi */
            .notification-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.85); /* Tăng độ mờ để che khuất nội dung bên dưới */
                z-index: 1000; /* Đảm bảo thông báo nằm trên cùng */
                justify-content: center;
                align-items: center;
                animation: fadeIn 0.3s ease-in-out;
            }

            .notification-box {
                position: relative;
                background: radial-gradient(circle at center, #ffffff, #f5f7fa);
                padding: 40px;
                border-radius: 20px;
                text-align: center;
                max-width: 450px;
                width: 90%;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
                transform: scale(0.8);
                animation: scaleUp 0.4s ease-out forwards;
                border: 2px solid transparent;
                background-clip: padding-box;
                overflow: hidden;
            }

            .notification-box::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                background: linear-gradient(45deg, #d1d5db, #ffffff);
                z-index: -1;
                border-radius: 22px;
                padding: 2px;
            }

            .notification-box:hover {
                box-shadow: 0 15px 40px rgba(200, 200, 200, 0.3);
            }

            .notification-box .icon {
                width: 60px;
                height: 60px;
                margin: 0 auto 20px;
                animation: spin 1s ease-in-out;
            }

            .notification-box p {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                font-size: 20px;
                font-weight: 500;
                color: #2c3e50;
                margin-bottom: 30px;
                line-height: 1.6;
            }

            .notification-box button {
                position: relative;
                background: linear-gradient(90deg, #ff4d4d, #ff6666);
                color: white;
                border: none;
                padding: 12px 35px;
                border-radius: 25px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4);
                overflow: hidden;
            }

            .notification-box button:hover {
                background: linear-gradient(90deg, #ff6666, #ff4d4d);
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(255, 77, 77, 0.6);
            }

            .notification-box button:active {
                transform: translateY(1px);
                box-shadow: 0 3px 10px rgba(255, 77, 77, 0.3);
            }

            .notification-box button::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                transform: translate(-50%, -50%);
                transition: width 0.6s ease, height 0.6s ease;
            }

            .notification-box button:active::before {
                width: 200px;
                height: 200px;
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            @keyframes scaleUp {
                from { transform: scale(0.8); opacity: 0; }
                to { transform: scale(1); opacity: 1; }
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            @keyframes fadeOut {
                from { opacity: 1; }
                to { opacity: 0; }
            }
        </style>
    </head>
    <body>
        <section class="p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="mb-5">
                                            <h3>Reset Password</h3>
                                        </div>
                                    </div>
                                </div>
                                <form action="resetPassword" method="POST">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" value="${email}" name="email" id="email" placeholder="name@example.com" required>
                                                <label for="email" class="form-label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="password" id="password" value="" placeholder="Password" required>
                                                <label for="password" class="form-label">Password</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="confirm_password" id="confirm_password" value="" placeholder="Password" required>
                                                <label for="confirm_password" class="form-label">Confirm Password</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid">
                                                <button class="btn bsb-btn-2xl btn-primary" type="submit">Reset Password</button>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="text-danger">${mess}</p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Notification -->
        <div class="notification-overlay" id="notificationOverlay">
            <div class="notification-box">
                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="#4b5e6d" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                </svg>
                <p id="notificationMessage"></p>
                <button onclick="redirectToHome()">OK</button>
            </div>
        </div>

        <!-- JavaScript -->
        <script>
            const successMessage = "${success}";
            const notificationOverlay = document.getElementById("notificationOverlay");

            if (successMessage) {
                document.getElementById("notificationMessage").innerText = successMessage;
                notificationOverlay.style.display = "flex";
            }

            function redirectToHome() {
                notificationOverlay.style.animation = "fadeOut 0.3s ease-in-out";
                setTimeout(() => {
                    window.location.href = "home";
                }, 300);
            }
        </script>
    </body>
</html>