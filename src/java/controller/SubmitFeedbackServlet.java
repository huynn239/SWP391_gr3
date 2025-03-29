package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Feedback;
import model.Account;
import dto.FeedbackDAO;
import dto.ProductDAO;
import dto.UserDAO;
import model.Product;
import dto.UserAdminDAO;

@WebServlet("/submitFeedback")
public class SubmitFeedbackServlet extends HttpServlet {
    private FeedbackDAO feedbackDAO;
    private ProductDAO productDAO;
    private UserAdminDAO accountDAO;

    @Override
    public void init() throws ServletException {
        feedbackDAO = new FeedbackDAO();
        productDAO = new ProductDAO();
        accountDAO = new UserAdminDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy session để kiểm tra người dùng
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");

        // Kiểm tra đăng nhập (vì UsersID là NOT NULL)
        if (user == null) {
            response.sendRedirect("login.jsp?message=Please login to submit feedback");
            return;
        }

        int userId = user.getId();

        // Kiểm tra userId có tồn tại trong bảng users không
        if (!accountDAO.userExists(userId)) {
            response.sendRedirect("productDetail.jsp?error=User not found");
            return;
        }

        // Lấy thông tin từ form
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (NumberFormatException e) {
            response.sendRedirect("productDetail.jsp?error=Invalid product ID");
            return;
        }

        // Kiểm tra productId
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&error=Product not found");
            return;
        }

        String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName") : "";
        String email = request.getParameter("email") != null ? request.getParameter("email") : "";
        String mobile = request.getParameter("mobile") != null ? request.getParameter("mobile") : "";
        String comment = request.getParameter("comment") != null ? request.getParameter("comment") : "";
        int ratedStar;
        try {
            ratedStar = Integer.parseInt(request.getParameter("ratedStar"));
        } catch (NumberFormatException e) {
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&error=Invalid rating");
            return;
        }

        // Kiểm tra các trường bắt buộc (NOT NULL)
        if (fullName.isEmpty()) {
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&error=Full name is required");
            return;
        }
        if (email.isEmpty()) {
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&error=Email is required");
            return;
        }
        if (mobile.isEmpty()) {
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&error=Mobile is required");
            return;
        }
        if (ratedStar < 1 || ratedStar > 5) { // Giả sử ratedStar từ 1 đến 5
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&error=Invalid rating value");
            return;
        }

        // Tạo đối tượng Feedback
        Feedback feedback = new Feedback();
        feedback.setProductId(productId);
        feedback.setUserId(userId);
        feedback.setFullName(fullName);
        feedback.setEmail(email);
        feedback.setMobile(mobile);
        feedback.setComment(comment);
        feedback.setRatedStar(ratedStar);

        // Log dữ liệu trước khi lưu
        System.out.println("Feedback data: productId=" + feedback.getProductId() + 
                          ", userId=" + feedback.getUserId() + 
                          ", fullName=" + feedback.getFullName() + 
                          ", email=" + feedback.getEmail() + 
                          ", mobile=" + feedback.getMobile() + 
                          ", comment=" + feedback.getComment() + 
                          ", ratedStar=" + feedback.getRatedStar());

        // Lưu vào cơ sở dữ liệu
        boolean success = feedbackDAO.addFeedback(feedback);

        if (success) {
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&message=Feedback submitted successfully!");
        } else {
            response.sendRedirect("productDetail.jsp?productId=" + productId + "&error=Failed to submit feedback");
        }
    }
}