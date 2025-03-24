package controller;

import dto.BlogDAO;
import model.Blog;
import model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "AddPostController", urlPatterns = {"/addPost"})
public class AddPostController extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách danh mục để hiển thị trong form
            List<Category> blogCategories = blogDAO.getAllBlogCategories();
        request.setAttribute("blogCategories", blogCategories);

      
        request.getRequestDispatcher("addPost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String blogImage = request.getParameter("blogImage"); 
        String categoryStr = request.getParameter("category");
        String userId = "1";


        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty() || categoryStr == null) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            doGet(request, response); 
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryStr);
            // Tạo đối tượng Blog mới
            Blog newBlog = new Blog();
            newBlog.setTitle(title);
            newBlog.setContent(content);
            newBlog.setBlogImage(blogImage);
            newBlog.setUploadDate(new Date(System.currentTimeMillis())); // Ngày hiện tại
            newBlog.setAuthor("admin");
            newBlog.setCateID(categoryId);

         
            boolean success = blogDAO.addBlog(newBlog, userId);
            if (success) {
                response.sendRedirect("postList"); 
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm bài viết.");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Danh mục không hợp lệ.");
            doGet(request, response);
        }
    }
}