<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Verify Code</title>
        <link href="css/verify.css" rel="stylesheet">
        <style>
            /* Nền trang với gradient động và hiệu ứng hạt nổi */
         body {
    background: linear-gradient(135deg, #48c6ef, #6f86d6, #ff6b6b);
    margin: 0;
    padding: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Poppins', sans-serif;
    animation: gradientBG 20s ease infinite;
    position: relative;
    overflow: hidden;
}

body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"%3E%3Ccircle fill="rgba(255,255,255,0.1)" cx="10" cy="10" r="5"/%3E%3Ccircle fill="rgba(255,255,255,0.05)" cx="50" cy="50" r="3"/%3E%3Ccircle fill="rgba(255,255,255,0.08)" cx="150" cy="150" r="4"/%3E%3C/svg%3E');
    animation: floatParticles 30s infinite linear;
}

@keyframes gradientBG {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

@keyframes floatParticles {
    0% { transform: translateY(0); }
    100% { transform: translateY(-100vh); }
}

            /* Container với hiệu ứng kính mờ */
            .container {
                backdrop-filter: blur(15px);
                padding: 40px;
                border-radius: 25px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
                text-align: center;
                max-width: 450px;
                width: 100%;
                animation: slideUp 1s ease-out;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            @keyframes slideUp {
                from { opacity: 0; transform: translateY(50px); }
                to { opacity: 1; transform: translateY(0); }
            }

/*             Logo 
            .logo {
                width: 150px;  Tăng kích thước từ 100px lên 150px 
                height: 150px;  Tăng kích thước từ 100px lên 150px 
                margin-bottom: 20px;
                border-radius: 20px;
                transition: all 0.4s ease;
            }

            .logo:hover {
                transform: scale(1.1) rotate(5deg);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }*/

            /* Tiêu đề */
            h2 {
                font-size: 32px;
                font-weight: 700;
                color: #2c3e50;
                background: linear-gradient(90deg, #ff6219, #2575fc);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 15px;
                transition: all 0.3s ease;
            }

            h2:hover {
                transform: scale(1.05);
            }

            /* Thông báo lỗi */
            .text-danger {
                font-size: 16px;
                font-weight: 600;
                color: #ff4757;
                text-shadow: 0 2px 4px rgba(255, 71, 87, 0.3);
                animation: shake 0.6s ease infinite;
                margin-bottom: 20px;
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }

            /* Mô tả - Làm chữ đậm hơn */
            .container p {
                font-size: 16px;
                color: #4b5e6d;
                margin-bottom: 25px;
                font-weight: 700; /* Tăng độ đậm từ mặc định (400) lên 700 */
            }

            /* Input */
            #codeInput {
                width: 100%;
                max-width: 220px;
                padding: 15px;
                border: none;
                border-radius: 15px;
                font-size: 20px;
                text-align: center;
                background: rgba(255, 255, 255, 0.9);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                transition: all 0.4s ease;
                box-sizing: border-box;
            }

            #codeInput:focus {
                outline: none;
                box-shadow: 0 10px 25px rgba(0, 184, 148, 0.5);
                transform: translateY(-3px);
            }

            /* Nút Verify */
            #verifyBtn {
                background: linear-gradient(90deg, #6c5ce7, #a29bfe);
                color: #fff;
                border: none;
                padding: 14px 40px;
                border-radius: 50px;
                font-size: 18px;
                font-weight: 600;
                transition: all 0.4s ease;
                box-shadow: 0 5px 15px rgba(108, 92, 231, 0.4);
                position: relative;
                overflow: hidden;
                margin-top: 20px;
            }

            #verifyBtn:not(:disabled):hover {
                background: linear-gradient(90deg, #4834d4, #8c7ae6);
                transform: translateY(-3px);
                box-shadow: 0 10px 25px rgba(108, 92, 231, 0.6);
            }

            #verifyBtn:disabled {
                background: #d1d5db;
                cursor: not-allowed;
                box-shadow: none;
            }

            #verifyBtn::before {
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

            #verifyBtn:not(:disabled):hover::before {
                width: 300px;
                height: 300px;
            }

            /* Notification Overlay */
            .notification-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.7);
                z-index: 1000;
                justify-content: center;
                align-items: center;
                animation: fadeIn 0.3s ease-in-out;
            }

            .notification-box {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(15px);
                padding: 50px;
                border-radius: 25px;
                text-align: center;
                max-width: 500px;
                width: 90%;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
                transform: scale(0.8);
                animation: scaleUp 0.4s ease-out forwards;
                border: 1px solid rgba(255, 255, 255, 0.2);
                position: relative;
                overflow: hidden;
            }

            .notification-box::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                background: linear-gradient(45deg, #6c5ce7, #ff6b6b);
                z-index: -1;
                border-radius: 27px;
            }

            .notification-box .icon {
                width: 70px;
                height: 70px;
                margin: 0 auto 25px;
                animation: spin 1s ease-in-out;
                stroke: #00b894;
            }

            .notification-box p {
                font-size: 22px;
                font-weight: 500;
                color: #2c3e50;
                margin-bottom: 35px;
                line-height: 1.6;
            }

            .notification-box button {
                background: linear-gradient(90deg, #00b894, #00cec9);
                color: #fff;
                border: none;
                padding: 14px 40px;
                border-radius: 50px;
                font-size: 18px;
                font-weight: 600;
                transition: all 0.4s ease;
                box-shadow: 0 5px 15px rgba(0, 184, 148, 0.4);
                position: relative;
                overflow: hidden;
            }

            .notification-box button:hover {
                background: linear-gradient(90deg, #00cec9, #00b894);
                transform: translateY(-3px);
                box-shadow: 0 10px 25px rgba(0, 184, 148, 0.6);
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

            .notification-box button:hover::before {
                width: 300px;
                height: 300px;
            }

            /* Keyframes */
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
        <form action="${pageContext.request.contextPath}/verifycode" method="post">
            <div class="container">
                <img src="https://img.freepik.com/premium-vector/men-s-clothing-store-logo-clothing-store-transparent-background-clothing-shop-logo-vector_148524-756.jpg" alt="Logo" class="logo">
                <p class="text-danger"><strong>${error}</strong></p>
                <h2>Enter verification code</h2>
                <p>We have sent a verification code to your email.</p>
                <div>
                    <input name="authCode" type="text" id="codeInput" maxlength="6" oninput="checkFilled()">
                </div>
                <button type="submit" id="verifyBtn" disabled>Verify</button>
            </div>
        </form>

        <!-- Thông báo nổi -->
        <div class="notification-overlay" id="notificationOverlay">
            <div class="notification-box">
                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="#00b894" stroke-width="2">
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
                    window.location.href = "${pageContext.request.contextPath}/home";
                }, 300);
            }

            function checkFilled() {
                let input = document.getElementById('codeInput');
                document.getElementById('verifyBtn').disabled = input.value.trim().length !== 6;
            }
        </script>
    </body>
</html>