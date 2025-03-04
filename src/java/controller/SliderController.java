package controller;

import dto.SliderDAO;
import model.Slider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

public class SliderController extends HttpServlet {

    private SliderDAO sliderDAO;  // Đảm bảo không có trùng tên với các trường khác

    @Override
    public void init() throws ServletException {
        sliderDAO = new SliderDAO();  // Khởi tạo đối tượng SliderDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getRequestURI(); // Lấy URI từ request

        if (action.endsWith("sliderList")) {
            // Hiển thị danh sách slider
            int page = 1;
            int limit = 4; // Số slider trên mỗi trang

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            List<Slider> sliders = sliderDAO.getSliders(page, limit);
            int totalSliders = sliderDAO.getTotalSliders();
            int totalPages = (int) Math.ceil((double) totalSliders / limit);

            request.setAttribute("sliders", sliders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("sliderList.jsp").forward(request, response);  // Chuyển đến trang sliderList.jsp
        } else if (action.endsWith("addSlider")) {
            request.getRequestDispatcher("addSlider.jsp").forward(request, response);  // Hiển thị form thêm slider
        } else if (action.endsWith("sliderDetail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Slider slider = sliderDAO.getSliderById(id);

            if (slider != null) {
                request.setAttribute("slider", slider);
                request.getRequestDispatcher("sliderDetail.jsp").forward(request, response);  // Chuyển đến trang sliderDetail.jsp
            } else {
                response.sendRedirect("sliderList"); // Quay lại danh sách nếu không tìm thấy slider
            }
        } else if (action.endsWith("deleteSlider")) {
            // Xử lý xóa slider
            int id = Integer.parseInt(request.getParameter("id"));
            boolean isDeleted = sliderDAO.deleteSlider(id);

            if (isDeleted) {
                response.sendRedirect("sliderList");  
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi xóa Slider.");
                request.getRequestDispatcher("sliderList.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String link = request.getParameter("link");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            String imageUrl = request.getParameter("imageUrl");  // Lấy đường dẫn hình ảnh

            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "default.jpg";  // Nếu không có đường dẫn, sử dụng ảnh mặc định
            }

            Slider newSlider = new Slider();
            newSlider.setImageUrl(imageUrl);  // Lưu đường dẫn ảnh
            newSlider.setLink(link);
            newSlider.setStatus(status);

            boolean isAdded = sliderDAO.addSlider(newSlider);

            if (isAdded) {
                response.sendRedirect("sliderList");  // Chuyển hướng đến trang sliderList sau khi tạo slider thành công
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm Slider.");
                request.getRequestDispatcher("addSlider.jsp").forward(request, response);  // Forward đến trang addSlider.jsp
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String link = request.getParameter("link");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            String imageUrl = request.getParameter("imageUrl");  // Lấy đường dẫn hình ảnh

            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "default.jpg";  // Nếu không có đường dẫn, sử dụng ảnh mặc định
            }

            Slider updatedSlider = new Slider();
            updatedSlider.setId(id);
            updatedSlider.setImageUrl(imageUrl);
            updatedSlider.setLink(link);
            updatedSlider.setStatus(status);

            boolean isUpdated = sliderDAO.updateSlider(updatedSlider);

            if (isUpdated) {
                response.sendRedirect("sliderList");  // Chuyển hướng đến trang sliderList sau khi cập nhật slider thành công
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật Slider.");
                request.getRequestDispatcher("addSlider.jsp").forward(request, response);  // Forward đến trang addSlider.jsp
            }
        }
    }
}
