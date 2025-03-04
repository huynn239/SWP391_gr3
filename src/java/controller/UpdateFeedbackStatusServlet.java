package controller;

import dto.FeedbackDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;

/**
 *
 * @author thang
 */
@WebServlet(name = "UpdateFeedbackStatusServlet", urlPatterns = {"/UpdateFeedbackStatusServlet"})
public class UpdateFeedbackStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
            String newStatus = request.getParameter("status");
            
            FeedbackDAO dao = new FeedbackDAO();
            boolean success = dao.updateFeedbackStatus(feedbackId, newStatus);
            
            if (success) {
                response.sendRedirect("FeedbackDetail.jsp?feedbackId=" + feedbackId);
            } else {
                response.getWriter().println("Lỗi khi cập nhật trạng thái.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UpdateFeedbackStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
