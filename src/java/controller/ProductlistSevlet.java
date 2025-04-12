/*
  * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
  * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.BrandDAO;
import dto.CategoryDAO;
import dto.ProductDAO;
import dto.ProductImageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Brand;
import model.Category;
import model.Product;

/**
 *
 * @author BAO CHAU
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ProductlistSevlet extends HttpServlet {

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
            out.println("<title>Servlet ProductlistSevlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductlistSevlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();
        ProductImageDAO pDAO = new ProductImageDAO();

        List<Brand> brandList = brandDAO.getAllBrands();
        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Product> allProducts = productDAO.getAllProductmkt();

        // Lấy các tham số từ request
        String keyword = request.getParameter("keyword");
        String brandId = request.getParameter("brand");
        String status = request.getParameter("status");
        String typeId = request.getParameter("type");
        String sortBy = request.getParameter("sortBy");
        String stockStatus = request.getParameter("stockStatus");
        System.out.println("" + stockStatus);
        String filterParams = "keyword=" + (keyword != null ? keyword : "")
                + "&brand=" + (brandId != null ? brandId : "")
                + "&status=" + (status != null ? status : "")
                + "&type=" + (typeId != null ? typeId : "")
                + "&sortBy=" + (sortBy != null ? sortBy : "")
                + "&stockStatus=" + (stockStatus != null ? stockStatus : "");

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

        if (stockStatus != null && !stockStatus.isEmpty()) {
            switch (stockStatus) {
                case "out":
                    filteredProducts.removeIf(p -> !pDAO.hasAnySizeWithQuantity(p.getId(), 0));
                    break;
                case "low":
                    filteredProducts.removeIf(p -> !pDAO.hasAnySizeWithQuantityLessThan(p.getId(), 10));
                    break;
            }
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

        // Phân trang
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

        // Set brandName và typeName cho mỗi sản phẩm
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

        // Lưu lại các giá trị lọc vào request để giữ state
        request.setAttribute("selectedKeyword", keyword);
        request.setAttribute("selectedBrand", brandId);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("selectedType", typeId);
        request.setAttribute("selectedSortBy", sortBy);
        request.setAttribute("stockStatus", stockStatus); // ✅ mới thêm

        request.getRequestDispatcher("Productlistmanage.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("u");

        try {
            ProductDAO productDAO = new ProductDAO();
            if ("update".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("product_id"));
                int selectedColorId = Integer.parseInt(request.getParameter("selectedColorId"));
                String name = request.getParameter("name");
                int categoryId = Integer.parseInt(request.getParameter("category"));
                String brandId = request.getParameter("brand");
                double price = Double.parseDouble(request.getParameter("price"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                int materialID = Integer.parseInt(request.getParameter("material"));
                String detail = request.getParameter("detail");
                Part imgPart = request.getPart("img_" + selectedColorId);
                Part imgmPart = request.getPart("imgm");
                String oldImg = request.getParameter("oldImg_" + selectedColorId);
                String oldImgm = request.getParameter("oldImgm");
                System.out.println("" + oldImg);
                String imgFileName = (imgPart != null && imgPart.getSize() > 0)
                        ? Paths.get(imgPart.getSubmittedFileName()).getFileName().toString()
                        : null;

                String imgmFileName = (imgmPart != null && imgmPart.getSize() > 0)
                        ? Paths.get(imgmPart.getSubmittedFileName()).getFileName().toString()
                        : null;

                String uploadPath = getServletContext().getRealPath("/web/images/product");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String url, urlm;

                if (imgFileName != null && !imgFileName.isEmpty()) {
                    imgPart.write(uploadPath + File.separator + imgFileName);
                    url = "web/images/product/" + imgFileName;
                } else {
                    url = oldImg;
                }

                if (imgmFileName != null && !imgmFileName.isEmpty()) {
                    imgmPart.write(uploadPath + File.separator + imgmFileName);
                    urlm = "web/images/product/" + imgmFileName;
                } else {
                    urlm = oldImgm;
                }
                System.out.println("" + url);

                Product product = new Product(productId, name, materialID, price, detail, brandId, categoryId, status);
                if (user.getRoleID() == 1) {
                    productDAO.updateProduct(product);
                    productDAO.updateProductImage(url, urlm, productId, selectedColorId);
                }

                Map<String, Object> changes = new HashMap<>();
                changes.put("name", name);
                changes.put("categoryId", categoryId);
                changes.put("brandId", brandId);
                changes.put("price", price);
                changes.put("status", status);
                changes.put("materialID", materialID);
                changes.put("detail", detail);
                changes.put("url", url);
                changes.put("urlm", urlm);
                changes.put("color", selectedColorId);
                List<Map<String, Integer>> sizesList = new ArrayList<>();
                String[] sizeIds = request.getParameterValues("sizeIds");
                String[] quantities = request.getParameterValues("quantities");

                if (sizeIds != null && quantities != null) {
                    for (int i = 0; i < sizeIds.length; i++) {
                        int sizeId = Integer.parseInt(sizeIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        if (user.getRoleID() == 1) {
                            productDAO.updateProductSize(productId, selectedColorId, sizeId, quantity);
                            session.setAttribute("message", "Cập nhật thành công!");
                        }
                        if (user.getRoleID() == 2) {
                            Map<String, Integer> sizeObj = new HashMap<>();
                            sizeObj.put("sizeId", Integer.parseInt(sizeIds[i]));
                            sizeObj.put("quantity", Integer.parseInt(quantities[i]));
                            sizesList.add(sizeObj);
                        }
                    }
                }
                changes.put("sizes", sizesList);
                if (user.getRoleID() == 2) {
                    productDAO.savePendingUpdate(action, productId, user.getId(), (HashMap<String, Object>) changes);
                    session.setAttribute("message", "Gửi đơn thành công!");
                }
                response.sendRedirect("Productdetailmanage.jsp?id=" + productId);
            } else if ("addcolor".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("product_id"));
                int colorName = Integer.parseInt(request.getParameter("colorName"));
                Part imagePart = request.getPart("imageLink");

                String imageFileName = (imagePart != null && imagePart.getSize() > 0)
                        ? Paths.get(imagePart.getSubmittedFileName()).getFileName().toString()
                        : null;

                String uploadPath = getServletContext().getRealPath("/web/images/product");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String imageLink = null;

                if (imageFileName != null && !imageFileName.isEmpty()) {
                    imagePart.write(uploadPath + File.separator + imageFileName);
                    imageLink = "web/images/product/" + imageFileName;
                }

                if (user.getRoleID() == 1) {
                    productDAO.addProductColor(productId, colorName, imageLink);
                }
                int[] sizeIds = {1, 2, 3, 4}; // Danh sách size có thể chọn
                Map<String, Object> changes = new HashMap<>();
                changes.put("color", colorName);
                changes.put("urlm", imageLink);
                List<Map<String, Integer>> sizesList = new ArrayList<>();
                for (int sizeId : sizeIds) {
                    String quantityStr = request.getParameter("sizeQuantities[" + sizeId + "]");

                    if (quantityStr != null && !quantityStr.isEmpty()) {
                        int quantity = Integer.parseInt(quantityStr);
                        if (quantity > 0) {
                            if (user.getRoleID() == 1) {
                                // Nếu là Admin, cập nhật trực tiếp vào DB
                                productDAO.addProductSize(productId, colorName, sizeId, quantity);
                            } else if (user.getRoleID() == 2) {
                                // Nếu là nhân viên marketing, lưu thay đổi để duyệt sau
                                Map<String, Integer> sizeObj = new HashMap<>();
                                sizeObj.put("sizeId", sizeId);
                                sizeObj.put("quantity", quantity);
                                sizesList.add(sizeObj);
                            }
                        }
                    }
                }
                if (user.getRoleID() == 2) {
                    changes.put("sizes", sizesList);
                    productDAO.savePendingUpdate("addColor", productId, user.getId(), (HashMap<String, Object>) changes);
                    session.setAttribute("message", "Gửi đơn thành công!");
                } else {
                    session.setAttribute("message", "Cập nhật thành công!");
                }
                response.sendRedirect("Productdetailmanage.jsp?id=" + productId);
            } else if (action.equals("deleteProduct")) {
                int productId = Integer.parseInt(request.getParameter("id"));
                int userId = user.getId();
                if (user.getRoleID() == 1) {
                    productDAO.deleteProduct(productId, userId);
                    session.setAttribute("message", "Xoa thành công!");
                } else if (user.getRoleID() == 2) {
                    productDAO.savePendingUpdate("delete", productId, userId, null);
                    session.setAttribute("message", "Gửi đơn thành công!");
                }
                response.sendRedirect("productlistsevlet");
            } else if (action.equals("addProduct")) {
                // Lấy thông tin cơ bản của sản phẩm
                String name = request.getParameter("name");
                int categoryId = Integer.parseInt(request.getParameter("category"));
                String brandId = request.getParameter("brand");
                double price = Double.parseDouble(request.getParameter("price"));
                int materialID = Integer.parseInt(request.getParameter("material"));
                String detail = request.getParameter("detail");

// Xử lý ảnh chính (ảnh minh họa sản phẩm)
                Part imgmPart = request.getPart("img");
                String imgmFileName = (imgmPart != null && imgmPart.getSize() > 0)
                        ? Paths.get(imgmPart.getSubmittedFileName()).getFileName().toString()
                        : null;

                String uploadPath = getServletContext().getRealPath("/web/images/product");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String urlm = "";
                if (imgmFileName != null && !imgmFileName.isEmpty()) {
                    imgmPart.write(uploadPath + File.separator + imgmFileName);
                    urlm = "web/images/product/" + imgmFileName;
                }
                Product product = new Product(name, urlm, materialID, price, detail, brandId, categoryId);
                if (user.getRoleID() == 1) {
                    productDAO.insertProduct(product);
                }
                int pID = productDAO.getLastProductID();
                String[] colorIds = request.getParameterValues("colorIds");
                if (colorIds != null) {
                    for (String colorIdStr : colorIds) {
                        int colorId = Integer.parseInt(colorIdStr);
                        Part colorImgPart = request.getPart("colorImage_" + colorId);
                        String colorImgFileName = (colorImgPart != null && colorImgPart.getSize() > 0)
                                ? Paths.get(colorImgPart.getSubmittedFileName()).getFileName().toString()
                                : null;
                        String colorImgUrl = "";
                        if (colorImgFileName != null && !colorImgFileName.isEmpty()) {
                            colorImgPart.write(uploadPath + File.separator + colorImgFileName);
                            colorImgUrl = "web/images/product/" + colorImgFileName;
                        }
                        if (user.getRoleID() == 1) {
                            productDAO.insertProductImage(colorImgUrl, pID, colorId);
                        }
                        String[] sizeIdArr = request.getParameterValues("sizeIds_" + colorId + "[]");
                        String[] quantityArr = request.getParameterValues("quantities_" + colorId + "[]");

                        if (sizeIdArr != null && quantityArr != null) {
                            for (int i = 0; i < sizeIdArr.length; i++) {
                                int sizeId = Integer.parseInt(sizeIdArr[i]);
                                int quantity = Integer.parseInt(quantityArr[i]);

                                if (user.getRoleID() == 1) {
                                    productDAO.insertProductSize(pID, colorId, sizeId, quantity);
                                }
                            }
                        }
                    }
                }
                session.setAttribute("message", "Thêm sản phẩm thành công!");
                response.sendRedirect("Addproduct.jsp");

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý yêu cầu.");
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
