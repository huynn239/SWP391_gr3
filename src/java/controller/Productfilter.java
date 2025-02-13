/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import model.Product;

/**
 *
 * @author BAO CHAU
 */
public class Productfilter extends HttpServlet {

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
            out.println("<title>Servlet Productfilter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Productfilter at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryParam = request.getParameter("category");
        String[] materialParams = request.getParameterValues("material");
        String[] brandParams = request.getParameterValues("brand");

        List<Product> filteredProducts = new ArrayList<>();
        ProductDAO pro = new ProductDAO();
        int cat = Integer.parseInt(categoryParam);
        if (categoryParam != null && !categoryParam.isEmpty()) {
            filteredProducts = pro.getAllProductCat(cat);
        } else {
            filteredProducts = pro.getAllProducts();
        }
        if (materialParams != null) {
            filteredProducts.removeIf(p -> !containsMaterial(p, materialParams));
        }
        if (brandParams != null) {
            filteredProducts.removeIf(p -> !containsBrand(p, brandParams));
        }
        int productsPerPage = 6;
        int totalProducts = filteredProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            currentPage = Integer.parseInt(pageParam);
        }

        int startIndex = (currentPage - 1) * productsPerPage;
        int endIndex = Math.min(startIndex + productsPerPage, totalProducts);
        List<Product> paginatedProducts = filteredProducts.subList(startIndex, endIndex);

        request.setAttribute("filteredProducts", paginatedProducts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("category", categoryParam);
        request.setAttribute("selectedMaterials", materialParams);
        request.setAttribute("selectedBrands", brandParams);

        RequestDispatcher dispatcher = request.getRequestDispatcher("productlist.jsp");
        dispatcher.forward(request, response);
    }

    private boolean containsMaterial(Product p, String[] materialParams) {
        for (String m : materialParams) {
            if (p.getMaterialId() == Integer.parseInt(m)) {
                return true;
            }
        }
        return false;
    }

    private boolean containsBrand(Product p, String[] brandParams) {
        for (String b : brandParams) {
            if (p.getBrandId().equals(b)) {
                return true;
            }
        }
        return false;
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
