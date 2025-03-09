/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import utils.EncryptPassword;

/**
 *
 * @author NBL
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

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
            out.println("<title>Servlet RegisterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
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
                request.getRequestDispatcher("register.jsp").forward(request, response);
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
        String user = request.getParameter("user").trim();
        String pass = request.getParameter("pass").trim();
        String email = request.getParameter("email").trim();
        String uName = request.getParameter("fullname").trim();
        String mobile = request.getParameter("mobile").trim();
        String address = request.getParameter("address").trim();

        SendEmail sm = new SendEmail();
        String code = sm.getRandom();

        String re_pass = request.getParameter("repass");
        if (!pass.equals(re_pass)) {
            request.setAttribute("mess", "Passwords don't mactch !");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            UserDAO userdao = new UserDAO();
            Account a = userdao.checkAccountExist(user, email);
            if (a == null) {
                pass = EncryptPassword.toSHA1(pass);
//                userdao.register(user, email, pass, uName, mobile, address);
//                Account newAccount = userdao.checkAccountExist(user, email);
                HttpSession session = request.getSession();
                Account tempAccount = new Account(0, uName, user, pass, null, email, mobile, address, 2);
                session.setAttribute("tempAccount", tempAccount);
                session.setAttribute("authCode", code); // Lưu mã xác thực vào session
                session.setAttribute("authEmail", email); // Lưu email để xác minh
                session.setAttribute("authTime",
                        System.currentTimeMillis());

                boolean emailSent = sm.sendEmail(tempAccount, code);
                if (emailSent) {
                    response.sendRedirect(request.getContextPath() + "/verifycode");
                } else {
                    request.setAttribute("mess", "Failed to send verification email. Please try again!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
                //  response.sendRedirect("verifycode.jsp");
                // response.sendRedirect("home.jsp");

            } else {

                if (a.getUsername().equals(user)) {
                    request.setAttribute("mess", "Username already exists!");
                }
                if (a.getEmail().equals(email)) {
                    request.setAttribute("mess", "Email already exists!");
                }
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
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
