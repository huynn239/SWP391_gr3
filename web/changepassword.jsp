<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #74ebd5, #acb6e5);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            overflow: hidden;
        }

        .container {
    position: relative; /* Để .back-button định vị tương đối với container */
    max-width: 600px;
    background: #ffffff;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    animation: fadeIn 0.8s ease-out;
}

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

 .back-button {
    position: absolute;
    top: -50px; /* Đặt phía trên form */
    left: 0; /* Căn sát bên trái */
    padding: 8px 20px; /* Tăng padding để nút rộng hơn */
    font-size: 14px;
    color: #fff;
    background: linear-gradient(90deg, #007bff, #00c4cc); /* Gradient nền */
    border: none;
    border-radius: 50px;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 6px;
    overflow: hidden; /* Để hiệu ứng ripple không tràn ra ngoài */
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0, 123, 255, 0.2); /* Thêm bóng đổ */
}

.back-button:hover {
    background: linear-gradient(90deg, #0056b3, #0097a7);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4); /* Bóng đổ đậm hơn khi hover */
    color: #fff;
}

.back-button::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    background: rgba(255, 255, 255, 0.3); /* Hiệu ứng sóng trắng mờ */
    border-radius: 50%;
    transform: translate(-50%, -50%);
    transition: width 0.6s ease, height 0.6s ease;
}

.back-button:hover::before {
    width: 200px; /* Tạo hiệu ứng sóng lan tỏa */
    height: 200px;
}
        .panel-heading {
            background: linear-gradient(90deg, #28a745, #17a2b8);
            color: #fff;
            padding: 15px;
            border-radius: 15px 15px 0 0;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
        }

        .panel-body {
            padding: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .social-login-box img {
            width: 150px;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .social-login-box img:hover {
            transform: scale(1.05);
        }

        .login-box {
            width: 100%;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px 40px;
            font-size: 16px;
            border: 1px solid #ced4da;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 8px rgba(40, 167, 69, 0.3);
        }

        .input-group-text {
            background: #f8f9fa;
            border: 1px solid #ced4da;
            border-right: none;
            border-radius: 10px 0 0 10px;
            padding: 12px;
            color: #6c757d;
        }

        .text-danger {
            font-size: 14px;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .btn-success {
            background: linear-gradient(90deg, #28a745, #34c759);
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 50px;
            color: #fff;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-success:hover {
            background: linear-gradient(90deg, #218838, #2ecc71);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        }

        .btn-save-label {
            margin-right: 8px;
        }

        .panel-footer {
            padding: 20px;
            text-align: right;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            .social-login-box {
                margin-bottom: 20px;
            }
            .panel-body {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="home" class="back-button">
            <i class="fas fa-arrow-left"></i> Back to home
        </a>
        <div class="panel">
            <div class="panel-heading">
                <i class="fas fa-key"></i> Change Pasword
            </div>
            <div class="panel-body">
                <div class="row align-items-center">
                   
                    <form action="changepassword" method="post" class="col-md-7 login-box">
                        <div class="form-group">
                            <div class="text-danger"><strong>${message}</strong></div>
                            <div class="text-danger"><strong>${error}</strong></div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input class="form-control" type="password" placeholder="Mật khẩu hiện tại" name="pass" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-unlock-alt"></i></span>
                                <input class="form-control" type="password" placeholder="Mật khẩu mới" name="newpass" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-unlock-alt"></i></span>
                                <input class="form-control" type="password" placeholder="Xác nhận mật khẩu mới" name="newpass" required>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <button class="btn btn-success" type="submit">
                                <span class="btn-save-label"><i class="fas fa-save"></i></span> Save
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>