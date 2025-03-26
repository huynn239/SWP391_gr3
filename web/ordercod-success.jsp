<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            overflow: hidden;
        }

        .success-container {
            max-width: 700px;
            background: #ffffff;
            padding: 60px;
            border-radius: 25px;
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
            text-align: center;
            position: relative;
            animation: slideUp 0.8s ease-out;
            overflow: hidden;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-image {
            width: 200px;
            height: auto;
            margin-bottom: 30px;
            animation: bounce 1.5s ease infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-20px); }
            60% { transform: translateY(-10px); }
        }

        h1 {
            font-size: 34px;
            color: #1a3c34;
            margin-bottom: 25px;
            font-weight: 700;
            background: linear-gradient(90deg, #28a745, #17a2b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        p {
            font-size: 18px;
            color: #5d6d7e;
            margin-bottom: 40px;
            line-height: 1.7;
        }

        .bold-text {
            font-weight: 700;
            color: #34495e;
        }

        .transaction-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 40px;
            font-size: 16px;
            color: #2c3e50;
            border-left: 6px solid #28a745;
            transition: all 0.3s ease;
        }

        .transaction-info:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }

        .btn-home {
            display: inline-block;
            padding: 14px 45px;
            font-size: 18px;
            color: #fff;
            background: linear-gradient(90deg, #007bff, #00c4cc);
            border: none;
            border-radius: 50px;
            text-decoration: none;
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
        }

        .btn-home:hover {
            background: linear-gradient(90deg, #0056b3, #0097a7);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
        }

        .btn-home::before {
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

        .btn-home:hover::before {
            width: 300px;
            height: 300px;
        }

        .footer-text {
            margin-top: 30px;
            font-size: 14px;
            color: #7f8c8d;
            font-style: italic;
        }

        .confetti {
            position: absolute;
            width: 12px;
            height: 12px;
            background: #f1c40f;
            border-radius: 50%;
            animation: fall 3s linear infinite;
        }

        @keyframes fall {
            0% { transform: translateY(-100vh) rotate(0deg); opacity: 1; }
            100% { transform: translateY(100vh) rotate(360deg); opacity: 0; }
        }
        .footer-text {
    margin-top: 30px;
    font-size: 14px;
    color: #7f8c8d;
    font-style: italic;
    font-weight: 600; /* Thêm dòng này để làm đậm hơn */
}
 .transaction-icon {
            width: 150px;
            height: 150px;
            margin-bottom: 30px;
            animation: pulse 1.5s infinite ease-in-out;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:150:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Review-empty.png" 
                 alt="Transaction Status" class="transaction-icon">
        <h1>Đặt hàng thành công !</h1>
        <p><span class="bold-text">Cảm ơn bạn đã mua sắm !<br>Đơn hàng đã được xác nhận và đang trên đường vận chuyển.</span></p>
        <% if (request.getAttribute("message") != null) { %>
            <div class="transaction-info">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        <a href="home.jsp" class="btn-home">Quay về trang chủ</a>
        <div class="footer-text" >Nếu có thắc mắc, vui lòng liên hệ : <strong>0123 456 789</strong></div>
    </div>

    <!-- Hiệu ứng confetti -->
    <script>
        function createConfetti() {
            const container = document.querySelector('.success-container');
            for (let i = 0; i < 20; i++) {
                const confetti = document.createElement('div');
                confetti.classList.add('confetti');
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.background = ['#f1c40f', '#e74c3c', '#3498db', '#2ecc71'][Math.floor(Math.random() * 4)];
                confetti.style.animationDelay = Math.random() * 2 + 's';
                container.appendChild(confetti);
                setTimeout(() => confetti.remove(), 3000);
            }
        }

        window.onload = createConfetti;
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>