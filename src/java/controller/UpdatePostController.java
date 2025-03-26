package controller;

import dto.BlogDAO;
import model.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import model.Category;

@WebServlet(name = "UpdatePostController", urlPatterns = {"/editPost"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UpdatePostController extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("postList");
            return;
        }

        Blog blog = blogDAO.getBlogById(id);
        if (blog == null) {
            response.sendRedirect("postList");
            return;
        }

        List<Category> blogCategories = blogDAO.getAllBlogCategories();
        request.setAttribute("blog", blog);
        request.setAttribute("blogCategories", blogCategories);
        request.getRequestDispatcher("editPost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String categoryStr = request.getParameter("category");

        // Xử lý file ảnh
        Part filePart = request.getPart("blogImage");
        String fileName = null;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        if (filePart != null && filePart.getSize() > 0) {
            fileName = extractFileName(filePart);
            filePart.write(uploadPath + File.separator + fileName);
            fileName = "uploads/" + fileName; // Đường dẫn tương đối để lưu vào DB
        }

        // Kiểm tra dữ liệu đầu vào
        if (id == null || title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty() || categoryStr == null) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            doGet(request, response);
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryStr);
            Blog blog = blogDAO.getBlogById(id);
            if (blog == null) {
                response.sendRedirect("postList");
                return;
            }

            // Cập nhật thông tin blog
            blog.setTitle(title);
            blog.setContent(content);
            blog.setCateID(categoryId);
            if (fileName != null) {
                blog.setBlogImage(fileName); // Chỉ cập nhật ảnh nếu có file mới
            }

            boolean success = blogDAO.updateBlog(blog);
            if (success) {
                response.sendRedirect("postList");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật bài viết.");
                request.setAttribute("blog", blog);
                request.setAttribute("blogCategories", blogDAO.getAllBlogCategories());
                request.getRequestDispatcher("editPost.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Danh mục không hợp lệ.");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
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