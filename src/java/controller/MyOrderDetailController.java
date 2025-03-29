/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.SubOrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.SubOrder;
import model.Cart;
import java.util.List;

/**
 *
 * @author thang
 */
@WebServlet(name = "MyOrderDetailController", urlPatterns = {"/MyOrderDetailController"})
public class MyOrderDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String subOrderIdParam = request.getParameter("subOrderId");

        if (subOrderIdParam == null || subOrderIdParam.trim().isEmpty()) {
            response.sendRedirect("MyOrderServlet");
            return;
        }

        int subOrderId;
        try {
            subOrderId = Integer.parseInt(subOrderIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("MyOrderServlet");
            return;
        }

        SubOrderDAO subOrderDAO = new SubOrderDAO();
        SubOrder subOrder = subOrderDAO.getSubOrderBysubOrderId(subOrderId);
        List<Cart> orderDetails = subOrderDAO.getOrderdetailbySuborder(subOrderId);

        if (subOrder == null) {
            response.sendRedirect("MyOrderServlet");
            return;
        }

        request.setAttribute("subOrder", subOrder);
        request.setAttribute("orderDetails", orderDetails);

        RequestDispatcher dispatcher = request.getRequestDispatcher("MyOrderDetail.jsp");
        dispatcher.forward(request, response);
    }
}
