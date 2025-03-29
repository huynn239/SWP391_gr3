package controller;

import dto.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author NBL
 */
@WebServlet(name = "UserVerify", urlPatterns = {"/verifycode"})
public class UserVerify_1 extends HttpServlet {

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
            request.setAttribute("error", "Verification code has expired, please request a new code.");
            request.getRequestDispatcher("verifycode.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mã xác thực nhập vào
        if (sessionCode != null && sessionCode.equals(inputCode)) {
            UserDAO userdao = new UserDAO();
            Account tempAccount = (Account) session.getAttribute("tempAccount");

            if (tempAccount != null) {
                userdao.register(tempAccount.getUsername(), tempAccount.getEmail(),
                        tempAccount.getPassword(), tempAccount.getuName(),
                        tempAccount.getMobile(), tempAccount.getuAddress());
            }

            session.removeAttribute("tempAccount"); // Xóa tài khoản tạm
            session.removeAttribute("authCode");
            session.removeAttribute("authTime");
            session.removeAttribute("authEmail");

        //    session.setAttribute("message", "Xác thực thành công! Chào mừng bạn.");
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "The verification code is incorrect, please try again.");
            request.getRequestDispatcher("verifycode.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    request.getRequestDispatcher("verifycode.jsp").forward(request, response);
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
