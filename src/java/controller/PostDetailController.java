package controller;

import dto.BlogDAO;
import model.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

@WebServlet(name = "PostDetailController", urlPatterns = {"/postDetail"})
public class PostDetailController extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID bài viết từ request
        String postId = request.getParameter("id");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (postId == null || postId.trim().isEmpty()) {
            out.print("{\"error\": \"ID bài viết không hợp lệ\"}");
            out.flush();
            return;
        }

        // Lấy thông tin bài viết từ BlogDAO
        Blog blog = blogDAO.getBlogById(postId);
        if (blog == null) {
            out.print("{\"error\": \"Bài viết không tồn tại\"}");
            out.flush();
            return;
        }

        // Chuyển đối tượng Blog thành JSON
        Gson gson = new Gson();
        String json = gson.toJson(blog);
        out.print(json);
        out.flush();
    }
}