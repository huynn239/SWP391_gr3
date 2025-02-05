package controller;

import dto.ProductDAO;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class Homecontroller extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public Homecontroller() {
        super();
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("products", productList);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
