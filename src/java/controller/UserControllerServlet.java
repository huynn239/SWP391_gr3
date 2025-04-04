package controller;

import dto.UserAdminDAO;
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
        UserAdminDAO userDAO = new UserAdminDAO();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("u");

        try {
            if ("viewDetail".equals(action)) {
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
                response.sendRedirect("UserControllerServlet?message=" + (success ? "User+deleted+successfully" : "Failed+to+delete+user"));
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
                String gender = request.getParameter("gender");
                Integer roleId = request.getParameter("roleId") != null && !request.getParameter("roleId").isEmpty() 
                        ? Integer.parseInt(request.getParameter("roleId")) : null;
                Integer status = request.getParameter("status") != null && !request.getParameter("status").isEmpty() 
                        ? Integer.parseInt(request.getParameter("status")) : null;
                String keyword = request.getParameter("keyword");

                List<Account> listU;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    listU = userDAO.searchUser(keyword);
                    // Lọc lại chỉ lấy Marketing (RoleID = 2) và Sale (RoleID = 3)
                    listU.removeIf(user -> user.getRoleID() != 2 && user.getRoleID() != 3);
                } else {
                    // Nếu roleId không phải 2 hoặc 3, đặt lại thành null để lấy cả Marketing và Sale
                    if (roleId != null && roleId != 2 && roleId != 3) {
                        roleId = null;
                    }
                    listU = userDAO.getFilteredUserList(gender, roleId, status);
                    // Đảm bảo chỉ lấy Marketing và Sale
                    listU.removeIf(user -> user.getRoleID() != 2 && user.getRoleID() != 3);
                }

                request.setAttribute("listU", listU);
                request.getRequestDispatcher("UserList.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException in UserControllerServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Invalid+input");
        } catch (Exception e) {
            System.out.println("Exception in UserControllerServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Error+processing+request");
        }
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    UserAdminDAO userDAO = new UserAdminDAO();
    String action = request.getParameter("action");
    HttpSession session = request.getSession();
    Account loggedInUser = (Account) session.getAttribute("u");

    try {
        if ("edit".equals(action)) {
            if (loggedInUser == null) {
                response.sendRedirect("login.jsp?message=Please+login+to+perform+this+action");
                return;
            }
            int userId = Integer.parseInt(request.getParameter("id"));
            if (loggedInUser.getRoleID() != 1 && userId != loggedInUser.getId()) {
                response.sendRedirect("error.jsp?message=You+can+only+edit+your+own+profile");
                return;
            }

            // Lấy thông tin từ form, không lấy username và password
            Account updatedUser = new Account(
                userId,
                request.getParameter("uName"),  // Lấy uName
                null,  // Không lấy username
                null,  // Không lấy password
                request.getParameter("gender"),  // Lấy gender
                request.getParameter("email"),  // Lấy email
                request.getParameter("mobile"),  // Lấy mobile
                request.getParameter("uAddress"),  // Lấy address
                loggedInUser.getRoleID(),  // Giữ nguyên roleID
                null,  // Không thay đổi avatar
                1 // Giữ nguyên status hoặc thêm một trường trong form để thay đổi nếu cần
            );

            boolean success = userDAO.editUser(userId, updatedUser);
            response.sendRedirect("UserControllerServlet?action=viewDetail&id=" + userId + "&message=" + 
                (success ? "User+updated+successfully" : "Failed+to+update+user"));
        }
    } catch (Exception e) {
        System.out.println("Exception in UserControllerServlet doPost: " + e.getMessage());
        e.printStackTrace();
        response.sendRedirect("error.jsp?message=Error+processing+request");
    }
}


    @Override
    public String getServletInfo() {
        return "Servlet quản lý người dùng";
    }
}