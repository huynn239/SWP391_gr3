package controller;

import dto.UserDAO;
import model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserControllerServlet", urlPatterns = {"/UserControllerServlet"})
public class UserControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String action = request.getParameter("action");

       try {
        if ("viewDetail".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            Account user = userDAO.getUserById(userId);
            if (user != null) {
                // Truyền các thuộc tính riêng lẻ vào request
                request.setAttribute("id", user.getId());
                request.setAttribute("uname", user.getuName());
                request.setAttribute("email", user.getEmail());
                request.setAttribute("mobile", user.getMobile());
                request.setAttribute("gender", user.getGender());
                request.setAttribute("uaddress", user.getuAddress());
                request.setAttribute("roleID", user.getRoleID()); // Đảm bảo set roleID
                request.getRequestDispatcher("UserDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=User+not+found");
            }
        } else if ("viewProfile".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            Account user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("Profile.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }
        } else if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            boolean success = userDAO.deleteUserByID(userId);
            request.setAttribute("message", success ? "Xóa người dùng thành công!" : "Xóa người dùng thất bại!");
            response.sendRedirect("UserControllerServlet");
        } else if ("addPage".equals(action)) {
            request.getRequestDispatcher("AddUser.jsp").forward(request, response);
        } else if ("editPage".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            Account user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("EditUser.jsp").forward(request, response);
            } else {
                response.sendRedirect("UserControllerServlet?message=User+not+found");
            }
        } else {
            List<Account> listU = userDAO.getUserList();
            request.setAttribute("listU", listU);
            request.getRequestDispatcher("UserList.jsp").forward(request, response);
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("error.jsp?message=Invalid+user+ID");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?message=Error+processing+request");
    }
}
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Account newUser = new Account(
                    request.getParameter("uName"),
                    request.getParameter("username"),
                    request.getParameter("password"),
                    request.getParameter("gender") != null ? request.getParameter("gender") : "0",
                    request.getParameter("email"),
                    request.getParameter("mobile"),
                    request.getParameter("uAddress"),
                    Integer.parseInt(request.getParameter("roleID"))
                );
                boolean success = userDAO.addUser(newUser);
                response.sendRedirect("UserControllerServlet?message=" + (success ? "User+added+successfully" : "Failed+to+add+user"));
            } else if ("updateProfile".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("id"));
                Account updatedUser = new Account(
                    userId,
                    request.getParameter("uName"),
                    request.getParameter("username"),
                    request.getParameter("password"),
                    request.getParameter("gender"),
                    request.getParameter("email"),
                    request.getParameter("mobile"),
                    request.getParameter("uAddress"),
                    Integer.parseInt(request.getParameter("roleID"))
                );
                boolean success = userDAO.editUser(userId, updatedUser);
                request.setAttribute("message", success ? "Cập nhật thông tin thành công!" : "Cập nhật thông tin thất bại!");
                response.sendRedirect("UserControllerServlet?action=viewProfile&id=" + userId);
            } else if ("edit".equals(action)) { // Xử lý submit form từ EditUser.jsp
                int userId = Integer.parseInt(request.getParameter("id"));
                Account updatedUser = new Account(
                    userId,
                    request.getParameter("uName"),
                    request.getParameter("username"),
                    request.getParameter("password"),
                    request.getParameter("gender") != null ? request.getParameter("gender") : "0",
                    request.getParameter("email"),
                    request.getParameter("mobile"),
                    request.getParameter("uAddress"),
                    Integer.parseInt(request.getParameter("roleID"))
                );
                boolean success = userDAO.editUser(userId, updatedUser);
                response.sendRedirect("UserControllerServlet?message=" + (success ? "User+updated+successfully" : "Failed+to+update+user"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Error+processing+request");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý người dùng";
    }
}