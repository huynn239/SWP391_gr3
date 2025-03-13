/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.OrderDAO;
import dto.OrderdetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;
import model.Account;
import model.Cart;

/**
 *
 * @author BAO CHAU
 */
public class CheckoutSevlet extends HttpServlet {

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
            out.println("<title>Servlet CheckoutSevlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutSevlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        List<Cart> cartList = (List<Cart>) session.getAttribute("cartList");
        Account user = (Account) session.getAttribute("u");
        double total = Double.parseDouble(request.getParameter("total"));
        OrderDAO o = new OrderDAO();
        OrderdetailDAO od = new OrderdetailDAO();
        if (cartList == null || cartList.isEmpty()) {
            response.sendRedirect("cartdetail.jsp");
            return;
        }
        List<Cart> selectedItems = cartList.stream()
                .filter(c -> "checked".equals(c.getCheckboxStatus()))
                .collect(Collectors.toList());
        if (selectedItems.isEmpty()) {
            session.setAttribute("cartMessage", "Vui lòng chọn sản phẩm để đặt hàng!");
            response.sendRedirect("cartdetail.jsp");
            return;
        }
        if (o.checkCreateNewSubOrder(user.getId())) {
            o.insertsubOrder(user.getId(), total);
            od.updatesuborder(user.getId(), selectedItems);
            od.updateToTalamountSuborder(user.getId(), selectedItems);
        } else {
            od.updatesuborder(user.getId(), selectedItems);
            od.updateToTalamountSuborder(user.getId(), selectedItems);
        }
        session.setAttribute("selectedItems", selectedItems);
        response.sendRedirect("cartcontact.jsp");
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
