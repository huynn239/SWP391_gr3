package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author NBL
 */
@WebServlet(name = "UserVerify", urlPatterns = {"/UserVerify"})
public class UserVerify extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Long authTime = (Long) session.getAttribute("authTime");
        String sessionCode = (String) session.getAttribute("authCode");
        String inputCode = request.getParameter("authCode");

        long currentTime = System.currentTimeMillis();

        // Kiểm tra nếu mã xác thực đã hết hạn (sau 1 phút)
        if (authTime == null || (currentTime - authTime > 60000)) { // 60000ms = 1 phút
            session.removeAttribute("authCode");
            session.removeAttribute("authTime");
            request.setAttribute("error", "Mã xác thực đã hết hạn, vui lòng yêu cầu mã mới.");
            request.getRequestDispatcher("verifycode.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mã xác thực nhập vào
        if (sessionCode != null && sessionCode.equals(inputCode)) {
            session.removeAttribute("authCode"); // Xóa mã xác thực sau khi nhập đúng
            session.removeAttribute("authTime");
            session.removeAttribute("authEmail");
            session.setAttribute("message", "Xác thực thành công! Chào mừng bạn.");
            response.sendRedirect("home.jsp");

        } else {
            request.setAttribute("error", "Mã xác thực không chính xác, vui lòng thử lại.");
            request.getRequestDispatcher("verifycode.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
