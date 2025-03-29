package controller;

import dto.SliderDAO;
import model.Slider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SliderController", urlPatterns = {"/sliderList"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SliderController extends HttpServlet {

    private SliderDAO sliderDAO;

    @Override
    public void init() throws ServletException {
        sliderDAO = new SliderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Kiểm tra thông báo thành công từ redirect
        String success = request.getParameter("success");
        if (success != null) {
            if (success.equals("add")) {
                request.setAttribute("successMessage", "Thêm slider thành công!");
            } else if (success.equals("edit")) {
                request.setAttribute("successMessage", "Cập nhật slider thành công!");
            } else if (success.equals("delete")) {
                request.setAttribute("successMessage", "Xóa slider thành công!");
            }
        }

        if (action == null || "sliderList".equals(action)) {
            int page = 1;
            int limit = 4;
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            String keyword = request.getParameter("keyword");
            String statusFilter = request.getParameter("statusFilter");

            if (sortBy == null) {
                sortBy = "created_at";
            }
            if (sortOrder == null) {
                sortOrder = "DESC";
            }
            if (!sortBy.equals("status") && !sortBy.equals("created_at")) {
                sortBy = "created_at";
            }

            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            if (page < 1) page = 1;

            List<Slider> sliders;
            int totalSliders;

            if (keyword != null && !keyword.trim().isEmpty()) {
                if (statusFilter != null && !statusFilter.isEmpty()) {
                    boolean status = Boolean.parseBoolean(statusFilter);
                    sliders = sliderDAO.searchSlidersByKeywordAndStatus(keyword, status, page, limit, sortBy, sortOrder);
                    totalSliders = sliderDAO.getTotalSlidersByKeywordAndStatus(keyword, status);
                } else {
                    sliders = sliderDAO.searchSliders(keyword, page, limit, sortBy, sortOrder);
                    totalSliders = sliderDAO.getTotalSlidersByKeyword(keyword);
                }
            } else if (statusFilter != null && !statusFilter.isEmpty()) {
                boolean status = Boolean.parseBoolean(statusFilter);
                sliders = sliderDAO.getSlidersByStatus(status, page, limit, sortBy, sortOrder);
                totalSliders = sliderDAO.getTotalSlidersByStatus(status);
            } else {
                sliders = sliderDAO.getSlidersSorted(page, limit, sortBy, sortOrder);
                totalSliders = sliderDAO.getTotalSliders();
            }

            int totalPages = (int) Math.ceil((double) totalSliders / limit);

            request.setAttribute("sliders", sliders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("keyword", keyword);
            request.setAttribute("statusFilter", statusFilter);

            request.getRequestDispatcher("sliderList.jsp").forward(request, response);
        } else if ("addSlider".equals(action)) {
            request.getRequestDispatcher("addSlider.jsp").forward(request, response);
        } else if ("sliderDetail".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Slider slider = sliderDAO.getSliderById(id);

            if (slider != null) {
                request.setAttribute("slider", slider);
                request.getRequestDispatcher("sliderDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("sliderList");
            }
        } else if ("deleteSlider".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean isDeleted = sliderDAO.deleteSlider(id);

            if (isDeleted) {
                response.sendRedirect("sliderList?success=delete");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi xóa Slider.");
                request.getRequestDispatcher("sliderList.jsp").forward(request, response);
            }
        } else if ("editSlider".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Slider slider = sliderDAO.getSliderById(id);

            if (slider != null) {
                request.setAttribute("slider", slider);
                request.getRequestDispatcher("updateSlider.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy slider để cập nhật.");
                request.getRequestDispatcher("sliderList.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String title = request.getParameter("title");
            String link = request.getParameter("link");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            Part filePart = request.getPart("blogImage");
            String fileName = null;
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            if (filePart != null && filePart.getSize() > 0) {
                fileName = extractFileName(filePart);
                filePart.write(uploadPath + File.separator + fileName);
                fileName = "uploads/" + fileName;
            }

            if (title == null || title.trim().isEmpty() || link == null || link.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ các trường bắt buộc.");
                request.getRequestDispatcher("addSlider.jsp").forward(request, response);
                return;
            }

            try {
                Slider newSlider = new Slider();
                newSlider.setTitle(title);
                newSlider.setImageUrl(fileName != null ? fileName : "default.jpg");
                newSlider.setLink(link);
                newSlider.setStatus(status);

                boolean isAdded = sliderDAO.addSlider(newSlider);

                if (isAdded) {
                    response.sendRedirect("sliderList?success=add");
                } else {
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm Slider.");
                    request.getRequestDispatcher("addSlider.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
                request.getRequestDispatcher("addSlider.jsp").forward(request, response);
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String link = request.getParameter("link");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            Part filePart = request.getPart("blogImage");
            String fileName = null;
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            Slider currentSlider = sliderDAO.getSliderById(id);
            String imageUrl = currentSlider != null ? currentSlider.getImageUrl() : "default.jpg";

            if (filePart != null && filePart.getSize() > 0) {
                fileName = extractFileName(filePart);
                filePart.write(uploadPath + File.separator + fileName);
                imageUrl = "uploads/" + fileName;
            }

            if (title == null || title.trim().isEmpty() || link == null || link.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ các trường bắt buộc.");
                request.setAttribute("slider", currentSlider);
                request.getRequestDispatcher("updateSlider.jsp").forward(request, response);
                return;
            }

            try {
                Slider updatedSlider = new Slider();
                updatedSlider.setId(id);
                updatedSlider.setTitle(title);
                updatedSlider.setImageUrl(imageUrl);
                updatedSlider.setLink(link);
                updatedSlider.setStatus(status);

                boolean isUpdated = sliderDAO.updateSlider(updatedSlider);

                if (isUpdated) {
                    response.sendRedirect("sliderList?success=edit");
                } else {
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật Slider.");
                    request.setAttribute("slider", updatedSlider);
                    request.getRequestDispatcher("updateSlider.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
                request.setAttribute("slider", currentSlider);
                request.getRequestDispatcher("updateSlider.jsp").forward(request, response);
            }
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return System.currentTimeMillis() + "_" + s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}