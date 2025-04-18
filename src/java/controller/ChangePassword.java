/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Account;
import dto.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.EncryptPassword;

/**
 *
 * @author NBL
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/changepassword"})
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("changepassword.jsp").forward(request, response);
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
        // Lấy userId từ session
        Integer userId = (Integer) request.getSession().getAttribute("id");

        if (userId == null) {
            request.setAttribute("error", "Bạn chưa đăng nhập!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$";
        String password = request.getParameter("pass").trim();
        String newpass = request.getParameter("newpass").trim();
        String re_newpass = request.getParameter("renewpass");
        // Mã hóa mật khẩu cũ
        password = EncryptPassword.toSHA1(password);

        UserDAO userdao = new UserDAO();
        Account user = userdao.getUserById(userId);

        if (!newpass.equals(re_newpass)) {
            request.setAttribute("error", "New passwords don't match!");
        } else if (!newpass.matches(passwordPattern)) {
            request.setAttribute("error", "Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, and one number!");
        } else if (user == null || !user.getPassword().equals(password)) {
            request.setAttribute("error", "Old password is incorrect!");
        } else {
            // Mã hóa mật khẩu mới trước khi lưu
            newpass = EncryptPassword.toSHA1(newpass);
            userdao.updatePassword(user.getEmail(), newpass);
            request.setAttribute("message", "Password changed successfully!");
        }

        request.getRequestDispatcher("changepassword.jsp").forward(request, response);
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
