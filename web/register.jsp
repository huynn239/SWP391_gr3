<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.js"></script>
        <style>
            /* Nền trang với hiệu ứng gradient động và hạt nổi */
            body {
                background: linear-gradient(135deg, #48c6ef, #6f86d6, #ff6b6b);
                font-family: 'Poppins', sans-serif;
                animation: gradientBG 20s ease infinite;
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

            /* Card chứa form với hiệu ứng kính mờ */
            .card {
                border-radius: 30px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(15px);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
                animation: slideUp 1s ease-out;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            @keyframes slideUp {
                from { opacity: 0; transform: translateY(70px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Tiêu đề Sign up với hiệu ứng neon */
            .h1 {
                font-size: 42px;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 2px;
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

            /* Thông báo lỗi với hiệu ứng rung */
            .text-danger {
                font-size: 16px;
                font-weight: 700;
                color: #ff4757;
                text-shadow: 0 2px 4px rgba(255, 71, 87, 0.3);
                animation: shake 0.6s ease infinite;
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-6px); }
                75% { transform: translateX(6px); }
            }

            /* Icon bên trái input với hiệu ứng xoay */
            .fa-fw {
                color: #00b894;
                font-size: 20px;
                transition: all 0.4s ease;
            }

            .fa-fw:hover {
                color: #00cec9;
                transform: rotate(360deg) scale(1.3);
            }

            /* Form input với hiệu ứng nổi */
            .form-outline {
                position: relative;
                margin-bottom: 25px;
            }

            .form-control {
                border-radius: 15px;
                padding: 16px;
                font-size: 18px;
                border: none;
                background: rgba(255, 255, 255, 0.9);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                transition: all 0.4s ease;
            }

            .form-control:focus {
                background: #fff;
                box-shadow: 0 10px 25px rgba(0, 184, 148, 0.5);
                transform: translateY(-3px);
                font-size: 16px;
            }

            .form-control:not(:placeholder-shown) {
                font-size: 16px;
            }

/* CSS mặc định cho tất cả nhãn (giữ nguyên) */
.form-label {
    font-weight: 600;
    color: #006994; /* Màu mặc định, sẽ bị ghi đè bởi các quy tắc bên dưới */
    font-size: 16px;
    transition: all 0.3s ease;
    position: absolute;
    top: 50%;
    left: 16px;
    transform: translateY(-50%);
    background: rgba(255, 255, 255, 0.9);
    padding: 0 8px;
    pointer-events: none;
}

/* CSS khi focus hoặc đã nhập (giữ nguyên) */
.form-control:focus + .form-label,
.form-control:not(:placeholder-shown) + .form-label {
    top: -12px;
    font-size: 12px;
    color: #006994; /* Màu mặc định, sẽ bị ghi đè */
}

/* Thêm các quy tắc mới cho từng nhãn */
.d-flex:nth-child(1) .form-label { color: #ff6219; } /* Full Name - Đỏ hồng */
.d-flex:nth-child(2) .form-label { color: #00b894; } /* Your Email - Xanh lá */
.d-flex:nth-child(3) .form-label { color: #6c5ce7; } /* Mobile - Tím */
.d-flex:nth-child(4) .form-label { color: #feca57; } /* Address - Vàng */
.d-flex:nth-child(5) .form-label { color: #00b4d8; } /* User Name - Xanh nước biển nhạt */
.d-flex:nth-child(6) .form-label { color: #ff4757; } /* Password - Đỏ đậm */
.d-flex:nth-child(7) .form-label { color: #2d3436; } /* Repeat your password - Xám đậm */

/* Khi focus hoặc đã nhập, giữ màu tương ứng */
.d-flex:nth-child(1) .form-control:focus + .form-label,
.d-flex:nth-child(1) .form-control:not(:placeholder-shown) + .form-label { color: #ff6219; }
.d-flex:nth-child(2) .form-control:focus + .form-label,
.d-flex:nth-child(2) .form-control:not(:placeholder-shown) + .form-label { color: #00b894; }
.d-flex:nth-child(3) .form-control:focus + .form-label,
.d-flex:nth-child(3) .form-control:not(:placeholder-shown) + .form-label { color: #6c5ce7; }
.d-flex:nth-child(4) .form-control:focus + .form-label,
.d-flex:nth-child(4) .form-control:not(:placeholder-shown) + .form-label { color: #feca57; }
.d-flex:nth-child(5) .form-control:focus + .form-label,
.d-flex:nth-child(5) .form-control:not(:placeholder-shown) + .form-label { color: #00b4d8; }
.d-flex:nth-child(6) .form-control:focus + .form-label,
.d-flex:nth-child(6) .form-control:not(:placeholder-shown) + .form-label { color: #ff4757; }
.d-flex:nth-child(7) .form-control:focus + .form-label,
.d-flex:nth-child(7) .form-control:not(:placeholder-shown) + .form-label { color: #2d3436; }

            /* Nút Register với hiệu ứng sóng và phát sáng */
            .btn-primary {
                background: linear-gradient(90deg, #6c5ce7, #a29bfe, #ff6b6b);
                border: none;
                padding: 16px 50px;
                font-size: 18px;
                font-weight: 600;
                border-radius: 50px;
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.4s ease;
                position: relative;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(108, 92, 231, 0.4);
            }

            .btn-primary:hover {
                background: linear-gradient(90deg, #4834d4, #8c7ae6, #ff4757);
                transform: translateY(-4px);
                box-shadow: 0 10px 30px rgba(108, 92, 231, 0.7);
            }

            .btn-primary::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                background: rgba(255, 255, 255, 0.4);
                border-radius: 50%;
                transform: translate(-50%, -50%);
                transition: width 0.5s ease, height 0.5s ease;
            }

            .btn-primary:hover::before {
                width: 400px;
                height: 400px;
            }

            /* Hình ảnh logo với hiệu ứng 3D */
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
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-lg-12 col-xl-11">
                        <div class="card text-black">
                            <div class="card-body p-md-5">
                                <div class="row justify-content-center">
                                    <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
                                        <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign up</p>
                                        <div class="text-center mb-4">
                                            <p class="text-danger fw-bold">${mess}</p>
                                            <p class="text-danger fw-bold">${mess1}</p>
                                        </div>
                                        <form action="register" method="post" class="mx-1 mx-md-4">
                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="fullname" type="text" class="form-control" required />
                                                    <label class="form-label">Full Name</label>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="email" type="email" class="form-control" required />
                                                    <label class="form-label">Your Email</label>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-phone fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="mobile" type="text" class="form-control" required />
                                                    <label class="form-label">Mobile</label>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-map-marker-alt fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="address" type="text" class="form-control" required />
                                                    <label class="form-label">Address</label>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="user" type="text" class="form-control" required />
                                                    <label class="form-label">User Name</label>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="pass" type="password" class="form-control" required />
                                                    <label class="form-label">Password</label>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="repass" type="password" class="form-control" required />
                                                    <label class="form-label">Repeat your password</label>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                                <button type="submit" class="btn btn-primary btn-lg">Register</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                                        <img src="https://img.freepik.com/premium-vector/men-s-clothing-store-logo-clothing-store-transparent-background-clothing-shop-logo-vector_148524-756.jpg"
                                             class="img-fluid" alt="Sample image">
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