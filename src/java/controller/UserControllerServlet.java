/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.UserDAO;
import model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author thang
 */
@WebServlet(name = "UserControllerServlet", urlPatterns = {"/UserControllerServlet"})
public class UserControllerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserControllerServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserControllerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    UserDAO userDAO = new UserDAO();
    String action = request.getParameter("action");

    if ("delete".equals(action)) {
        int userId = Integer.parseInt(request.getParameter("id")); 
        boolean success = userDAO.deleteUserByID(userId);

        if (success) {
            request.setAttribute("message", "Xóa người dùng thành công!");
        } else {
            request.setAttribute("message", "Xóa người dùng thất bại!");
        }

        response.sendRedirect("UserControllerServlet");
    } 
    else if ("addPage".equals(action)) {
        // Chuyển hướng đến AddUser.jsp
        request.getRequestDispatcher("AddUser.jsp").forward(request, response);
    } 
    else if ("editPage".equals(action)) {
        // Lấy ID từ request để chỉnh sửa
        int id = Integer.parseInt(request.getParameter("id"));
        Account user = userDAO.getUserById(id);

        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("EditUser.jsp").forward(request, response);
        } else {
            response.sendRedirect("UserControllerServlet"); // Quay lại danh sách nếu không tìm thấy user
        }
    } 
    else {
        // Hiển thị danh sách người dùng
        List<Account> listU = userDAO.getUserList();
        request.setAttribute("listU", listU);
        request.getRequestDispatcher("UserList.jsp").forward(request, response);
    }
}

    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
         UserDAO userDAO = new UserDAO();
    String action = request.getParameter("action");

    if ("add".equals(action)) {
        // Lấy dữ liệu từ form
        String uName = request.getParameter("uName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("uAddress");
        int roleID = Integer.parseInt(request.getParameter("roleID"));

        // Tạo đối tượng Account
         Account newUser = new Account(uName, username, password, gender, email, mobile, address, roleID);
        // Gọi DAO để thêm user
        userDAO.addUser(newUser);
        response.sendRedirect("UserControllerServlet"); // Load lại danh sách
    } else if ("edit".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        String uName = request.getParameter("uName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("uAddress");
        int roleID = Integer.parseInt(request.getParameter("roleID"));

        // Tạo đối tượng Account
        Account updatedUser = new Account(id, uName, username, password, gender, email, mobile, address, roleID);

        
        boolean success = userDAO.editUser(id, updatedUser);

        if (success) {
            request.setAttribute("message", "Cập nhật người dùng thành công!");
        } else {
            request.setAttribute("message", "Cập nhật người dùng thất bại!");
        }

        response.sendRedirect("UserControllerServlet");
    } else {
        processRequest(request, response);
    }
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
