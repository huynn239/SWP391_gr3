<%-- 
    Document   : changepassword
    Created on : 16 Feb 2025, 10:47:52 pm
    Author     : NBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/changepass.css" rel="stylesheet">
        <!-- Bootstrap 3 -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            .back-button {
                font-size: 14px;
                padding: 8px 12px;
                border-radius: 5px;
                color: white; /* Đổi màu chữ */
                background-color: #007bff; /* Màu nền xanh dương */
                border: none;
            }

            .back-button:hover {
                background-color: #0056b3; /* Màu nền khi hover */
                color: #fff; /* Giữ màu chữ trắng */
            }
        </style>
    </head>
    <body>
        <div class="container bootstrap snippets bootdey">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-6 col-md-offset-2">
                    <div class="back-container">
                        <a href="home.jsp" class="btn btn-default back-button">
                            <span class="glyphicon glyphicon-arrow-left"></span> Back
                        </a>
                    </div>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <span class="glyphicon glyphicon-th"></span>
                                Change password   
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6 separator social-login-box"> <br>
                                    <img alt="" class="img-thumbnail" src="https://img.freepik.com/premium-vector/men-s-clothing-store-logo-clothing-store-transparent-background-clothing-shop-logo-vector_148524-756.jpg">                        
                                </div>
                                <form action="ChangePassword" method="post">
                                    <div style="margin-top:50px;" class="col-xs-6 col-sm-6 col-md-6 login-box">
                                        <div class="form-group">
                                            <div class="text-danger"><strong>${message}</strong></div>
                                            <div class="text-danger"><strong>${error}</strong></div>
                                            <!--                                            <div class="input-group">
                                                                                            <div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
                                                                                            <input class="form-control" type="text" placeholder="Username" name="user" required>
                                                                                        </div>-->
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
                                                <input class="form-control" type="password" placeholder="Current Password" name="pass" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><span class="glyphicon glyphicon-log-in"></span></div>
                                                <input class="form-control" type="password" placeholder="New Password" name="newpass" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><span class="glyphicon glyphicon-log-in"></span></div>
                                                <input class="form-control" type="password" placeholder="Confirm New Password" name="newpass" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                        <div class="row">
                                            <div class="col-xs-6 col-sm-6 col-md-6"></div>
                                            <div class="col-xs-6 col-sm-6 col-md-6">
                                                <button class="btn icon-btn-save btn-success" type="submit">
                                                    <span class="btn-save-label"><i class="glyphicon glyphicon-floppy-disk"></i></span>Save
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
