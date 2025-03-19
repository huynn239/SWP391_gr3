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
            /* Nền trang với gradient động */
            body {
                background: linear-gradient(135deg, #48c6ef, #6f86d6);
                font-family: 'Poppins', sans-serif;
                animation: gradientBG 15s ease infinite;
                min-height: 100vh;
                overflow: hidden;
            }

            @keyframes gradientBG {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            /* Card chứa form */
            .card {
                border-radius: 25px;
                background: #fff;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
                animation: slideUp 0.8s ease-out;
            }

            @keyframes slideUp {
                from { opacity: 0; transform: translateY(50px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Tiêu đề Sign up */
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


            /* Thông báo lỗi */
            .text-danger {
                font-size: 16px;
                font-weight: 600;
                color: #d63031;
                animation: shake 0.5s ease;
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }

            /* Icon bên trái input */
            .fa-fw {
                color: #00b894;
                transition: all 0.3s ease;
            }

            .fa-fw:hover {
                color: #00cec9;
                transform: scale(1.2);
            }

            /* Form input */
            .form-outline {
                position: relative;
            }

            .form-control {
                border-radius: 10px;
                padding: 14px;
                font-size: 18px; /* Kích thước mặc định */
                border: 1px solid #ced4da;
                transition: all 0.3s ease;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .form-control:focus {
                border-color: #00b894;
                box-shadow: 0 0 10px rgba(0, 184, 148, 0.4);
                transform: scale(1.02);
                font-size: 16px; /* Giảm kích thước chữ khi focus */
            }

            .form-control:not(:placeholder-shown) {
                font-size: 16px; /* Giảm kích thước chữ khi đã nhập */
            }

            .form-label {
                font-weight: 500;
                color: #4A2C2A; /* Màu nâu đậm cho tiêu đề input */
                font-size: 16px;
                transition: all 0.3s ease;
                position: absolute;
                top: 50%;
                left: 12px;
                transform: translateY(-50%);
                pointer-events: none;
                background: #fff;
                padding: 0 5px;
            }

            .form-control:focus + .form-label,
            .form-control:not(:placeholder-shown) + .form-label {
                top: -10px;
                font-size: 14px;
                color: #4A2C2A; /* Giữ màu nâu đậm khi label di chuyển lên */
            }

            /* Nút Register */
            .btn-primary {
                background: linear-gradient(90deg, #6c5ce7, #a29bfe);
                border: none;
                padding: 14px 40px;
                font-size: 18px;
                border-radius: 50px;
                color: #fff;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(108, 92, 231, 0.3);
            }

            .btn-primary:hover {
                background: linear-gradient(90deg, #4834d4, #8c7ae6);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 92, 231, 0.5);
            }

            .btn-primary::before {
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

            .btn-primary:hover::before {
                width: 300px;
                height: 300px;
            }

            /* Hình ảnh logo */
            .img-fluid {
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .img-fluid:hover {
                transform: scale(1.05);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
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