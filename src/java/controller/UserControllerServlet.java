package controller;

import dto.UserDAO;
import model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserControllerServlet", urlPatterns = {"/UserControllerServlet"})
public class UserControllerServlet extends HttpServlet {

    @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
            UserDAO userDAO = new UserDAO();
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            Account loggedInUser = (Account) session.getAttribute("u"); // Lấy user từ session

            try {
                if ("viewProfile".equals(action)) {
                    if (loggedInUser == null) {
                        response.sendRedirect("login.jsp?message=Please+login+to+view+your+profile");
                        return;
                    }
                    int userId = Integer.parseInt(request.getParameter("id"));
                    if (userId != loggedInUser.getId()) {
                        response.sendRedirect("error.jsp?message=You+can+only+view+your+own+profile");
                        return;
                    }
                    Account user = userDAO.getUserById(userId);
                    if (user != null) {
                        request.setAttribute("user", user);
                        String message = request.getParameter("message");
                        if (message != null) {
                            request.setAttribute("message", message);
                        }
                        request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp?message=User+not+found");
                    }
                } else if ("viewDetail".equals(action)) {
                    if (loggedInUser == null) {
                        response.sendRedirect("login.jsp?message=Please+login+to+view+user+details");
                        return;
                    }
                    int userId = Integer.parseInt(request.getParameter("id"));
                    Account user = userDAO.getUserById(userId);
                    if (user != null) {
                        request.setAttribute("id", user.getId());
                        request.setAttribute("uname", user.getuName());
                        request.setAttribute("email", user.getEmail());
                        request.setAttribute("mobile", user.getMobile());
                        request.setAttribute("gender", user.getGender());
                        request.setAttribute("uaddress", user.getuAddress());
                        request.setAttribute("roleID", user.getRoleID());
                        request.getRequestDispatcher("UserDetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp?message=User+not+found");
                    }
                } else if ("delete".equals(action)) {
                    if (loggedInUser == null) {
                        response.sendRedirect("login.jsp?message=Please+login+to+perform+this+action");
                        return;
                    }
                    int userId = Integer.parseInt(request.getParameter("id"));
                    boolean success = userDAO.deleteUserByID(userId);
                    request.setAttribute("message", success ? "Xóa người dùng thành công!" : "Xóa người dùng thất bại!");
                    response.sendRedirect("UserControllerServlet");
                } else if ("addPage".equals(action)) {
                    if (loggedInUser == null) {
                        response.sendRedirect("login.jsp?message=Please+login+to+perform+this+action");
                        return;
                    }
                    request.getRequestDispatcher("AddUser.jsp").forward(request, response);
                } else if ("editPage".equals(action)) {
                    if (loggedInUser == null) {
                        response.sendRedirect("login.jsp?message=Please+login+to+perform+this+action");
                        return;
                    }
                    int userId = Integer.parseInt(request.getParameter("id"));
                    // Chỉ Admin hoặc người dùng chỉnh sửa chính họ được phép truy cập
                    if (loggedInUser.getRoleID() != 1 && userId != loggedInUser.getId()) {
                        response.sendRedirect("error.jsp?message=You+can+only+edit+your+own+profile");
                        return;
                    }
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
            HttpSession session = request.getSession();
            Account loggedInUser = (Account) session.getAttribute("u");

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
                    response.sendRedirect("UserControllerServlet?action=viewProfile&id=" + userId + "&message=" + 
                        (success ? "Profile+updated+successfully" : "Failed+to+update+profile"));
                } else if ("edit".equals(action)) {
                    if (loggedInUser == null) {
                        response.sendRedirect("login.jsp?message=Please+login+to+perform+this+action");
                        return;
                    }
                    int userId = Integer.parseInt(request.getParameter("id"));
                    // Chỉ Admin hoặc người dùng chỉnh sửa chính họ được phép
                    if (loggedInUser.getRoleID() != 1 && userId != loggedInUser.getId()) {
                        response.sendRedirect("error.jsp?message=You+can+only+edit+your+own+profile");
                        return;
                    }

                    // Nếu không phải Admin, giữ nguyên roleID hiện tại
                    int newRoleID = Integer.parseInt(request.getParameter("roleID"));
                    Account userToEdit = userDAO.getUserById(userId);
                    if (loggedInUser.getRoleID() != 1) {
                        newRoleID = userToEdit.getRoleID(); // Giữ nguyên roleID nếu không phải Admin
                    }

                    Account updatedUser = new Account(
                        userId,
                        request.getParameter("uName"),
                        request.getParameter("username"),
                        request.getParameter("password"),
                        request.getParameter("gender") != null ? request.getParameter("gender") : "0",
                        request.getParameter("email"),
                        request.getParameter("mobile"),
                        request.getParameter("uAddress"),
                        newRoleID
                    );
                    boolean success = userDAO.editUser(userId, updatedUser);
                    if (success) {
                        response.sendRedirect("UserControllerServlet?action=viewDetail&id=" + userId + "&message=User+updated+successfully");
                    } else {
                        response.sendRedirect("UserControllerServlet?action=editPage&id=" + userId + "&message=Failed+to+update+user");
                    }
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