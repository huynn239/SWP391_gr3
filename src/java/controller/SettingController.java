package controller;

import dto.SettingDAO;
import model.Setting;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SettingController", urlPatterns = {"/SettingController"})
public class SettingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SettingDAO settingDAO = new SettingDAO();
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Setting setting = settingDAO.getSettingById(id);
                if (setting == null) {
                    response.sendRedirect("SettingController?message=Setting not found");
                    return;
                }
                request.setAttribute("setting", setting);
                request.getRequestDispatcher("EditSetting.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect("SettingController?message=Invalid setting ID");
                return;
            }
        }else if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Setting setting = settingDAO.getSettingById(id);
            if (setting != null) {
                request.setAttribute("setting", setting);  // Đảm bảo bạn truyền toàn bộ đối tượng setting
                request.getRequestDispatcher("SettingDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("errorPage.jsp");  // Nếu không tìm thấy setting, redirect đến trang lỗi
            }
        }  else if ("add".equals(action)) {
            request.getRequestDispatcher("AddSetting.jsp").forward(request, response);
            return;
        }

        // Lấy tham số lọc từ request
        String keyword = request.getParameter("keyword");
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        String sortBy = request.getParameter("sortBy");

        // Lấy danh sách settings đã lọc
        List<Setting> settingList = settingDAO.getFilteredSettings(keyword, type, status, sortBy);
        List<String> typeList = settingDAO.getAllTypes();

        // Đặt các thuộc tính để gửi sang JSP
        request.setAttribute("settingList", settingList);
        request.setAttribute("typeList", typeList);
        request.setAttribute("selectedKeyword", keyword);
        request.setAttribute("selectedType", type);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("selectedSortBy", sortBy);

        request.getRequestDispatcher("SettingList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SettingDAO settingDAO = new SettingDAO();
        String action = request.getParameter("action");

        try {
            int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
            String type = request.getParameter("type");
            String value = request.getParameter("value");
            String description = request.getParameter("description");
            boolean status = "true".equals(request.getParameter("status"));
            int order = Integer.parseInt(request.getParameter("order"));

            Setting setting = new Setting(id, type, value, order, description, status);

            if ("edit".equals(action)) {
                settingDAO.editSetting(id, setting);
            } else if ("add".equals(action)) {
                settingDAO.addSetting(setting);
            }

            response.sendRedirect("SettingController?message=Operation successful");
        } catch (NumberFormatException e) {
            response.sendRedirect("SettingController?message=Invalid input format");
        }
    }
}