<%-- 
    Document   : mkt
    Created on : 5 Mar 2025, 2:49:18 pm
    Author     : NBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="position-sticky">
                        <ul class="nav flex-column p-3">
                            <li class="nav-item">
                                <a class="nav-link active" href="home.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="UserControllerServlet">
                                    <i class="fas fa-users"></i> Users
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="productlistsevlet">
                                    <i class="fas fa-box"></i> Products
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="FeedbackListControllerServlet">
                                    <i class="fas fa-comments"></i> Feedback
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="approverequest">
                                    <i class="fas fa-comments"></i> Approve request 
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Main Content -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <h2 class="mt-4">Admin Dashboard</h2>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="card text-center p-3">
                                <h5>Total Page Views</h5>
                                <h2>442,236</h2>
                                <span class="text-success">+59.3%</span>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center p-3">
                                <h5>Total Users</h5>
                                <h2>78,250</h2>
                                <span class="text-success">+70.5%</span>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center p-3">
                                <h5>Total Orders</h5>
                                <h2>18,800</h2>
                                <span class="text-danger">-27.4%</span>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center p-3">
                                <h5>Total Sales</h5>
                                <h2>$35,078</h2>
                                <span class="text-danger">-27.4%</span>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-header">Unique Visitors</div>
                                <div class="card-body">
                                    <canvas id="visitorChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">Income Overview</div>
                                <div class="card-body">
                                    <h4 class="text-center">$7,650</h4>
                                    <canvas id="incomeChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const visitorCtx = document.getElementById('visitorChart').getContext('2d');
                new Chart(visitorCtx, {
                    type: 'line',
                    data: {
                        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        datasets: [{
                                label: 'Page Views',
                                data: [30, 50, 40, 60, 80, 120, 100],
                                borderColor: 'rgba(54, 162, 235, 1)',
                                fill: true,
                                backgroundColor: 'rgba(54, 162, 235, 0.2)'
                            }, {
                                label: 'Sessions',
                                data: [20, 40, 35, 50, 60, 90, 80],
                                borderColor: 'rgba(75, 192, 192, 1)',
                                fill: true,
                                backgroundColor: 'rgba(75, 192, 192, 0.2)'
                            }]
                    },
                    options: {
                        responsive: true
                    }
                });

                const incomeCtx = document.getElementById('incomeChart').getContext('2d');
                new Chart(incomeCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
                        datasets: [{
                                label: 'Income',
                                data: [700, 1200, 900, 600, 850, 750, 950],
                                backgroundColor: 'rgba(54, 162, 235, 0.6)'
                            }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {beginAtZero: true}
                        }
                    }
                });
            });
        </script>
    </body>
</html>