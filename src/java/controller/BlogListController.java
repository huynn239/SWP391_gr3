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
 
 
 public class BlogListController extends HttpServlet {
     private BlogDAO blogDAO;
 
     @Override
     public void init() throws ServletException {
         blogDAO = new BlogDAO();
     }
 
     @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         // Xử lý tham số page
         String pageParam = request.getParameter("page");
         int currentPage = 1; // Giá trị mặc định
         if (pageParam != null && !pageParam.trim().isEmpty()) {
             try {
                 currentPage = Integer.parseInt(pageParam);
                 if (currentPage < 1) currentPage = 1; // Đảm bảo page không âm
             } catch (NumberFormatException e) {
                 currentPage = 1; // Nếu lỗi, quay về trang 1
             }
         }
 
         int limit = 3;
         String keyword = request.getParameter("keyword");
         String categoryParam = request.getParameter("category");
         String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "UploadDate"; // Mặc định UploadDate
         String sortOrder = request.getParameter("sortOrder") != null ? request.getParameter("sortOrder") : "DESC"; // Mặc định DESC
 
         List<Category> blogCategories = blogDAO.getAllBlogCategories();
         List<Blog> blogs;
         int totalPages;
 
         if (keyword != null && !keyword.trim().isEmpty()) {
             blogs = blogDAO.searchBlogs(keyword, currentPage, limit, sortBy, sortOrder);
             totalPages = blogDAO.getTotalPagesBySearch(keyword, limit);
         } else if (categoryParam != null && !categoryParam.trim().isEmpty()) {
             try {
                 int selectedCategory = Integer.parseInt(categoryParam);
                 blogs = blogDAO.getBlogsByCategory(selectedCategory, currentPage, limit, sortBy, sortOrder);
                 totalPages = blogDAO.getTotalPagesByCategory(selectedCategory, limit);
             } catch (NumberFormatException e) {
                 blogs = blogDAO.getAllBlogs(currentPage, limit, sortBy, sortOrder); // Nếu category không hợp lệ, lấy tất cả
                 totalPages = blogDAO.getTotalPages(limit);
             }
         } else {
             blogs = blogDAO.getAllBlogs(currentPage, limit, sortBy, sortOrder);
             totalPages = blogDAO.getTotalPages(limit);
         }
 
         // Đảm bảo totalPages không âm
         if (totalPages < 1) totalPages = 1;
         if (currentPage > totalPages) currentPage = totalPages;
 
         request.setAttribute("blogCategories", blogCategories);
         request.setAttribute("blogs", blogs);
         request.setAttribute("totalPages", totalPages);
         request.setAttribute("currentPage", currentPage);
         request.setAttribute("keyword", keyword);
         request.setAttribute("categoryParam", categoryParam);
         request.setAttribute("sortBy", sortBy);
         request.setAttribute("sortOrder", sortOrder);
         
 
         request.getRequestDispatcher("/blogList.jsp").forward(request, response);
     }
 }