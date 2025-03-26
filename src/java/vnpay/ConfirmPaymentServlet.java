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
import dto.OrderDAO;
import dto.OrderdetailDAO;
import utils.EmailService;
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
        String orderIdStr = request.getParameter("orderId");
        OrderDAO o = new OrderDAO();
        OrderdetailDAO od = new OrderdetailDAO();

        int orderId = o.getFirstOrderID(user.getId());
        int subOrderId = o.getsuborderID(user.getId());
        double totalAmount = calculateTotalAmount(selectedItems);

        if ("vnpay".equals(paymentMethod)) {
            String paymentUrl = VNPayService.createPaymentUrl(request, selectedItems, orderIdStr);
            response.sendRedirect(paymentUrl);
        } else if ("cod".equals(paymentMethod)) {
            if (orderId != 0) {
                if (od.checkProductSizeAvailability(subOrderId)) {
                    o.updateLatestSuborderStatusToPending(orderId);
                    o.updateOrderTotalAndStatus(orderId);
                    od.updateProductSizeAfterPayment(subOrderId);

                    // Lấy thông tin từ suborder
                    String receiverName = od.getReceiverName(subOrderId);
                    String receiverAddress = od.getReceiverAddress(subOrderId);
                    String receiverEmail = od.getReceiverEmail(subOrderId); // Lấy email từ suborder

                    // Gửi email đến ReceiverEmail
                    if (receiverEmail != null && !receiverEmail.isEmpty()) {
                        EmailService.sendOrderConfirmationEmail(receiverEmail, selectedItems, orderId, 
                                                                receiverName, receiverAddress, totalAmount);
                    } else {
                        System.out.println("ReceiverEmail is null or empty for subOrderId: " + subOrderId);
                    }

                    session.removeAttribute("selectedItems");
                    response.sendRedirect("ordercod-success.jsp");
                } else {
                    request.setAttribute("error", "Số lượng sản phẩm không đủ!");
                    request.getRequestDispatcher("order-failure.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("cartdetail.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (request.getServletPath().equals("/vnpay-return")) {
            if (VNPayService.verifyPaymentResponse(request)) {
                String responseCode = VNPayService.getResponseCode(request);
                if ("00".equals(responseCode)) {
                    HttpSession session = request.getSession();
                    Account user = (Account) session.getAttribute("u");
                    OrderDAO o = new OrderDAO();
                    OrderdetailDAO od = new OrderdetailDAO();
                    int orderId = o.getFirstOrderID(user.getId());
                    int subOrderId = o.getsuborderID(user.getId());
                    List<Cart> selectedItems = (List<Cart>) session.getAttribute("selectedItems");
                    double totalAmount = calculateTotalAmount(selectedItems);

                    if (od.checkProductSizeAvailability(subOrderId)) {
                        o.updateLatestSuborderStatusToPaid(orderId);
                        o.updateOrderTotalAndStatus(orderId);
                        od.updateProductSizeAfterPayment(subOrderId);

                        // Lấy thông tin từ suborder
                        String receiverName = od.getReceiverName(subOrderId);
                        String receiverAddress = od.getReceiverAddress(subOrderId);
                        String receiverEmail = od.getReceiverEmail(subOrderId); // Lấy email từ suborder

                        // Gửi email đến ReceiverEmail
                        if (receiverEmail != null && !receiverEmail.isEmpty()) {
                            EmailService.sendOrderConfirmationEmail(receiverEmail, selectedItems, orderId, 
                                                                    receiverName, receiverAddress, totalAmount);
                        } else {
                            System.out.println("ReceiverEmail is null or empty for subOrderId: " + subOrderId);
                        }

                        session.removeAttribute("selectedItems");
                        request.setAttribute("message", "Thanh toán thành công! Mã giao dịch: " + VNPayService.getTransactionRef(request));
                        request.getRequestDispatcher("order-success.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Số lượng sản phẩm không đủ!");
                        request.getRequestDispatcher("order-failure.jsp").forward(request, response);
                    }
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

    private double calculateTotalAmount(List<Cart> selectedItems) {
        double total = 0;
        for (Cart item : selectedItems) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
}