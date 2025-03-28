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
import java.util.List;

@WebServlet(name = "PostListController", urlPatterns = {"/postList"})
public class PostListController extends HttpServlet {

    private static final int LIMIT = 5; // Số bài viết mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();

        // Lấy tham số từ request
        String pageStr = request.getParameter("page");
        String keyword = request.getParameter("keyword");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        String categoryStr = request.getParameter("category");
        String filterTitle = request.getParameter("filterTitle"); // Filter theo title
        String filterAuthor = request.getParameter("filterAuthor"); // Filter theo author

        // Xử lý số trang
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        if (page < 1) page = 1;

        // Mặc định sắp xếp theo UploadDate ASC (cũ nhất) nếu không có sortBy/sortOrder
        if (sortBy == null && sortOrder == null) {
            sortBy = "UploadDate";
            sortOrder = "ASC";
        }

        // Lấy danh sách bài viết và tổng số trang
        List<Blog> blogs;
        int totalPages;

        if (filterTitle != null && !filterTitle.trim().isEmpty()) {
            // Filter theo title
            blogs = blogDAO.searchBlogs(filterTitle, page, LIMIT, sortBy, sortOrder);
            totalPages = blogDAO.getTotalPagesBySearch(filterTitle, LIMIT);
            request.setAttribute("filterTitle", filterTitle);
        } else if (filterAuthor != null && !filterAuthor.trim().isEmpty()) {
            // Filter theo author
            blogs = blogDAO.searchBlogs(filterAuthor, page, LIMIT, sortBy, sortOrder);
            totalPages = blogDAO.getTotalPagesBySearch(filterAuthor, LIMIT);
            request.setAttribute("filterAuthor", filterAuthor);
        } else if (categoryStr != null && !categoryStr.isEmpty()) {
            // Filter theo category
            int categoryId = Integer.parseInt(categoryStr);
            blogs = blogDAO.getBlogsByCategory(categoryId, page, LIMIT, sortBy, sortOrder);
            totalPages = blogDAO.getTotalPagesByCategory(categoryId, LIMIT);
            request.setAttribute("categoryParam", categoryId);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            // Tìm kiếm theo keyword
            blogs = blogDAO.searchBlogs(keyword, page, LIMIT, sortBy, sortOrder);
            totalPages = blogDAO.getTotalPagesBySearch(keyword, LIMIT);
        } else {
            // Lấy tất cả bài viết
            blogs = blogDAO.getAllBlogs(page, LIMIT, sortBy, sortOrder);
            totalPages = blogDAO.getTotalPages(LIMIT);
        }

        // Lấy danh sách danh mục
        List<Category> blogCategories = blogDAO.getAllBlogCategories();

        // Cập nhật danh mục tên cho từng blog
        for (Blog blog : blogs) {
            Category category = blogDAO.getCategoryByCateID(blog.getCateID());
            if (category != null) {
                blog.setCategoryName(category.getName());
            }
        }

        // Đặt dữ liệu vào request scope
        request.setAttribute("blogs", blogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("blogCategories", blogCategories);

        // Chuyển tiếp đến postList.jsp
        request.getRequestDispatcher("postList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Xử lý POST giống GET
    }
}