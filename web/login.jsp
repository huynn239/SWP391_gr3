<%-- 
    Document   : login
    Created on : 7 Feb 2025, 9:33:20 am
    Author     : NBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.js"></script>
    </head>
    <body>
        <section class="vh-100" style="background-color: #00CCFF;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col col-xl-10">
                        <div class="card position-relative" style="border-radius: 1rem;">

                            <a href="home" class="btn position-absolute shadow"
                               style="
                               top: 10px; left: 10px;
                               padding: 8px 16px; font-size: 13px;
                               border-radius: 20px; font-weight: bold;
                               background: linear-gradient(135deg, #6a11cb, #2575fc);
                               color: white; text-decoration: none;
                               box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
                               transition: all 0.3s ease;">
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
                                            <p class ="text-danger"><strong>${mess}</strong></p>

                                            <div class="mb-3">
                                                <label for="form2Example17" class="form-label"><strong> UserName </strong></label>
                                                <input type="text" class="form-control form-control-lg" id="form2Example17" name="user" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="form2Example27" class="form-label"><strong> Password </strong></label>
                                                <input type="password" class="form-control form-control-lg" id="form2Example27" name="pass" required>
                                            </div>

                                            <div class="pt-1 mb-4">
                                                <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark btn-lg btn-block" type="submit">Login</button>
                                            </div>

                                            <a class="small text-muted" href="requestPassword">Forgot password?</a>
                                            <p class="mb-5 pb-lg-2" style="color: #393f81;">Don't have an account? <a href="register" style="color: #393f81;">Register here</a></p>
                                            <a href="#!" class="small text-muted">Terms of use.</a>
                                            <a href="#!" class="small text-muted">Privacy policy</a>
                                        </form>
                                    </div>
                                </div> <!-- End col-md-6 -->
                            </div> <!-- End row -->
                        </div> <!-- End card -->
                    </div>
                </div>
            </div>
        </section>

    </body>
</html>
