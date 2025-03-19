<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.js"></script>
        <style>
            /* Nền trang với gradient động */
            body {
                background: linear-gradient(135deg, #00CCFF, #74ebd5);
                font-family: 'Poppins', sans-serif; /* Font hiện đại */
                animation: gradientBG 10s ease infinite; /* Hiệu ứng chuyển màu nền */
            }

            @keyframes gradientBG {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            /* Nút Back to Home */
            .back-button {
                position: absolute;
                top: 10px;
                left: 10px;
                padding: 8px 16px;
                font-size: 13px;
                border-radius: 20px;
                font-weight: bold;
                background: linear-gradient(135deg, #6a11cb, #2575fc);
                color: white;
                text-decoration: none;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease;
                overflow: hidden; /* Hỗ trợ hiệu ứng sóng */
                display: flex;
                align-items: center;
                gap: 6px; /* Khoảng cách giữa mũi tên và chữ */
            }

            .back-button:hover {
                background: linear-gradient(135deg, #4b088a, #1a5fb4);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(106, 17, 203, 0.4);
            }

            .back-button::before {
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

            .back-button:hover::before {
                width: 200px;
                height: 200px;
            }

            /* Card chứa form */
            .card {
                border-radius: 1rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                background: #fff;
                animation: fadeIn 0.8s ease-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Tiêu đề Login */
            .h1 {
                font-size: 36px;
                font-weight: 700;
                color: #2c3e50;
                background: linear-gradient(90deg, #ff6219, #2575fc);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                transition: all 0.3s ease;
            }

            .h1:hover {
                transform: scale(1.05);
            }

            /* Chữ Sign into your account */
            h5 {
                font-size: 18px;
                color: #7f8c8d;
                letter-spacing: 1px;
                transition: color 0.3s ease;
            }

            h5:hover {
                color: #2575fc;
            }

            /* Label của input */
            .form-label {
                font-weight: 600;
                color: #34495e;
                transition: all 0.3s ease;
            }

            .form-label:hover {
                color: #2575fc;
            }

            /* Input */
            .form-control {
                border-radius: 10px;
                padding: 12px;
                font-size: 16px;
                border: 1px solid #ced4da;
                transition: all 0.3s ease;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .form-control:focus {
                border-color: #2575fc;
                box-shadow: 0 0 10px rgba(37, 117, 252, 0.4);
                transform: scale(1.02);
            }

            /* Nút Login */
            .btn-dark {
                background: linear-gradient(90deg, #2575fc, #6a11cb);
                border: none;
                padding: 12px 30px;
                font-size: 16px;
                border-radius: 50px;
                color: #fff;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(37, 117, 252, 0.2);
            }

            .btn-dark:hover {
                background: linear-gradient(90deg, #1a5fb4, #4b088a);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(37, 117, 252, 0.4);
            }

            .btn-dark::before {
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

            .btn-dark:hover::before {
                width: 300px;
                height: 300px;
            }

            /* Chữ nhỏ (Forgot password, Terms of use, Privacy policy) */
            .small {
                font-size: 14px;
                color: #7f8c8d;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .small:hover {
                color: #2575fc;
                text-decoration: underline;
            }

            /* Chữ Register here */
            .register-link {
                color: #393f81;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .register-link:hover {
                color: #2575fc;
                text-decoration: underline;
            }

            /* Thông báo lỗi */
            .text-danger {
                font-size: 14px;
                font-weight: 500;
                color: #e74c3c;
                animation: shake 0.5s ease;
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }
        </style>
    </head>
    <body>
        <section class="vh-100">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col col-xl-10">
                        <div class="card position-relative">
                            <a href="home" class="btn back-button">
                                ← Back to Home
                            </a>
                            <div class="row g-0">
                                <!-- Cột chứa ảnh logo -->
                                <div class="col-md-6 col-lg-5 d-flex justify-content-center align-items-center">
                                    <img src="https://img.freepik.com/premium-vector/men-s-clothing-store-logo-clothing-store-transparent-background-clothing-shop-logo-vector_148524-756.jpg"
                                         alt="login form" class="img-fluid" style="border-radius: 1rem; max-width: 100%;" />
                                </div>
                                <!-- Cột chứa form đăng nhập -->
                                <div class="col-md-6 col-lg-7 d-flex align-items-center">
                                    <div class="card-body p-4 p-lg-5 text-black">
                                        <form action="login" method="post">
                                            <div class="d-flex align-items-center mb-3 pb-1">
                                                <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                                                <span class="h1 fw-bold mb-0">Login</span>
                                            </div>
                                            <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Sign into your account</h5>
                                            <p class="text-danger"><strong>${mess}</strong></p>
                                            <div class="mb-3">
                                                <label for="form2Example17" class="form-label"><strong>UserName</strong></label>
                                                <input type="text" class="form-control form-control-lg" id="form2Example17" name="user" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="form2Example27" class="form-label"><strong>Password</strong></label>
                                                <input type="password" class="form-control form-control-lg" id="form2Example27" name="pass" required>
                                            </div>
                                            <div class="pt-1 mb-4">
                                                <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark btn-lg btn-block" type="submit">Login</button>
                                            </div>
                                            <a class="small text-muted" href="requestPassword">Forgot password?</a>
                                            <p class="mb-5 pb-lg-2" style="color: #393f81;">Don't have an account? <a href="register" class="register-link">Register here</a></p>
                                            <a href="#!" class="small text-muted">Terms of use.</a>
                                            <a href="#!" class="small text-muted">Privacy policy</a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>