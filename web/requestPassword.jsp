<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login page</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
        <style>
            /* Đặt nền gradient cho toàn bộ trang */
            body {
                background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
                min-height: 100vh; /* Đảm bảo nền phủ toàn bộ chiều cao */
                margin: 0; /* Xóa margin mặc định */
                padding: 0; /* Xóa padding mặc định */
            }

            /* Loại bỏ khoảng trống thừa và làm nền liền mạch */
            section {
                background: transparent; /* Xóa nền mặc định của section */
                padding: 0; /* Giảm padding để sát với nền */
            }

            .container {
                background: transparent; /* Đảm bảo container không che nền */
                padding: 0; /* Xóa padding mặc định */
            }

            /* Tùy chỉnh card để hòa hợp với nền */
            .card {
                background: rgba(255, 255, 255, 0.9); /* Nền mờ nhẹ để hòa với gradient */
                border: none; /* Xóa viền */
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* Thêm bóng nhẹ */
                margin-top: 150px; /* Giảm margin-top để cân đối */
            }

            /* Tùy chỉnh nút để nổi bật */
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
                                            <h3>Send to email</h3>
                                        </div>
                                    </div>
                                </div>
                                <form action="requestPassword" method="POST">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control"
                                                       name="email" 
                                                       id="email" placeholder="name@example.com" required>
                                                <label for="email" class="form-label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid">
                                                <button class="btn bsb-btn-2xl btn-primary" type="submit">Reset password</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <p class="text-danger">${mess}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>