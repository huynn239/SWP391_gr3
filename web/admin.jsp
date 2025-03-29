<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
<%@ page import="dto.DashboardDAO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f7fa;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        .sidebar {
            background-color: #2c3e50;
            color: white;
            height: 100vh;
            padding-top: 20px;
            position: fixed;
            width: 220px;
        }
        .sidebar .nav-link {
            color: #ecf0f1;
            font-size: 15px;
            text-transform: uppercase;
            font-weight: 500;
            padding: 12px 20px;
            transition: background-color 0.3s;
        }
        .sidebar .nav-link:hover {
            background-color: #34495e;
            border-radius: 4px;
        }
        .sidebar .nav-link.active {
            background-color: #3498db;
        }
        .main-content {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 40px;
            margin: 0 auto;
            max-width: 1400px;
            margin-top: 40px;
            margin-bottom: 80px;
        }
        .card {
            border: none;
            border-radius: 8px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card h5 {
            font-size: 1rem;
            color: #7f8c8d;
            margin-bottom: 10px;
        }
        .card h2 {
            font-size: 2rem;
            color: #2c3e50;
            font-weight: 600;
        }
        .footer {
            text-align: center;
            padding: 15px;
            background-color: #2c3e50;
            color: #ecf0f1;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .chart-container {
            margin-top: 40px;
            max-width: 1200px; /* Tăng kích thước biểu đồ để lấp đầy không gian */
            height: 400px; /* Chiều cao lớn hơn */
            margin-left: auto;
            margin-right: auto;
        }
        .trend-section {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 30px;
        }
        .trend-section h2 {
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%
        DashboardDAO dao = null;
        try {
            dao = new DashboardDAO();
            int totalUsers = dao.getTotalUsers();
            int totalOrders = dao.getTotalOrders();
            double totalSales = dao.getTotalSales();
            List<Integer> dailyOrders = dao.getDailyOrdersLast7Days();
            List<Double> dailySales = dao.getDailySalesLast7Days();

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalSales", totalSales);
            request.setAttribute("dailyOrders", dailyOrders);
            request.setAttribute("dailySales", dailySales);

            System.out.println("Total Users: " + totalUsers);
            System.out.println("Total Orders: " + totalOrders);
            System.out.println("Total Sales: " + totalSales);
            System.out.println("Daily Orders: " + dailyOrders);
            System.out.println("Daily Sales: " + dailySales);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
        }
    %>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-2 d-none d-md-block sidebar">
                <div class="position-sticky">
                    <ul class="nav flex-column p-3">
                        <li class="nav-item">
                            <a class="nav-link" href="UserControllerServlet">
                                <i class="material-icons">person</i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="productlistsevlet">
                                <i class="material-icons">inventory</i> Products
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="FeedbackListControllerServlet">
                                <i class="material-icons">feedback</i> Feedback
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SettingController">
                                <i class="material-icons">settings</i> Settings
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MyOrderServlet">
                                <i class="material-icons">shopping_cart</i> My Orders
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="approverequest">
                                <i class="material-icons">check_circle</i> Approve Request
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-10 ms-sm-auto px-md-4">
                <div class="main-content">
                    <h2 class="mt-2 mb-4 text-center">Admin Dashboard</h2>
                    <div class="row g-4 justify-content-center">
                        <div class="col-md-3">
                            <div class="card text-center">
                                <i class="fas fa-users fa-2x mb-2"></i>
                                <h5>Total Users</h5>
                                <h2>${totalUsers}</h2>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <i class="fas fa-shopping-cart fa-2x mb-2"></i>
                                <h5>Total Orders</h5>
                                <h2>${totalOrders}</h2>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <i class="fas fa-money-bill-wave fa-2x mb-2"></i>
                                <h5>Total Sales</h5>
                                <h2>
                                    <fmt:formatNumber value="${totalSales}" type="number" pattern="###,###.00"/> VNĐ
                                </h2>
                            </div>
                        </div>
                    </div>

                    <!-- Trend Section for Orders -->
                    <div class="trend-section">
                        <h2><i class="fas fa-chart-area me-2"></i> Xu Hướng Số Lượng Đơn Hàng Theo Ngày</h2>
                        <div class="chart-container">
                            <canvas id="ordersChart"></canvas>
                        </div>
                    </div>

                    <!-- Trend Section for Sales -->
                    <div class="trend-section">
                        <h2><i class="fas fa-chart-area me-2"></i> Xu Hướng Doanh Thu Theo Ngày</h2>
                        <div class="chart-container">
                            <canvas id="salesChart"></canvas>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
<!--
     Footer 
    <div class="footer">
        <p>© 2025 Admin Dashboard | All Rights Reserved</p>
    </div>-->

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Lấy dữ liệu từ JSP
        const dailyOrders = <%= request.getAttribute("dailyOrders") %>;
        const dailySales = <%= request.getAttribute("dailySales") %>;

        // Tạo nhãn cho 7 ngày gần nhất
        const labels = [];
        for (let i = 6; i >= 0; i--) {
            const date = new Date();
            date.setDate(date.getDate() - i);
            labels.push(date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' }));
        }

        // Biểu đồ Total Orders
        const ordersCtx = document.getElementById('ordersChart').getContext('2d');
        new Chart(ordersCtx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Total Orders',
                    data: dailyOrders,
                    borderColor: '#007bff',
                    backgroundColor: 'rgba(0, 123, 255, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Orders'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Date'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });

        // Biểu đồ Total Sales
        const salesCtx = document.getElementById('salesChart').getContext('2d');
        new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Total Sales (VNĐ)',
                    data: dailySales,
                    borderColor: '#28a745',
                    backgroundColor: 'rgba(40, 167, 69, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Sales (VNĐ)'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Date'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });
    </script>
</body>
</html>