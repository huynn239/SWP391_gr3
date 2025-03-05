package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;

@WebFilter(urlPatterns = {"/*"}) // Áp dụng cho tất cả các trang
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false); // Lấy session hiện tại (không tạo mới)

        Account user = (session != null) ? (Account) session.getAttribute("u") : null;
        String uri = req.getRequestURI(); // Lấy đường dẫn trang web

        // Nếu truy cập các trang yêu cầu quyền mà chưa login
        if (user == null && (uri.contains("admin.jsp") || uri.contains("mkt.jsp") || uri.contains("sale.jsp"))) {
            res.sendRedirect("accessdenied.jsp");
            return;
        }

        // Kiểm tra quyền truy cập từng trang
        if ((uri.contains("admin.jsp") && user.getRoleID() != 1) ||
            (uri.contains("mkt.jsp") && user.getRoleID() != 2) ||
            (uri.contains("sale.jsp") && user.getRoleID() != 3)) {
            res.sendRedirect("accessdenied.jsp"); // Chuyển về home nếu không đủ quyền
            return;
        }

        // Nếu hợp lệ, tiếp tục request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
