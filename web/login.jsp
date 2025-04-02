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
            /* Nền trang với gradient động và hạt nổi */
            body {
                background: linear-gradient(135deg, #00CCFF, #74ebd5, #ff6b6b);
                font-family: 'Poppins', sans-serif;
                animation: gradientBG 15s ease infinite;
                min-height: 100vh;
                overflow: hidden;
                position: relative;
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
                pointer-events: none;
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

            /* Nút Back to Home */
            .back-button {
                position: absolute;
                top: 15px;
                left: 15px;
                padding: 10px 20px;
                font-size: 11px;
                border-radius: 25px;
                font-weight: 600;
                background: linear-gradient(135deg, #6a11cb, #2575fc);
                color: #fff;
                text-decoration: none;
                box-shadow: 0 5px 15px rgba(106, 17, 203, 0.3);
                transition: all 0.4s ease;
                overflow: hidden;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .back-button:hover {
                background: linear-gradient(135deg, #4b088a, #1a5fb4);
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(106, 17, 203, 0.5);
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
                width: 250px;
                height: 250px;
            }

            /* Card chứa form với kính mờ */
            .card {
                border-radius: 30px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(15px);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
                animation: slideUp 1s ease-out;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            @keyframes slideUp {
                from { opacity: 0; transform: translateY(50px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Tiêu đề Login */
            .h1 {
                font-size: 42px;
                font-weight: 800;
                text-transform: uppercase;
                background: linear-gradient(90deg, #ff6219, #2575fc, #ff6b6b);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-shadow: 0 0 20px rgba(255, 98, 25, 0.5);
                transition: all 0.4s ease;
            }

            .h1:hover {
                transform: scale(1.1) rotate(2deg);
                text-shadow: 0 0 30px rgba(255, 98, 25, 0.8);
            }

            /* Chữ Sign into your account */
            h5 {
                font-size: 18px;
                color: #4b5e6d;
                letter-spacing: 1.5px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            h5:hover {
                color: #2575fc;
            }

            /* Thông báo lỗi */
            .text-danger {
                font-size: 16px;
                font-weight: 700;
                color: #ff4757;
                text-shadow: 0 2px 4px rgba(255, 71, 87, 0.3);
                animation: shake 0.6s ease infinite;
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
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
    border-radius: 20px; /* Chữ nhật bo góc mềm mại */
    padding: 15px; /* Trở lại padding đều */
    font-size: 16px;
    border: none;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(5px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: all 0.4s ease;
}

.form-control:focus {
    box-shadow: 0 10px 25px rgba(37, 117, 252, 0.5);
    transform: translateY(-3px);
    background: rgba(255, 255, 255, 1);
}
            /* Nút Login */
            .btn-dark {
                background: linear-gradient(90deg, #2575fc, #6a11cb, #ff6b6b);
                border: none;
                padding: 15px 40px;
                font-size: 18px;
                font-weight: 600;
                border-radius: 50px;
                color: #fff;
                text-transform: uppercase;
                transition: all 0.4s ease;
                position: relative;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(37, 117, 252, 0.4);
            }

            .btn-dark:hover {
                background: linear-gradient(90deg, #1a5fb4, #4b088a, #ff4757);
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(37, 117, 252, 0.6);
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
                width: 350px;
                height: 350px;
            }

            /* Chữ nhỏ */
            /* Chữ nhỏ (bao gồm Forgot password?) */
.small { /* Thêm dấu chấm trước small */
    font-size: 16px;
    color: #843534 !important;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.small:hover {
    color: #ffaa00 !important;
    text-decoration: underline;
    animation: pulse 0.5s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
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

            /* Hình ảnh logo */
            .img-fluid {
                border-radius: 30px;
                transition: all 0.5s ease;
                transform: perspective(1000px) rotateY(0deg);
            }

            .img-fluid:hover {
                transform: perspective(1000px) rotateY(10deg) scale(1.05);
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.25);
            }
        </style>
    </head>
    <body>
        <section class="vh-100">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col col-xl-10">
                        <div class="card position-relative">
                            <a href="home" class="back-button">
                                ← Back to Home
                            </a>
                            <div class="row g-0">
                                <!-- Cột chứa ảnh logo -->
                                <div class="col-md-6 col-lg-5 d-flex justify-content-center align-items-center">
                                    <img src="https://img.freepik.com/premium-vector/men-s-clothing-store-logo-clothing-store-transparent-background-clothing-shop-logo-vector_148524-756.jpg"
                                         alt="login form" class="img-fluid" />
                                </div>
                                <!-- Cột chứa form đăng nhập -->
                                <div class="col-md-6 col-lg-7 d-flex align-items-center">
                                    <div class="card-body p-4 p-lg-5 text-black">
                                        <form action="login" method="post">
                                            <div class="d-flex align-items-center mb-3 pb-1">
                                                <span class="h1 fw-bold mb-0">Login</span>
                                            </div>
                                            <h5 class="fw-normal mb-3 pb-3">Sign into your account</h5>
                                            <p class="text-danger"><strong>${mess}</strong></p>
                                            <div class="mb-3">
                                                <label for="form2Example17" class="form-label"><strong>Username</strong></label>
                                                <input type="text" class="form-control form-control-lg" id="form2Example17" name="user" required />
                                            </div>
                                            <div class="mb-3">
                                                <label for="form2Example27" class="form-label"><strong>Password</strong></label>
                                                <input type="password" class="form-control form-control-lg" id="form2Example27" name="pass" required />
                                            </div>
                                            <div class="pt-1 mb-4">
                                                <button class="btn btn-dark btn-lg btn-block" type="submit">Login</button>
                                            </div>
                                            <a class="small text-muted" href="requestPassword">Forgot password?</a>
                                            <p class="mb-5 pb-lg-2">Don't have an account? <a href="register" class="register-link">Register here</a></p>
                                         
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