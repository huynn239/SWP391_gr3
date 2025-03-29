package controller;

import dto.BlogDAO;
import model.Blog;
import model.Category;

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

@WebServlet(name = "AddPostController", urlPatterns = {"/addPost"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddPostController extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra thông báo thành công từ redirect
        String success = request.getParameter("success");
        if (success != null && success.equals("add")) {
            request.setAttribute("successMessage", "Thêm bài viết thành công!");
        }

        // Lấy danh sách danh mục để hiển thị trong form
        List<Category> blogCategories = blogDAO.getAllBlogCategories();
        request.setAttribute("blogCategories", blogCategories);

        request.getRequestDispatcher("addPost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String categoryStr = request.getParameter("category");
        String userId = "1"; // Giả sử userId mặc định là 1

        // Xử lý file ảnh
        Part filePart = request.getPart("blogImage");
        String fileName = null;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        if (filePart != null && filePart.getSize() > 0) {
            fileName = extractFileName(filePart);
            filePart.write(uploadPath + File.separator + fileName);
            fileName = "uploads/" + fileName; 
        }

        // Kiểm tra dữ liệu đầu vào
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
            newBlog.setBlogImage(fileName); // Lưu đường dẫn ảnh
            newBlog.setUploadDate(new Date(System.currentTimeMillis())); // Ngày hiện tại
            newBlog.setAuthor("admin"); // Giả sử author mặc định
            newBlog.setCateID(categoryId);

            // Thêm blog vào database
            boolean success = blogDAO.addBlog(newBlog, userId);
            if (success) {
                response.sendRedirect("postList?success=add");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm bài viết.");
                doGet(request, response);
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