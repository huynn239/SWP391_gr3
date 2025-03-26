<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả giao dịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" 
          rel="stylesheet" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" 
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            background: linear-gradient(120deg, #d4fc79, #96e6a1);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            overflow: hidden;
        }

        .transaction-container {
            max-width: 700px;
            background: #fff;
            padding: 40px 60px;
            border-radius: 25px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
            animation: zoomIn 0.6s ease-out;
        }

        @keyframes zoomIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

        .transaction-icon {
            width: 150px;
            height: 150px;
            margin-bottom: 30px;
            animation: pulse 1.5s infinite ease-in-out;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        h3 {
            font-size: 30px;
            font-weight: 700;
            color: #2ecc71;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            background: linear-gradient(90deg, #28a745, #00c4b4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        p {
            font-size: 18px;
            color: #34495e;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .phone-number {
            font-size: 28px;
            font-weight: 600;
            color: #e74c3c;
            background: #ffe6e6;
            padding: 10px 20px;
            border-radius: 10px;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .phone-number:hover {
            background: #ffcccc;
            transform: scale(1.05);
        }

        .btn-back {
            display: inline-block;
            padding: 12px 35px;
            font-size: 16px;
            color: #fff;
            background: linear-gradient(90deg, #3498db, #2980b9);
            border: none;
            border-radius: 50px;
            text-decoration: none;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
        }

        .btn-back:hover {
            background: linear-gradient(90deg, #2980b9, #1f618d);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }

        .btn-back::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
        }

        .btn-back:hover::before {
            width: 300px;
            height: 300px;
        }

        .stars {
            position: absolute;
            width: 15px;
            height: 15px;
            background: #f1c40f;
            clip-path: polygon(50% 0%, 61% 35%, 98% 35%, 68% 57%, 79% 91%, 50% 70%, 21% 91%, 32% 57%, 2% 35%, 39% 35%);
            animation: sparkle 2s linear infinite;
        }

        @keyframes sparkle {
            0% { transform: translateY(-100vh) rotate(0deg); opacity: 1; }
            100% { transform: translateY(100vh) rotate(360deg); opacity: 0; }
        }
    </style>
</head>
<body>
    <section class="transaction-container">
        <div>
            <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:150:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Review-empty.png" 
                 alt="Transaction Status" class="transaction-icon">
        </div>

        <div>
            <h3>
                Bạn đã giao dịch thành công !
                <i class="fas fa-check-circle"></i>
            </h3>
            <p>Vui lòng để ý số điện thoại của nhân viên tư vấn:</p>
            <strong class="phone-number">0123 456 789</strong>
        </div>

        <a href="home.jsp" class="btn-back">Quay về trang chủ</a>
    </section>

    <!-- Hiệu ứng ngôi sao rơi -->
    <script>
        function createStars() {
            const container = document.querySelector('.transaction-container');
            for (let i = 0; i < 15; i++) {
                const star = document.createElement('div');
                star.classList.add('stars');
                star.style.left = Math.random() * 100 + '%';
                star.style.animationDelay = Math.random() * 1.5 + 's';
                container.appendChild(star);
                setTimeout(() => star.remove(), 2000);
            }
        }

        window.onload = createStars;
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>