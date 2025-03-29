/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dto.PendingUpdateDAO;
import dto.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.Pending;
import model.Product;

/**
 *
 * @author BAO CHAU
 */
public class ApproveRequest extends HttpServlet {

    private Gson gson = new Gson();

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
            out.println("<title>Servlet ApproveRequest</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApproveRequest at " + request.getContextPath() + "</h1>");
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
        PendingUpdateDAO dao = new PendingUpdateDAO();

        // Lấy giá trị tìm kiếm và bộ lọc từ request
        String keyword = request.getParameter("keyword");
        String statusFilter = request.getParameter("status");
        System.out.println("" + statusFilter);
        // Lấy danh sách tất cả đơn hàng
        List<Pending> pendingList = dao.getAllPendingUpdates();

        // Lọc theo employeeID nếu có nhập từ khóa tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            pendingList = pendingList.stream()
                    .filter(p ->String.valueOf(p.getUpdatedBy()).toLowerCase().equals(keyword.toLowerCase()))
                    .collect(Collectors.toList());
        }

        // Lọc theo trạng thái nếu có chọn trạng thái cụ thể
        if (statusFilter != null && !statusFilter.isEmpty()) {
            pendingList = pendingList.stream()
                    .filter(p -> p.getStatus().equalsIgnoreCase(statusFilter))
                    .collect(Collectors.toList());
        }

        // Phân trang
        int pageSize = 5;
        int totalItems = pendingList.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
                if (currentPage > totalPages) {
                    currentPage = totalPages;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalItems);
        List<Pending> paginatedList = pendingList.subList(startIndex, endIndex);

        // Gửi dữ liệu đến JSP
        request.setAttribute("pendinglist", paginatedList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("selectedKeyword", keyword);
        request.setAttribute("selectedStatus", statusFilter);

        request.getRequestDispatcher("Approverequest.jsp").forward(request, response);
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
        PendingUpdateDAO dao = new PendingUpdateDAO();
        ProductDAO productDAO = new ProductDAO();

        List<Pending> pendingList = dao.getAllPendingUpdates();

        for (Pending pending : pendingList) {
            String paramName = "status_" + pending.getId();
            String newStatus = request.getParameter(paramName);

            if (newStatus != null && !newStatus.equals(pending.getStatus())) {
                if (pending.getStatus().equals("approved") && newStatus.equals("pending")) {
                    continue; // Không cho phép quay lại pending
                }
                if (pending.getStatus().equals("rejected") && newStatus.equals("pending")) {
                    continue; // Không cho phép quay lại pending
                }

                dao.updateStatus(pending.getId(), newStatus);
                if ("approved".equals(newStatus)) {
                    String json = pending.getChangeo();
                    int firstSpaceIndex = json.indexOf(" ");
                    if (firstSpaceIndex == -1) {
                        return;
                    }
                    String action = json.substring(0, firstSpaceIndex);

                    if (action.equals("update")) {
                        String jsonData = json.substring(firstSpaceIndex + 1); // Phần JSON còn lại
                        java.lang.reflect.Type type = new TypeToken<HashMap<String, Object>>() {
                        }.getType();
                        HashMap<String, Object> data = gson.fromJson(jsonData, type);
                        int pid = pending.getProductId();
                        int cid = ((Double) data.get("color")).intValue();
                        String name = data.get("name").toString();
                        int materialID = ((Double) data.get("materialID")).intValue();
                        double price = (Double) data.get("price");
                        String detail = data.get("detail").toString();
                        String brandID = data.get("brandId").toString();
                        int catID = ((Double) data.get("categoryId")).intValue();
                        boolean status = (Boolean) data.get("status");
                        productDAO.updateProduct(new Product(pid, name, materialID,
                                price, detail, brandID, catID, status));
                        String url = data.get("url").toString();
                        String urlm = data.get("urlm").toString();
                        productDAO.updateProductImage(url, urlm, pid, cid);
                        List<Map<String, Object>> sizes = (List<Map<String, Object>>) data.get("sizes");
                        for (Map<String, Object> size : sizes) {
                            int sizeId = ((Double) size.get("sizeId")).intValue();
                            int quantity = ((Double) size.get("quantity")).intValue();
                            productDAO.updateProductSize(pid, cid, sizeId, quantity);
                        }
                    } else if (action.equals("addColor")) {
                        String jsonData = json.substring(firstSpaceIndex + 1); // Phần JSON còn lại
                        java.lang.reflect.Type type = new TypeToken<HashMap<String, Object>>() {
                        }.getType();
                        HashMap<String, Object> data = gson.fromJson(jsonData, type);
                        int pid = pending.getProductId();
                        int cid = ((Double) data.get("color")).intValue();
                        String urlm = data.get("urlm").toString();
                        productDAO.addProductColor(pid, cid, urlm);
                        List<Map<String, Object>> sizes = (List<Map<String, Object>>) data.get("sizes");
                        for (Map<String, Object> size : sizes) {
                            int sizeId = ((Double) size.get("sizeId")).intValue();
                            int quantity = ((Double) size.get("quantity")).intValue();
                            productDAO.addProductSize(pid, cid, sizeId, quantity);
                        }

                    } else if (pending.getChanges().equals("Xóa sản phẩm")) {
                        int pid = pending.getProductId();
                        int uid = pending.getUpdatedBy();
                        productDAO.deleteProduct(pid, uid);
                    }
                }
            }
        }
        List<Pending> updatedList = dao.getAllPendingUpdates();
        request.setAttribute("pendinglist", updatedList);
        String currentPage = request.getParameter("page");
        if (currentPage != null) {
            response.sendRedirect("approverequest?page=1" + currentPage);
        } else {
            response.sendRedirect("Approverequest.jsp");
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
