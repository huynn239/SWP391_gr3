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
import model.Account;

/**
 *
 * @author BAO CHAU
 */
public class Orderpdetail extends HttpServlet {

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
            out.println("<title>Servlet Orderpdetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Orderpdetail at " + request.getContextPath() + "</h1>");
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
    try {
        String productId = request.getParameter("productId");
        String size = request.getParameter("size");
        String quantityStr = request.getParameter("quantity");
        String pricestr = request.getParameter("price");

        int quantity = Integer.parseInt(quantityStr);
        int productID = Integer.parseInt(productId);
        double price = Double.parseDouble(pricestr);

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");

        OrderDAO o = new OrderDAO();
        OrderdetailDAO od = new OrderdetailDAO();
        int orderID = o.getorderID(user.getId());
        if (!o.checkSize(quantity, productID, size)) {
            return;
        }
        if (o.checkCreateNewOrder(user.getId())) {
            o.insertOrder(user.getId());
            orderID = o.getorderID(user.getId());
        }

        od.insertOrderdetail(orderID, productID, quantity, size);
        o.updateTotalAmount(orderID);

        // Chuyển hướng về trang trước đó
        response.sendRedirect(request.getHeader("Referer"));

    } catch (Exception e) {
        e.printStackTrace();
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
