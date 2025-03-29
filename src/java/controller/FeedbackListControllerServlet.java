package controller;

import dto.FeedbackDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "FeedbackListControllerServlet", urlPatterns = {"/FeedbackListControllerServlet"})
public class FeedbackListControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FeedbackDAO feedbackDAO = new FeedbackDAO();

            // Lấy các tham số lọc từ request
            String keyword = request.getParameter("keyword");
            String ratedStarStr = request.getParameter("ratedStar");
            Integer ratedStar = (ratedStarStr != null && !ratedStarStr.isEmpty()) ? Integer.parseInt(ratedStarStr) : null;

            // Lấy danh sách phản hồi đã lọc
            List<Feedback> feedbackList = feedbackDAO.getFilteredFeedbacks(keyword, ratedStar);

            // Phân trang
            int page = 1;
            int pageSize = 10;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int totalFeedbacks = feedbackList.size();
            int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);
            int start = (page - 1) * pageSize;
            int end = Math.min(start + pageSize, totalFeedbacks);

            List<Feedback> paginatedList = feedbackList.subList(start, end);

            // Gửi dữ liệu sang JSP
            request.setAttribute("feedbackList", paginatedList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("selectedKeyword", keyword);
            request.setAttribute("selectedRatedStar", ratedStarStr);

            // Forward tới JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("FeedbackList.jsp");
            dispatcher.forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(FeedbackListControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Feedback List Controller Servlet";
    }
}