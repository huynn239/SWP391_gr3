package vnpay;

import jakarta.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import model.Cart;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;
import vnpay.VNPayConfig;

public class VNPayService {

    public static String createPaymentUrl(HttpServletRequest request, List<Cart> selectedItems, String orderId) throws UnsupportedEncodingException {
        // Tính tổng tiền
        long totalAmount = 0;
        for (Cart item : selectedItems) {
            totalAmount += item.getPrice() * item.getQuantity();
        }
        totalAmount *= 100; // VNPay yêu cầu đơn vị nhỏ nhất (nhân 100)

        // Tạo tham số VNPay
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", VNPayConfig.vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(totalAmount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", orderId);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang: " + orderId);
        vnp_Params.put("vnp_OrderType", "250000");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", VNPayConfig.getIpAddress(request));

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        // Tạo chuỗi hash
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString())).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (fieldNames.indexOf(fieldName) < fieldNames.size() - 1) {
                    hashData.append('&');
                    query.append('&');
                }
            }
        }

        String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.secretKey, hashData.toString());
        query.append("&vnp_SecureHash=").append(vnp_SecureHash);

        return VNPayConfig.vnp_PayUrl + "?" + query.toString();
    }

    public static boolean verifyPaymentResponse(HttpServletRequest request) throws UnsupportedEncodingException {
        Map<String, String> fields = new HashMap<>();
        for (String key : request.getParameterMap().keySet()) {
            String value = request.getParameter(key);
            if (value != null && !value.isEmpty()) {
                fields.put(key, value);
            }
        }

        String vnp_SecureHash = fields.remove("vnp_SecureHash");

        // Tạo chuỗi hash để kiểm tra
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = fields.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString())).append('&');
            }
        }
        hashData.setLength(hashData.length() - 1);

        String checkHash = VNPayConfig.hmacSHA512(VNPayConfig.secretKey, hashData.toString());
        return checkHash.equalsIgnoreCase(vnp_SecureHash);
    }

    public static String getResponseCode(HttpServletRequest request) {
        return request.getParameter("vnp_ResponseCode");
    }

    public static String getTransactionRef(HttpServletRequest request) {
        return request.getParameter("vnp_TxnRef");
    }
}