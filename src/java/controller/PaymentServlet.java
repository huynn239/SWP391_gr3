/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;

/**
 *
 * @author NBL
 */
@WebServlet(name="PaymentServlet", urlPatterns={"/payment"})
public class PaymentServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet PaymentServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy session từ yêu cầu
        HttpSession session = request.getSession();
        
        // Lấy danh sách sản phẩm từ session
        List<Cart> selectedItems = (List<Cart>) session.getAttribute("selectedItems");

        // Kiểm tra nếu không có dữ liệu đơn hàng
        if (selectedItems == null || selectedItems.isEmpty()) {
            request.setAttribute("error", "Không tìm thấy thông tin đơn hàng.");
        } else {
            // Lấy các thông tin khác từ session và gửi qua request
            request.setAttribute("selectedItems", selectedItems);
            request.setAttribute("fullname", session.getAttribute("fullname"));
            request.setAttribute("phone", session.getAttribute("phone"));
            request.setAttribute("email", session.getAttribute("email"));
            request.setAttribute("province", session.getAttribute("province"));
            request.setAttribute("district", session.getAttribute("district"));
            request.setAttribute("ward", session.getAttribute("ward"));
            request.setAttribute("address", session.getAttribute("address"));
            request.setAttribute("orderId", session.getAttribute("orderId"));
        }

        // Chuyển tiếp yêu cầu tới payment.jsp
        request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }
    

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
