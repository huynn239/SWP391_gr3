<%-- 
    Document   : verifycode
    Created on : 26 Feb 2025, 3:42:30 pm
    Author     : NBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/verify.css" rel="stylesheet">
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/verifycode" method="post">
            <div class="container">
                <img src="https://img.freepik.com/premium-vector/men-s-clothing-store-logo-clothing-store-transparent-background-clothing-shop-logo-vector_148524-756.jpg" alt="Logo" class="logo">
                <p class ="text-danger"><strong>${error}</strong></p>
                <h2>Enter verification code</h2>
                <p>We have sent a verification code to your email.</p>
                <div>
                    <input name="authCode" type="text" id="codeInput" maxlength="6" oninput="checkFilled()">
                </div>
                <button type="submit" id="verifyBtn" disabled ">Verify</button>
            </div>
            <script>
                function checkFilled() {
                    let input = document.getElementById('codeInput');
                    document.getElementById('verifyBtn').disabled = input.value.trim().length !== 6;
                }

                function verifyCode() {
                    let code = document.getElementById('codeInput').value;
                    alert('Mã bạn nhập: ' + code);
                }
            </script>
        </form>
    </body>
</html>
