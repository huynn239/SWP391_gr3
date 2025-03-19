package vnpay;

import vnpay.VNPayService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Cart;

import java.io.IOException;
import java.util.List;

@WebServlet({"/ConfirmPaymentServlet", "/vnpay-return"})
public class ConfirmPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        List<Cart> selectedItems = (List<Cart>) session.getAttribute("selectedItems");
        String orderId = request.getParameter("orderId");

        if ("vnpay".equals(paymentMethod)) {
            String paymentUrl = VNPayService.createPaymentUrl(request, selectedItems, orderId);
            response.sendRedirect(paymentUrl); // Chuyển hướng đến VNPay
        } else if ("cod".equals(paymentMethod)) {
            // Xử lý thanh toán COD
            response.sendRedirect("ordercod-success.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Xử lý phản hồi từ VNPay (khi URL là /vnpay-return)
        if (request.getServletPath().equals("/vnpay-return")) {
            if (VNPayService.verifyPaymentResponse(request)) {
                String responseCode = VNPayService.getResponseCode(request);
                if ("00".equals(responseCode)) {
                    request.setAttribute("message", "Thanh toán thành công! Mã giao dịch: " + VNPayService.getTransactionRef(request));
                    request.getRequestDispatcher("order-success.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Thanh toán thất bại! Mã lỗi: " + responseCode);
                    request.getRequestDispatcher("order-failure.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Chữ ký không hợp lệ!");
                request.getRequestDispatcher("order-failure.jsp").forward(request, response);
            }
        }
    }
}