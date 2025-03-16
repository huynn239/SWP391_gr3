/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author BAO CHAU
 */
public class Orderinfo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet Orderinfo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Orderinfo at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        OrderDAO o = new OrderDAO();
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");
        int userID = user.getId();
        if (action == null) {
            String name = request.getParameter("inputname");
            String phone = request.getParameter("inputphone");
            String address = request.getParameter("inputaddress");
            String email = request.getParameter("inputemail");
            String province = request.getParameter("inputprovince");
            String district = request.getParameter("inputdistrict");
            String ward = request.getParameter("inputward");
            o.addAddress(name, phone, email, province + "-" + district + "-" + ward + "-" + address, userID);
            response.sendRedirect("cartcontact.jsp"); // Chuyển hướng sau khi thêm thành công

        } else if ("delete".equals(action)) { // Nếu có action=delete thì xóa địa chỉ
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int addressID = Integer.parseInt(idStr);
                boolean success = o.deleteAddress(addressID); // Xóa địa chỉ theo userID
                if (success) {
                    response.sendRedirect("cartcontact.jsp?message=Xóa thành công");
                } else {
                    response.sendRedirect("cartcontact.jsp?error=Xóa thất bại");
                }
            }
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
        String checkbox = request.getParameter("saveAddress");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String address = request.getParameter("address");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");
        OrderDAO o = new OrderDAO();
        int userID = user.getId();
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int orderId = o.getorderID(user.getId());
        if (checkbox != null) {
            o.addAddress(fullname, phone, email, province + "-" + district + "-"
                    + ward + "-" + address, userID);
        }
        o.updateOrderInfo(fullname, phone, email, province + "-" + district + "-"
                + ward + "-" + address, userID);

        request.getRequestDispatcher("payment.jsp").forward(request, response);
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
