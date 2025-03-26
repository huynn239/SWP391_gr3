

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.SliderDAO, dto.ProductDAO, dto.BlogDAO, dto.FeedbackDAO"%>
<%@page import="java.util.Calendar, java.text.SimpleDateFormat, java.sql.Date"%>
<%@page import="java.util.List, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Marketing Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome cho biểu tượng -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 30px;
        }
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
        }
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        .stat-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-card i {
            font-size: 2rem;
            color: #007bff;
            margin-bottom: 10px;
        }
        .stat-card h3 {
            font-size: 1.1rem;
            color: #555;
            margin: 10px 0;
        }
        .stat-card .number {
            font-size: 2rem;
            font-weight: bold;
            color: #2c3e50;
        }
        .trend-section {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .trend-section h2 {
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .date-form {
            display: flex;
            gap: 15px;
            align-items: center;
            margin-bottom: 20px;
        }
        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #5a6268;
            color: white;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h1><i class="fas fa-chart-line me-2"></i>Marketing Dashboard</h1>

        <%-- Phần Thống Kê --%>
        <div class="stats-section">
            <div class="stat-card">
                <i class="fas fa-box-open"></i>
                <h3>Tổng Sản Phẩm</h3>
                <div class="number">
                    <%
                        ProductDAO productDAO = new ProductDAO();
                        int productCount = productDAO.getAllProducts().size();
                        out.print(productCount);
                    %>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-blog"></i>
                <h3>Tổng Bài Viết</h3>
                <div class="number">
                    <%
                        BlogDAO blogDAO = new BlogDAO();
                        int blogCount = blogDAO.getTotalPages(1) * 1; // Giả định 1 mục mỗi trang
                        out.print(blogCount);
                    %>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-comments"></i>
                <h3>Tổng Phản Hồi</h3>
                <div class="number">
                    <%
                        FeedbackDAO feedbackDAO = new FeedbackDAO();
                        int feedbackCount = feedbackDAO.getAllFeedbacks().size();
                        out.print(feedbackCount);
                    %>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-images"></i>
                <h3>Tổng Slider</h3>
                <div class="number">
                    <%
                        SliderDAO sliderDAO = new SliderDAO();
                        int sliderCount = sliderDAO.getTotalSliders();
                        out.print(sliderCount);
                    %>
                </div>
            </div>
        </div>

        <%-- Xu Hướng Số Lượng Tăng Giảm --%>
        <div class="trend-section">
            <h2><i class="fas fa-chart-area me-2"></i> Xu Hướng Số Lượng Tăng Giảm Theo Ngày</h2>
            <canvas id="trendChart" height="100"></canvas>
            <%
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar startCal = Calendar.getInstance();
                Calendar endCal = Calendar.getInstance();

                
                if (startDateStr == null || endDateStr == null) {
                    endCal.setTime(new java.util.Date());
                    startCal.setTime(new java.util.Date());
                    startCal.add(Calendar.DAY_OF_MONTH, -6);
                } else {
                    startCal.setTime(sdf.parse(startDateStr));
                    endCal.setTime(sdf.parse(endDateStr));
                }

                List<String> dates = new ArrayList<>();
                List<Integer> productCounts = new ArrayList<>();
                List<Integer> blogCounts = new ArrayList<>();
                List<Integer> feedbackCounts = new ArrayList<>();
                List<Integer> sliderCounts = new ArrayList<>();

                while (!startCal.after(endCal)) {
                    String currentDate = sdf.format(startCal.getTime());
                    dates.add(currentDate);
                    
                    // Lấy số lượng theo ngày
                    productCounts.add(getCountByDate(productDAO, currentDate, "product"));
                    blogCounts.add(getCountByDate(blogDAO, currentDate, "blog"));
                    feedbackCounts.add(getCountByDate(feedbackDAO, currentDate, "feedback"));
                    sliderCounts.add(getCountByDate(sliderDAO, currentDate, "slider"));
                    
                    startCal.add(Calendar.DAY_OF_MONTH, 1);
                }
            %>
            <script>
                const ctx = document.getElementById('trendChart').getContext('2d');
                const trendChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: <%= new com.google.gson.Gson().toJson(dates) %>,
                        datasets: [
                            {
                                label: 'Sản Phẩm',
                                data: <%= new com.google.gson.Gson().toJson(productCounts) %>,
                                borderColor: '#007bff',
                                backgroundColor: 'rgba(0, 123, 255, 0.1)',
                                fill: true,
                                tension: 0.4
                            },
                            {
                                label: 'Bài Viết',
                                data: <%= new com.google.gson.Gson().toJson(blogCounts) %>,
                                borderColor: '#28a745',
                                backgroundColor: 'rgba(40, 167, 69, 0.1)',
                                fill: true,
                                tension: 0.4
                            },
                            {
                                label: 'Phản Hồi',
                                data: <%= new com.google.gson.Gson().toJson(feedbackCounts) %>,
                                borderColor: '#dc3545',
                                backgroundColor: 'rgba(220, 53, 69, 0.1)',
                                fill: true,
                                tension: 0.4
                            },
                            {
                                label: 'Slider',
                                data: <%= new com.google.gson.Gson().toJson(sliderCounts) %>,
                                borderColor: '#ffc107',
                                backgroundColor: 'rgba(255, 193, 7, 0.1)',
                                fill: true,
                                tension: 0.4
                            }
                        ]
                    },
                    options: {
                        scales: {
                            y: { beginAtZero: true }
                        },
                        plugins: {
                            legend: { display: true }
                        }
                    }
                });
            </script>
        </div>

        <a href="sliderList" class="back-button mt-4"><i class="fas fa-arrow-left me-2"></i> Back</a>
    </div>

    <%!
        private String getDefaultStartDate() {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, -6);
            return sdf.format(cal.getTime());
        }

        private String getDefaultEndDate() {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.format(new java.util.Date());
        }

        private int getCountByDate(Object dao, String date, String type) {
            // Thay bằng logic thực tế từ DAO
            if ("product".equals(type)) {
                return ((ProductDAO) dao).getCountByDate(date); // Cần thêm phương thức này trong ProductDAO
            } else if ("blog".equals(type)) {
                return ((BlogDAO) dao).getCountByDate(date);    // Cần thêm phương thức này trong BlogDAO
            } else if ("feedback".equals(type)) {
                return ((FeedbackDAO) dao).getCountByDate(date); // Cần thêm phương thức này trong FeedbackDAO
            } else if ("slider".equals(type)) {
                return ((SliderDAO) dao).getCountByDate(date);  // Cần thêm phương thức này trong SliderDAO
            }
            return 0; // Mặc định
        }
    %>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>