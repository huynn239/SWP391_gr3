package controller;

import dto.SettingDAO;
import model.Setting;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SettingDetailController", urlPatterns = {"/SettingDetail"})
public class SettingDetailController extends HttpServlet {
    private static final Map<Integer, String> ROLE_MAP = new HashMap<>();
    static {
        ROLE_MAP.put(1, "Admin");
        ROLE_MAP.put(2, "Marketing");
        ROLE_MAP.put(3, "Sale");
        ROLE_MAP.put(4, "Customer");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        SettingDAO settingDAO = new SettingDAO();
        Setting setting = settingDAO.getSettingById(id);
        
        if (setting != null) {
            setting.setType(ROLE_MAP.getOrDefault(setting.getOrder(), "Unknown"));
        }
        
        request.setAttribute("setting", setting);
        request.getRequestDispatcher("SettingDetail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String value = request.getParameter("value");
        int order = Integer.parseInt(request.getParameter("order"));
        String description = request.getParameter("description");
        boolean status = "on".equals(request.getParameter("status"));
        
        String type = ROLE_MAP.getOrDefault(order, "Unknown");
        Setting setting = new Setting(id, type, value, order, description, status);
        SettingDAO settingDAO = new SettingDAO();
        
        boolean updated = settingDAO.editSetting(id, setting);
        if (updated) {
            response.sendRedirect("SettingController?success=true");
        } else {
            response.sendRedirect("SettingDetail.jsp?id=" + id + "&error=true");
        }
    }
}
