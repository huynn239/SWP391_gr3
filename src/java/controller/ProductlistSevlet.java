/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dto.BrandDAO;
import dto.CategoryDAO;
import dto.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import model.Brand;
import model.Category;
import model.Product;

/**
 *
 * @author BAO CHAU
 */
public class ProductlistSevlet extends HttpServlet {
   
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
            out.println("<title>Servlet ProductlistSevlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductlistSevlet at " + request.getContextPath () + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();

        List<Brand> brandList = brandDAO.getAllBrands();
        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Product> allProducts = productDAO.getAllProductmkt();

        // Lấy các tham số từ request
        String keyword = request.getParameter("keyword");
        String brandId = request.getParameter("brand");
        String status = request.getParameter("status");
        String typeId = request.getParameter("type");
        String sortBy = request.getParameter("sortBy");

        String filterParams = "keyword=" + (keyword != null ? keyword : "")
                + "&brand=" + (brandId != null ? brandId : "")
                + "&status=" + (status != null ? status : "")
                + "&type=" + (typeId != null ? typeId : "")
                + "&sortBy=" + (sortBy != null ? sortBy : "");
        HttpSession session = request.getSession();
        String previousFilters = (String) session.getAttribute("previousFilters");

        boolean isFiltering = previousFilters != null && !previousFilters.equals(filterParams);
        session.setAttribute("previousFilters", filterParams); // Cập nhật bộ lọc mới vào session
        // Lọc sản phẩm
        List<Product> filteredProducts = new ArrayList<>(allProducts);

        if (keyword != null && !keyword.trim().isEmpty()) {
            filteredProducts.removeIf(p -> !p.getName().toLowerCase().contains(keyword.toLowerCase()));
        }

        if (brandId != null && !brandId.isEmpty()) {
            filteredProducts.removeIf(p -> !p.getBrandId().equals(brandId));
        }

        if (status != null && !status.isEmpty()) {
            filteredProducts.removeIf(p -> !String.valueOf(p.isStatus()).equals(status));
        }

        if (typeId != null && !typeId.isEmpty()) {
            filteredProducts.removeIf(p -> !String.valueOf(p.getTypeId()).equals(typeId));
        }

        // Sắp xếp danh sách
        if (sortBy != null) {
            switch (sortBy) {
                case "price_asc":
                    filteredProducts.sort(Comparator.comparingDouble(Product::getPrice));
                    break;
                case "price_desc":
                    filteredProducts.sort(Comparator.comparingDouble(Product::getPrice).reversed());
                    break;
                case "created_at":
                    filteredProducts.sort(Comparator.comparingInt(Product::getId).reversed());
                    break;
            }
        }

        int page = 1;
        int pageSize = 8;
        String pageParam = request.getParameter("page");

        if (!isFiltering) {
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
        }

        int totalProducts = filteredProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalProducts);

        if (start >= totalProducts) {
            start = Math.max(0, totalProducts - pageSize);
        }
        List<Product> paginatedList = filteredProducts.subList(start, end);

        for (Product product : paginatedList) {
            product.setBrandName(brandDAO.getBrandById(product.getBrandId()).getName());
            product.setTypeName(categoryDAO.getCategoryById(product.getTypeId()).getName());
        }

        // Gửi dữ liệu sang JSP
        request.setAttribute("brandList", brandList);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("productlist", paginatedList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Lưu lại các giá trị lọc vào request
        request.setAttribute("selectedKeyword", keyword);
        request.setAttribute("selectedBrand", brandId);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("selectedType", typeId);
        request.setAttribute("selectedSortBy", sortBy);

        request.getRequestDispatcher("Productlistmkt.jsp").forward(request, response);
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
