<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Cart" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Confirmation</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <style>
        /* Stunning Design */
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200"%3E%3Ccircle fill="rgba(255,255,255,0.05)" cx="50" cy="50" r="5"/%3E%3Ccircle fill="rgba(255,255,255,0.03)" cx="150" cy="150" r="3"/%3E%3C/svg%3E');
            animation: floatParticles 20s infinite linear;
            pointer-events: none;
        }

        @keyframes floatParticles {
            0% { transform: translateY(0); }
            100% { transform: translateY(-100vh); }
        }

        .payment-container {
            max-width: 1200px;
            margin: 60px auto;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .title-main {
            text-align: center;
            margin-bottom: 40px;
            font-size: 2.5em;
            font-weight: 800;
            text-transform: uppercase;
            background: linear-gradient(90deg, #00d2ff, #3a7bd5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 20px rgba(0, 210, 255, 0.5);
            transition: all 0.4s ease;
        }

        .title-main:hover {
            transform: scale(1.05);
            text-shadow: 0 0 30px rgba(0, 210, 255, 0.8);
        }

        .flex-container {
            display: flex;
            justify-content: space-between;
            gap: 40px;
        }

        .info-section, .product-section {
            flex: 1;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .info-section:hover, .product-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .section-title {
            font-size: 1.8em;
            font-weight: 700;
            color: #1e3c72;
            margin-bottom: 25px;
            padding: 10px 20px;
            background: linear-gradient(90deg, #3a7bd5, #00d2ff);
            color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 210, 255, 0.3);
            position: relative;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 15px 15px 15px 45px; /* Thêm padding trái để chừa chỗ cho icon */
            border: none;
            border-radius: 10px;
            font-size: 1em;
            background: rgba(255, 255, 255, 0.9);
            color: #2c3e50;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .form-group input:focus, .form-group select:focus {
            box-shadow: 0 8px 20px rgba(0, 210, 255, 0.4);
            transform: translateY(-2px);
            border-bottom: 3px solid #00d2ff;
            outline: none;
        }

        .form-group select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
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
            color: #00d2ff;
        }

        .location-select {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin: 15px 0;
        }

        .location-select select:disabled {
            opacity: 1;
            color: #2c3e50;
        }

        .payment-method {
            margin-top: 20px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .payment-method h3 {
            font-size: 1.4em;
            color: #1e3c72;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .payment-option {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .payment-option:hover {
            background: rgba(0, 210, 255, 0.1);
        }

        .payment-option input[type="radio"] {
            margin-right: 15px;
        }

        .payment-option label {
            font-size: 1.1em;
            color: #2c3e50;
            cursor: pointer;
            display: flex;
            align-items: center;
        }

        .payment-option label i {
            margin-right: 10px;
            color: #7f8c8d;
            font-size: 1.4em;
            transition: color 0.3s ease;
        }

        .payment-option input[type="radio"]:checked + label i {
            color: #00d2ff;
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1em;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .product-table th, .product-table td {
            padding: 15px;
            text-align: left;
        }

        .product-table th {
            background: linear-gradient(90deg, #1e3c72, #3a7bd5);
            color: #fff;
            font-weight: 700;
            text-transform: uppercase;
        }

        .product-table td {
            background: #fff;
            color: #333;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .product-table tr:nth-child(even) td {
            background: #f9f9f9;
        }

        .product-table img {
            max-width: 60px;
            height: auto;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
       

 }

        .button-group {
            margin-top: 40px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .btn {
            padding: 15px 30px;
            font-size: 1.1em;
            border-radius: 50px;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-success {
            background: linear-gradient(90deg, #27ae60, #2ecc71);
            border: none;
            color: #fff;
        }

        .btn-success:hover {
            background: linear-gradient(90deg, #219653, #27ae60);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(39, 174, 96, 0.4);
        }

        .btn-back-cart {
            background: linear-gradient(90deg, #e74c3c, #ff6b6b);
            border: none;
            color: #fff;
        }

        .btn-back-cart::before {
            content: '\f112';
            font-family: "FontAwesome";
            margin-right: 10px;
        }

        .btn-back-cart:hover {
            background: linear-gradient(90deg, #c0392b, #e74c3c);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(231, 76, 60, 0.4);
        }

        .btn-primary {
            background: linear-gradient(90deg, #8e44ad, #9b59b6);
            border: none;
            color: #fff;
            display: block;
            margin: 30px auto 0;
            width: fit-content;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #732d91, #8e44ad);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(142, 68, 173, 0.4);
        }

        .btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.4s ease, height 0.4s ease;
        }

        .btn:hover::after {
            width: 300px;
            height: 300px;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <h1 class="title-main">Payment Confirmation</h1>
        <%
            List<Cart> selectedItems = (List<Cart>) request.getAttribute("selectedItems");
            if (selectedItems == null || selectedItems.isEmpty()) {
                out.println("<p style='color: #e74c3c; text-align: center;'>" + 
                            (request.getAttribute("error") != null ? request.getAttribute("error") : "No order information found.") + 
                            "</p>");
            } else {
                java.util.Map<String, String> colorMap = new java.util.HashMap<>();
                colorMap.put("1", "Black");
                colorMap.put("2", "Gray");
                colorMap.put("3", "White");
                colorMap.put("4", "Beige");
                colorMap.put("5", "Red");
                colorMap.put("6", "Orange");
                colorMap.put("7", "Yellow");
                colorMap.put("8", "Brown");
                colorMap.put("9", "Light Blue");
                colorMap.put("10", "Dark Blue");
                colorMap.put("11", "Green");
        %>
        <form action="ConfirmPaymentServlet" method="post">
            <div class="flex-container">
                <!-- Shipping Information Section -->
                <div class="info-section">
                    <h2 class="section-title">Shipping Information</h2>
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" name="fullname" value="<%= request.getAttribute("fullname") %>" readonly required placeholder="Full Name">
                            <span class="icon fa fa-user"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" name="phone" value="<%= request.getAttribute("phone") %>" readonly required placeholder="Phone Number">
                            <span class="icon fa fa-phone"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="email" name="email" value="<%= request.getAttribute("email") %>" readonly required placeholder="Email">
                            <span class="icon fa fa-envelope"></span>
                        </div>
                    </div>
                    <div class="location-select">
                        <div class="form-group">
                            <div class="input-wrapper">
                                <select id="province" name="province" onchange="loadDistricts()" disabled required>
                                    <option value="" hidden>Select Province/City</option>
                                </select>
                                <span class="icon fa fa-map-marker"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-wrapper">
                                <select id="district" name="district" onchange="loadWards()" disabled required>
                                    <option value="" hidden>Select District</option>
                                </select>
                                <span class="icon fa fa-map-signs"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-wrapper">
                                <select id="ward" name="ward" disabled required>
                                    <option value="" hidden>Select Ward</option>
                                </select>
                                <span class="icon fa fa-road"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" name="address" value="<%= request.getAttribute("address") %>" readonly required placeholder="Detailed Address">
                            <span class="icon fa fa-home"></span>
                        </div>
                    </div>
                </div>

                <!-- Product List and Payment Method Section -->
                <div class="product-section">
                    <h2 class="section-title">Product List</h2>
                    <table class="product-table">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Product Name</th>
                                <th>Size</th>
                                <th>Color</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                double totalAmount = 0;
                                for (Cart item : selectedItems) {
                                    String colorName = colorMap.getOrDefault(item.getColor(), item.getColor());
                                    double itemTotal = item.getPrice() * item.getQuantity();
                                    totalAmount += itemTotal;
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
                                <td colspan="6" style="text-align: right; font-weight: bold;">Total Amount:</td>
                                <td><%= totalAmount %>đ</td>
                            </tr>
                        </tfoot>
                    </table>
                    <div class="payment-method">
                        <h3>Payment Method</h3>
                        <div class="payment-option">
                            <input type="radio" id="vnpay" name="paymentMethod" value="vnpay" required>
                            <label for="vnpay"><i class="fa fa-credit-card"></i> Pay with VNPay</label>
                        </div>
                        <div class="payment-option">
                            <input type="radio" id="cod" name="paymentMethod" value="cod" required>
                            <label for="cod"><i class="fa fa-truck"></i> Cash on Delivery</label>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" name="orderId" value="<%= request.getAttribute("orderId") %>">
            <div class="button-group">
                <button type="submit" class="btn btn-success">Confirm and Pay</button>
                <a href="cartcontact.jsp" class="btn btn-back-cart">Back to Cart</a>
            </div>
        </form>
        <%
            }
        %>
        <a href="home.jsp" class="btn btn-primary">Back to Home</a>
    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        let locationData = {};

        async function loadProvinces(selectedProvince = "<%= request.getAttribute("province") != null ? (String) request.getAttribute("province") : "" %>") {
            try {
                const response = await fetch("js/tree.json");
                locationData = await response.json();

                const provinceSelect = document.getElementById("province");
                provinceSelect.innerHTML = '<option value="" hidden>Select Province/City</option>';

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
                console.error("Error loading data:", error);
            }
        }

        async function loadDistricts(selectedProvince = "", selectedDistrict = "<%= request.getAttribute("district") != null ? (String) request.getAttribute("district") : "" %>") {
            const provinceName = selectedProvince || document.getElementById("province").value;
            const districtSelect = document.getElementById("district");
            districtSelect.innerHTML = '<option value="" hidden>Select District</option>';

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
            wardSelect.innerHTML = '<option value="" hidden>Select Ward</option>';

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