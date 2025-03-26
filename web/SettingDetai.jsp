<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Setting Detail</title>
    <style>
        .form-container { width: 50%; margin: 20px auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%; padding: 8px; box-sizing: border-box;
        }
        .button { padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 3px; cursor: pointer; }
        .cancel-btn { background-color: #f44336; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>${action == 'add' ? 'Add New Setting' : action == 'view' ? 'View Setting' : 'Edit Setting'}</h2>
        <form action="SettingDetail" method="post">
            <input type="hidden" name="id" value="${setting.id}"/>
            
            <div class="form-group">
                <label>Type:</label>
                <select name="type" ${action == 'view' ? 'disabled' : 'required'}>
                    <option value="Admin" ${setting.type == 'Admin' ? 'selected' : ''}>Admin</option>
                    <option value="Marketing" ${setting.type == 'Marketing' ? 'selected' : ''}>Marketing</option>
                    <option value="Sale" ${setting.type == 'Sale' ? 'selected' : ''}>Sale</option>
                    <option value="Customer" ${setting.type == 'Customer' ? 'selected' : ''}>Customer</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="value" value="${setting.value}" ${action == 'view' ? 'disabled' : 'required'}/>
            </div>
            
            <div class="form-group">
                <label>Order:</label>
                <input type="number" name="order" value="${setting.order}" ${action == 'view' ? 'disabled' : 'required'}/>
            </div>
            
            <div class="form-group">
                <label>Description:</label>
                <textarea name="description" ${action == 'view' ? 'disabled' : ''}>${setting.description}</textarea>
            </div>
            
            <div class="form-group">
                <label>Status:</label>
                <select name="status" ${action == 'view' ? 'disabled' : ''}>
                    <option value="true" ${setting.status ? 'selected' : ''}>Active</option>
                    <option value="false" ${!setting.status ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
            
            <c:if test="${action != 'view'}">
                <input type="hidden" name="action" value="${action}"/>
                <button type="submit" class="button">Save</button>
            </c:if>
            <a href="SettingController" class="button cancel-btn">Back</a>
        </form>
    </div>
</body>
</html>
