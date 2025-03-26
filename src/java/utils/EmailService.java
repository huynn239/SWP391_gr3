package utils;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.List;
import java.util.Properties;
import model.Cart;

public class EmailService {
    private static final String FROM_EMAIL = "lamnbhe181873@fpt.edu.vn";
    private static final String PASSWORD = "knpq nsht ppeg qtwo";
    private static final String LOGO_URL = "https://img.freepik.com/premium-vector/men-s-clothing-store-logo-clothing-store-transparent-background-clothing-shop-logo-vector_148524-756.jpg"; // Thay bằng URL logo thật

    public static void sendOrderConfirmationEmail(String toEmail, List<Cart> selectedItems, int orderId, 
                                                  String receiverName, String receiverAddress, double totalAmount) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Cảm ơn bạn đã đặt hàng - Mã đơn hàng: " + orderId, "UTF-8");

            // Nội dung HTML
            StringBuilder emailContent = new StringBuilder();
            emailContent.append("<!DOCTYPE html>")
                        .append("<html><head><style>")
                        .append("body { font-family: Arial, sans-serif; color: #333; }")
                        .append(".container { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; }")
                        .append("h1 { color: #2c3e50; }")
                        .append("table { width: 100%; border-collapse: collapse; margin: 20px 0; }")
                        .append("th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }")
                        .append("th { background-color: #f5f5f5; }")
                        .append(".footer { text-align: center; font-size: 12px; color: #777; margin-top: 20px; }")
                        .append("img.product-img { width: 50px; height: auto; }")
                        .append("</style></head><body>")
                        .append("<div class='container'>")
                        .append("<img src='").append(LOGO_URL).append("' alt='ShopOnline Logo' style='max-width: 150px; display: block; margin: 0 auto;'/>")
                        .append("<h1>Cảm ơn quý khách ").append(receiverName).append(" đã mua hàng,</h1>")
                        .append("<p> <strong>Men's Clothing Store</strong> rất hân hạnh được phục vụ !. Dưới đây là thông tin đơn hàng của bạn:</p>")
                        .append("<p><strong>Mã đơn hàng:</strong> ").append(orderId).append("</p>")
                        .append("<p><strong>Địa chỉ giao hàng:</strong> ").append(receiverAddress).append("</p>")
                        .append("<h3>Chi tiết sản phẩm</h3>")
                        .append("<table>")
                        .append("<tr><th>Hình ảnh</th><th>Tên sản phẩm</th><th>Size</th><th>Màu</th><th>Số lượng</th><th>Giá</th></tr>");

            for (Cart item : selectedItems) {
                emailContent.append("<tr>")
                            .append("<td><img src='").append(item.getImage()).append("' alt='").append(item.getName()).append("' class='product-img'/></td>")
                            .append("<td>").append(item.getName()).append("</td>")
                            .append("<td>").append(item.getSize()).append("</td>")
                            .append("<td>").append(getColorName(item.getColor())).append("</td>")
                            .append("<td>").append(item.getQuantity()).append("</td>")
                            .append("<td>").append(String.format("%.0f", (double) item.getPrice())).append("đ</td>")
                            .append("</tr>");
            }

            emailContent.append("</table>")
                        .append("<p><strong>Tổng tiền:</strong> ").append(String.format("%.1f", totalAmount)).append("đ</p>")
                        .append("<p>Chúng tôi sẽ sớm xử lý đơn hàng và giao đến bạn. Nếu có thắc mắc, vui lòng liên hệ qua email này.</p>")
                        .append("<div class='footer'>")
                        .append("<p><strong>Trân trọng,</strong><br>Men's Clothing Store</p>")
                        .append("<p>&copy; 2025 ShopOnline. All rights reserved.</p>")
                        .append("</div>")
                        .append("</div></body></html>");

            // Thiết lập nội dung HTML với mã hóa UTF-8
            message.setContent(emailContent.toString(), "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    private static String getColorName(String colorId) {
        switch (colorId) {
            case "1": return "Đen";
            case "2": return "Xám";
            case "3": return "Trắng";
            case "4": return "Be";
            case "5": return "Đỏ";
            case "6": return "Cam";
            case "7": return "Vàng";
            case "8": return "Nâu";
            case "9": return "Xanh sáng";
            case "10": return "Xanh đậm";
            case "11": return "Xanh lá";
            default: return colorId;
        }
    }
}