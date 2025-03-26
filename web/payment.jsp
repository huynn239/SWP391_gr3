<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Cart" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận thanh toán</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <style>
        /* Toàn bộ CSS của bạn được giữ nguyên */
        body {
            background: #f0f2f5;
            font-family: Arial, sans-serif;
        }
        .payment-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 30px;
            border: none;
            border-radius: 10px;
            background: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .title-main {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-size: 2em;
            font-weight: 700;
            letter-spacing: 1.5px;
            background: linear-gradient(90deg, #3498db, #2ecc71);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
        }
        .flex-container {
            display: flex;
            justify-content: space-between;
            gap: 30px;
        }
        .info-section, .product-section {
            flex: 1;
            min-width: 0;
            background: #fafafa;
            padding: 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .info-section:hover, .product-section:hover {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        .section-title {
            font-size: 1.5em;
            font-weight: 600;
            color: #34495e;
            margin-bottom: 20px;
            padding: 8px 15px;
            background: #ecf0f1;
            border-left: 5px solid #3498db;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: relative;
        }
        .section-title::before {
            content: '';
            position: absolute;
            top: 50%;
            left: -15px;
            width: 10px;
            height: 10px;
            background: #3498db;
            border-radius: 50%;
            transform: translateY(-50%);
        }
        .form-group {
            margin-bottom: 15px;
            position: relative;
        }
        .form-group select {
    -webkit-appearance: none; /* Bỏ mũi tên trên Safari/Chrome */
    -moz-appearance: none;    /* Bỏ mũi tên trên Firefox */
    appearance: none;         /* Bỏ mũi tên mặc định */
}
        .form-group label {
            font-size: 0.95em;
            font-weight: 600;
            color: #34495e;
            display: block;
            margin-bottom: 8px;
            transition: all 0.3s ease;
        }
        .form-group .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            background: #fff;
            color: #2c3e50;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1), inset 0 1px 3px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        .form-group input:focus, .form-group select:focus {
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
            transform: translateY(-2px);
            border-bottom: 3px solid #3498db;
            outline: none;
        }
        .form-group input:focus + label, .form-group select:focus + label {
            color: #3498db;
        }
        .form-group .icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #7f8c8d;
            font-size: 1.2em;
            transition: color 0.3s ease;
            z-index: 1;
        }
        .form-group input:focus ~ .icon, .form-group select:focus ~ .icon {
            color: #3498db;
        }
        .location-select {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 10px; 
            margin-top: 10px;
        }
        .location-select select:disabled {
    opacity: 1;
    color: #2c3e50;
}
        .payment-method {
            margin-top: 15px;
            padding: 15px;
            background: #fafafa;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }
        .payment-method h3 {
            font-size: 1.2em;
            color: #34495e;
            margin-bottom: 15px;
            font-weight: 600;
        }
        .payment-option {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .payment-option input[type="radio"] {
            margin-right: 10px;
        }
        .payment-option label {
            font-size: 1em;
            color: #2c3e50;
            cursor: pointer;
            display: flex;
            align-items: center;
        }
        .payment-option label i {
            margin-right: 8px;
            color: #7f8c8d;
            font-size: 1.2em;
        }
        .payment-option input[type="radio"]:checked + label i {
            color: #3498db;
        }
        .product-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95em;
        }
        .product-table th, .product-table td {
            padding: 12px;
            border: 1px solid #eee;
            text-align: left;
        }
        .product-table th {
            background: #34495e;
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .product-table td {
            background: #fff;
            color: #333;
        }
        .product-table tr:nth-child(even) td {
            background: #f9f9f9;
        }
        .product-table img {
            max-width: 50px;
            height: auto;
            border-radius: 4px;
        }
        .button-group {
            margin-top: 30px;
            text-align: center;
        }
        .btn {
            padding: 12px 25px;
            font-size: 1em;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .btn-success {
            background: #27ae60;
            border: none;
        }
        .btn-success:hover {
            background: #219653;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(39, 174, 96, 0.3);
        }
        .btn-back-cart {
            position: relative;
            padding: 12px 25px;
            font-size: 1em;
            color: #fff;
            background: #e74c3c;
            border: none;
            border-radius: 5px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .btn-back-cart::before {
            content: '\f112';
            font-family: "FontAwesome";
            margin-right: 8px;
        }
        .btn-back-cart:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.3);
        }
        .btn-back-cart::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.4s ease, height 0.4s ease;
        }
        .btn-back-cart:hover::after {
            width: 200px;
            height: 200px;
        }
        .btn-primary {
            background: #8e44ad;
            border: none;
            display: block;
            margin: 20px auto 0;
            width: fit-content;
        }
        .btn-primary:hover {
            background: #732d91;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(142, 68, 173, 0.3);
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <h1 class="title-main">Xác nhận thông tin thanh toán</h1>
        <%
            List<Cart> selectedItems = (List<Cart>) request.getAttribute("selectedItems");
            if (selectedItems == null || selectedItems.isEmpty()) {
                out.println("<p style='color: #e74c3c; text-align: center;'>" + 
                            (request.getAttribute("error") != null ? request.getAttribute("error") : "Không tìm thấy thông tin đơn hàng.") + 
                            "</p>");
            } else {
                java.util.Map<String, String> colorMap = new java.util.HashMap<>();
                colorMap.put("1", "Đen");
                colorMap.put("2", "Xám");
                colorMap.put("3", "Trắng");
                colorMap.put("4", "Be");
                colorMap.put("5", "Đỏ");
                colorMap.put("6", "Cam");
                colorMap.put("7", "Vàng");
                colorMap.put("8", "Nâu");
                colorMap.put("9", "Xanh sáng");
                colorMap.put("10", "Xanh đậm");
                colorMap.put("11", "Xanh lá");
        %>
        <form action="ConfirmPaymentServlet" method="post">
            <div class="flex-container">
                <!-- Phần thông tin thanh toán -->
                <div class="info-section">
                    <h2 class="section-title">Thông tin giao hàng</h2>
                    <p><strong>Mã đơn hàng:</strong> <%= request.getAttribute("orderId") != null ? request.getAttribute("orderId") : "Chưa xác định" %></p>
                    <div class="form-group">
                        <label>Họ tên:</label>
                        <div class="input-wrapper">
                            <input type="text" name="fullname" value="<%= request.getAttribute("fullname") %>" readonly required>
                            <span class="icon fa fa-user"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại:</label>
                        <div class="input-wrapper">
                            <input type="text" name="phone" value="<%= request.getAttribute("phone") %>" readonly required>
                            <span class="icon fa fa-phone"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <div class="input-wrapper">
                            <input type="email" name="email" value="<%= request.getAttribute("email") %>" readonly required>
                            <span class="icon fa fa-envelope"></span>
                        </div>
                    </div>
                    <div class="location-select">
                        <div class="form-group">
                            <label>Tỉnh/Thành phố:</label>
                            <div class="input-wrapper">
                                <select id="province" name="province" onchange="loadDistricts()" disabled required>
                                    <option value="" hidden>Chọn tỉnh/thành phố</option>
                                </select>
                                <span class="icon fa fa-map-marker"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Quận/Huyện:</label>
                            <div class="input-wrapper">
                                <select id="district" name="district" onchange="loadWards()" disabled required>
                                    <option value="" hidden>Chọn quận/huyện</option>
                                </select>
                                <span class="icon fa fa-map-signs"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Phường/Xã:</label>
                            <div class="input-wrapper">
                                <select id="ward" name="ward" disabled required>
                                    <option value="" hidden>Chọn xã/phường</option>
                                </select>
                                <span class="icon fa fa-road"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ chi tiết:</label>
                        <div class="input-wrapper">
                            <input type="text" name="address" value="<%= request.getAttribute("address") %>" readonly required>
                            <span class="icon fa fa-home"></span>
                        </div>
                    </div>
                </div>

                <!-- Phần danh sách sản phẩm và phương thức thanh toán -->
                <div class="product-section">
                    <h2 class="section-title">Danh sách sản phẩm</h2>
                    <table class="product-table">
                        <thead>
                            <tr>
                                <th>Ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Size</th>
                                <th>Màu</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Tổng</th>
                            </tr>
                        </thead>
                        <tbody>
    <%
        double totalAmount = 0; // Khai báo biến tổng tiền
        for (Cart item : selectedItems) {
            String colorName = colorMap.getOrDefault(item.getColor(), item.getColor());
            double itemTotal = item.getPrice() * item.getQuantity(); // Tổng tiền của từng sản phẩm
            totalAmount += itemTotal; // Cộng dồn vào tổng
    %>
    <tr>
        <td><img src="<%= item.getImage() %>" alt="<%= item.getName() %>"></td>
        <td><%= item.getName() %></td>
        <td><%= item.getSize() %></td>
        <td><%= colorName %></td>
        <td><%= item.getPrice() %>đ</td>
        <td><%= item.getQuantity() %></td>
        <td><%= itemTotal %>đ</td>
    </tr>
    <%
        }
    %>
</tbody>
<tfoot>
    <tr>
        <td colspan="6" style="text-align: right; font-weight: bold;">Tổng tiền:</td>
        <td><%= totalAmount %>đ</td>
    </tr>
</tfoot>
                    </table>
                    <div class="payment-method">
                        <h3>Phương thức thanh toán</h3>
                        <div class="payment-option">
                            <input type="radio" id="vnpay" name="paymentMethod" value="vnpay" required>
                            <label for="vnpay"><i class="fa fa-credit-card"></i> Thanh toán bằng VNPay</label>
                        </div>
                        <div class="payment-option">
                            <input type="radio" id="cod" name="paymentMethod" value="cod" required>
                            <label for="cod"><i class="fa fa-truck"></i> Thanh toán khi nhận hàng</label>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" name="orderId" value="<%= request.getAttribute("orderId") %>">
            <div class="button-group">
                <button type="submit" class="btn btn-success">Xác nhận và thanh toán</button>
                <a href="cartcontact.jsp" class="btn btn-back-cart">Quay lại giỏ hàng</a>
            </div>
        </form>
        <%
            }
        %>
        <a href="home.jsp" class="btn btn-primary">Quay về trang chủ</a>
    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        let locationData = {};

        async function loadProvinces(selectedProvince = "<%= request.getAttribute("province") != null ? (String) request.getAttribute("province") : "" %>") {
            console.log("Hàm loadProvinces đã được gọi với selectedProvince:", selectedProvince);
            try {
                const response = await fetch("js/tree.json");
                locationData = await response.json();

                const provinceSelect = document.getElementById("province");
                provinceSelect.innerHTML = '<option value="" hidden>Chọn tỉnh/thành phố</option>';

                for (const province of Object.values(locationData)) {
                    const option = document.createElement("option");
                    option.value = province.name_with_type;
                    option.textContent = province.name_with_type;
                    provinceSelect.appendChild(option);
                }
                if (selectedProvince) {
                    provinceSelect.value = selectedProvince;
                    loadDistricts(selectedProvince, "<%= request.getAttribute("district") != null ? (String) request.getAttribute("district") : "" %>");
                }
            } catch (error) {
                console.error("Lỗi tải dữ liệu:", error);
            }
        }

        async function loadDistricts(selectedProvince = "", selectedDistrict = "<%= request.getAttribute("district") != null ? (String) request.getAttribute("district") : "" %>") {
            const provinceName = selectedProvince || document.getElementById("province").value;
            const districtSelect = document.getElementById("district");
            districtSelect.innerHTML = '<option value="" hidden>Chọn quận/huyện</option>';

            const province = Object.values(locationData).find(p => p.name_with_type === provinceName);
            if (!province || !province["quan-huyen"]) return;

            for (const district of Object.values(province["quan-huyen"])) {
                const option = document.createElement("option");
                option.value = district.name_with_type;
                option.textContent = district.name_with_type;
                districtSelect.appendChild(option);
            }

            if (selectedDistrict) {
                districtSelect.value = selectedDistrict;
                loadWards(provinceName, selectedDistrict, "<%= request.getAttribute("ward") != null ? (String) request.getAttribute("ward") : "" %>");
            }
        }

        async function loadWards(selectedProvince = "", selectedDistrict = "", selectedWard = "<%= request.getAttribute("ward") != null ? (String) request.getAttribute("ward") : "" %>") {
            const provinceName = selectedProvince || document.getElementById("province").value;
            const districtName = selectedDistrict || document.getElementById("district").value;
            const wardSelect = document.getElementById("ward");
            wardSelect.innerHTML = '<option value="" hidden>Chọn xã/phường</option>';

            const province = Object.values(locationData).find(p => p.name_with_type === provinceName);
            if (!province) return;

            const district = Object.values(province["quan-huyen"]).find(d => d.name_with_type === districtName);
            if (!district || !district["xa-phuong"]) return;

            for (const ward of Object.values(district["xa-phuong"])) {
                const option = document.createElement("option");
                option.value = ward.name_with_type;
                option.textContent = ward.name_with_type;
                wardSelect.appendChild(option);
            }

            if (selectedWard) {
                wardSelect.value = selectedWard;
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            loadProvinces("<%= request.getAttribute("province") != null ? (String) request.getAttribute("province") : "" %>");
        });
    </script>
</body>
</html>