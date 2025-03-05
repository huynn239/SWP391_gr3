package controller;

import dto.SliderDAO;
import model.Slider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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

        if (action == null || "sliderList".equals(action)) {
            // Hiển thị danh sách slider
            int page = 1;
            int limit = 4;
            String sortBy = request.getParameter("sortBy");
            String keyword = request.getParameter("keyword");

            if (sortBy == null || (!sortBy.equals("status") && !sortBy.equals("created_at"))) {
                sortBy = "created_at"; // Mặc định sắp xếp theo mới nhất
            }

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            List<Slider> sliders;
            int totalSliders;
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm theo từ khóa
                sliders = sliderDAO.searchSliders(keyword, page, limit, sortBy);
                totalSliders = sliderDAO.getTotalSlidersByKeyword(keyword);
            } else {
                // Lấy danh sách bình thường
                sliders = sliderDAO.getSlidersSorted(page, limit, sortBy);
                totalSliders = sliderDAO.getTotalSliders();
            }

            int totalPages = (int) Math.ceil((double) totalSliders / limit);

            request.setAttribute("sliders", sliders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("keyword", keyword); // Lưu từ khóa để hiển thị lại

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
                response.sendRedirect("sliderList");
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
            String link = request.getParameter("link");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            String imageUrl = request.getParameter("imageUrl");

            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "default.jpg";
            }

            Slider newSlider = new Slider();
            newSlider.setImageUrl(imageUrl);
            newSlider.setLink(link);
            newSlider.setStatus(status);

            boolean isAdded = sliderDAO.addSlider(newSlider);

            if (isAdded) {
                response.sendRedirect("sliderList");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm Slider.");
                request.getRequestDispatcher("addSlider.jsp").forward(request, response);
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String link = request.getParameter("link");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            String imageUrl = request.getParameter("imageUrl");

            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "default.jpg";
            }

            Slider updatedSlider = new Slider();
            updatedSlider.setId(id);
            updatedSlider.setImageUrl(imageUrl);
            updatedSlider.setLink(link);
            updatedSlider.setStatus(status);

            boolean isUpdated = sliderDAO.updateSlider(updatedSlider);

            if (isUpdated) {
                response.sendRedirect("sliderList");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật Slider.");
                request.setAttribute("slider", updatedSlider);
                request.getRequestDispatcher("updateSlider.jsp").forward(request, response);
            }
        }
    }
}