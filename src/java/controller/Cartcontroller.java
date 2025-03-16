/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.OrderDAO;
import dto.OrderdetailDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Cart;
import model.Orderdetail;

/**
 *
 * @author BAO CHAU
 */
public class Cartcontroller extends HttpServlet {

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
            out.println("<title>Servlet Cartcontroller</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Cartcontroller at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");

        if (user != null) {
            OrderdetailDAO od = new OrderdetailDAO();
            List<Cart> list = od.cartDetail(user.getId());
            System.out.println("" + list.size());

            session.setAttribute("cartList", list); // Lưu vào session
            RequestDispatcher dispatcher = request.getRequestDispatcher("cartdetail.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login.jsp"); // Chưa đăng nhập thì về trang login
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
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String message = "";
        OrderdetailDAO od = new OrderdetailDAO();
        OrderDAO o = new OrderDAO();
        String action = request.getParameter("action");
        String size = request.getParameter("Size");
        String color = request.getParameter("color");
        int colorID = Integer.parseInt(color);
        int productId = Integer.parseInt(request.getParameter("productId"));

        if ("delete".equalsIgnoreCase(action)) {
            od.deleteCart(productId, size, user.getId(),color);
            message = "Sản phẩm đã được xóa khỏi giỏ hàng!";
        } else {
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if ("decrease".equals(action) && quantity == 1) {
                message = "Số lượng sản phẩm tối thiểu là 1! Nếu muốn xóa sản phẩm, hãy nhấn nút xóa.";
            } else {
                if ("increase".equals(action)) {
                    quantity++;
                } else if ("decrease".equals(action) && quantity > 1) {
                    quantity--;
                }

                if (o.checkSize(quantity, productId, size,colorID)) {
                    od.updateQuantity(quantity, productId, size, user.getId(),color);
                    message = "Cập nhật giỏ hàng thành công!";
                } else {
                    message = "Số lượng sản phẩm không đủ!";
                }
            }
        }

        session.setAttribute("cartList", od.cartDetail(user.getId()));
        session.setAttribute("cartMessage", message);
        response.sendRedirect("cartdetail.jsp");

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
