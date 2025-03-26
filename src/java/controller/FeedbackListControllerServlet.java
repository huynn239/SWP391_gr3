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
            List<Feedback> feedbackList = feedbackDAO.getAllFeedbacks();
            
            // Set the feedbackList attribute to pass it to the JSP
            request.setAttribute("feedbackList", feedbackList);
            
            // Forward the request to FeedbackList.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("FeedbackList.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();  // Log the SQL error
            response.getWriter().println("Lỗi khi tải danh sách phản hồi: " + e.getMessage());
        } catch (Exception ex) {
            Logger.getLogger(FeedbackListControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Feedback List Controller Servlet";
    }
}
