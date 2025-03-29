package controller;

import dto.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.http.Part;
import model.Account;

@WebServlet(name = "ProfileController", urlPatterns = {"/ProfileController"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("u");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp?message=Please+login+to+access+profile");
            return;
        }

        String action = request.getParameter("action");

        if ("viewProfile".equals(action)) {
            int userId = loggedInUser.getId();
            Account user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=User+not+found");
            }

        } else if ("editProfile".equals(action)) {
            int userId = loggedInUser.getId();
            Account user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=User+not+found");
            }

        } else {
            response.sendRedirect("error.jsp?message=Invalid+action");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("u");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp?message=Please+login+to+update+your+profile");
            return;
        }

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            int userId = loggedInUser.getId();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "avatars";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String avatarPath = loggedInUser.getAvatar(); // Giữ nguyên avatar cũ
            Part filePart = request.getPart("avatar"); // Lấy file ảnh

            // Kiểm tra nếu người dùng có chọn ảnh mới
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Đảm bảo tên file là duy nhất (có thể thêm timestamp)
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadPath + File.separator + uniqueFileName);
                avatarPath = "avatars/" + uniqueFileName; // Cập nhật đường dẫn ảnh mới
                System.out.println("Avatar uploaded to: " + uploadPath + File.separator + uniqueFileName);
            } else {
                System.out.println("No new avatar uploaded, keeping old one: " + avatarPath);
            }

            Account updatedUser = new Account(
                userId,
                request.getParameter("uName"),
                loggedInUser.getUsername(),
                loggedInUser.getPassword(),
                request.getParameter("gender"),
                request.getParameter("email"),
                request.getParameter("mobile"),
                request.getParameter("uAddress"),
                loggedInUser.getRoleID()
            );

            boolean success = userDAO.editUser(userId, updatedUser);
            if (success) {
                session.setAttribute("u", updatedUser); // Cập nhật session với thông tin mới
                response.sendRedirect("ProfileController?action=viewProfile&message=Profile+updated+successfully");
            } else {
                response.sendRedirect("ProfileController?action=viewProfile&message=Failed+to+update+profile");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Profile Management Controller";
    }
}