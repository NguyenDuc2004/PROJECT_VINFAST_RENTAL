<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<jsp:useBean id="now" class="java.util.Date"/>

<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    :root {
        --vf-blue: #0062ff;
        --vf-blue-soft: #e6f0ff;
        --bg-light: #f1f5f9;
        --text-main: #1e293b;
        --text-muted: #64748b;
        --card-white: #ffffff;
    }

    body {
        background-color: var(--bg-light);
        background-image: radial-gradient(circle at top right, rgba(0, 98, 255, 0.03), transparent),
        radial-gradient(circle at bottom left, rgba(0, 98, 255, 0.03), transparent);
        font-family: 'Plus Jakarta Sans', sans-serif;
        color: var(--text-main);
        min-height: 100vh;
    }

    .hero-section { padding: 60px 0 40px; }
    .glass-header {
        background: var(--card-white);
        border: 1px solid rgba(0, 98, 255, 0.1);
        padding: 50px;
        border-radius: 40px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.03);
    }

    .brand-title { font-size: 5rem; font-weight: 800; letter-spacing: -2px; color: var(--text-main); margin-bottom: 5px; }
    .sub-title { color: var(--vf-blue); font-weight: 700; letter-spacing: 5px; text-transform: uppercase; font-size: 0.85rem; }
    .image-showcase { background: var(--card-white); border-radius: 40px; padding: 40px; border: 1px solid rgba(0, 0, 0, 0.05); box-shadow: 0 30px 60px rgba(0, 0, 0, 0.04); transition: transform 0.3s ease; }
    .img-main { filter: drop-shadow(0 20px 40px rgba(0, 0, 0, 0.1)); max-height: 300px; object-fit: contain; }
    .modern-label { font-size: 0.8rem; font-weight: 700; color: var(--text-muted); margin-bottom: 10px; display: block; padding-left: 5px; }

    .modern-input {
        background-color: #f1f5f9;
        border: 2px solid transparent;
        border-radius: 18px;
        padding: 16px 24px;
        color: var(--text-main);
        font-weight: 600;
        transition: all 0.3s;
    }
    .modern-input:focus {
        background-color: #ffffff;
        border-color: var(--vf-blue);
        box-shadow: 0 0 0 5px rgba(0, 98, 255, 0.08);
        outline: none;
    }

    .modern-textarea {
        min-height: 180px;
        resize: none;
        font-size: 0.9rem;
        line-height: 1.6;
    }

    .plate-input-container {
        background: #ffffff;
        border: 2px solid var(--text-main);
        border-radius: 14px;
        padding: 5px 20px;
        display: flex;
        align-items: center;
        width: fit-content;
    }
    .plate-field {
        border: none;
        font-size: 1.8rem;
        font-weight: 800;
        color: var(--text-main);
        font-family: 'Courier New', monospace;
        text-transform: uppercase;
        width: 250px;
        outline: none;
        text-align: center;
    }

    .btn-update { background: var(--vf-blue); color: #ffffff; border: none; border-radius: 20px; padding: 18px 45px; font-weight: 700; font-size: 1.1rem; box-shadow: 0 10px 25px rgba(0, 98, 255, 0.2); transition: all 0.3s ease; }
    .btn-update:hover { background: #0052d4; transform: scale(1.02); }
    .btn-cancel-outline { text-decoration: none; font-weight: 700; font-size: 0.9rem; color: var(--text-muted); padding: 18px 45px; border: 2px solid #e2e8f0; border-radius: 20px; display: inline-flex; align-items: center; transition: all 0.3s ease; background: transparent; }
    .btn-cancel-outline:hover { background-color: #f8fafc; border-color: var(--vf-blue); color: var(--vf-blue); transform: translateY(-2px); }
    .update-info { background: #f8fafc; color: #64748b; padding: 12px 20px; border-radius: 12px; font-size: 0.85rem; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; border: 1px solid #e2e8f0; margin-top: 20px; }
    .form-container { background: var(--card-white); border-radius: 40px; padding: 50px; border: 1px solid rgba(0, 0, 0, 0.03); }
</style>

<div class="container">
    <form action="${pageContext.request.contextPath}/product" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${car.id}">

        <div class="hero-section text-center">
            <div class="glass-header">
                <span class="sub-title d-block mb-2">Technical Configuration</span>
                <h1 class="brand-title">${car.modelName}</h1>
                <p class="text-muted fw-500">Hiệu chỉnh thông số kỹ thuật hệ thống quản trị</p>
            </div>
        </div>

        <div class="row g-5 mt-2">
            <div class="col-lg-6">
                <div class="image-showcase text-center h-100 d-flex flex-column">
                    <img id="previewImg" src="${car.imageUrl}" class="img-main img-fluid mb-5"
                         onerror="this.src='https://img.vanhai.vn/202304/xe-dien-vinfast-vf8.jpg'">

                    <div class="text-start mt-auto w-100">
                        <div class="mb-4">
                            <label class="modern-label">ĐƯỜNG DẪN HÌNH ẢNH (CDN/URL)</label>
                            <div class="input-group bg-light rounded-4 overflow-hidden p-1">
                                <span class="input-group-text bg-transparent border-0"><i
                                        class="bi bi-link-45deg text-primary fs-4"></i></span>
                                <input type="text" name="imageUrl" id="imageUrlInput"
                                       class="form-control border-0 bg-transparent shadow-none py-2"
                                       value="${car.imageUrl}" style="font-size: 0.9rem;">
                            </div>
                        </div>

                        <div class="mb-2">
                            <label class="modern-label">MÔ TẢ CHI TIẾT SẢN PHẨM</label>
                            <textarea name="description" class="form-control modern-input modern-textarea w-100"
                                      placeholder="Nhập thông số pin, số ghế, tiện nghi...">${car.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-container h-100">
                    <div class="mb-4">
                        <label class="modern-label">TÊN DÒNG XE ĐỊNH DANH</label>
                        <input type="text" name="name" class="form-control modern-input w-100" value="${car.modelName}">
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <label class="modern-label">GIÁ THUÊ ƯU ĐÃI (VNĐ/Ngày)</label>
                            <fmt:formatNumber value="${car.pricePerDay}" pattern="#,###" var="formattedPrice"/>
                            <input type="text" name="price" id="edit_price"
                                   class="form-control modern-input text-primary fs-4 fw-bold"
                                   value="${formattedPrice}">
                        </div>
                        <div class="col-md-6">
                            <label class="modern-label">PHÂN LOẠI XE</label>
                            <select name="categoryId" class="form-select modern-input">
                                <option value="1" ${car.categoryId == 1 ? 'selected' : ''}>SUV</option>
                                <option value="2" ${car.categoryId == 2 ? 'selected' : ''}>SEDAN</option>
                                <option value="3" ${car.categoryId == 3 ? 'selected' : ''}>HATCHBACK</option>
                            </select>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <label class="modern-label">ĐỊA ĐIỂM QUẢN LÝ</label>
                            <select name="locationId" class="form-select modern-input">
                                <c:forEach items="${listLocations}" var="loc">
                                    <option value="${loc.id}" ${car.locationId == loc.id ? 'selected' : ''}>
                                            ${loc.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="modern-label">TRẠNG THÁI VẬN HÀNH</label>
                            <select name="status" class="form-select modern-input">
                                <option value="AVAILABLE" ${car.status == 'AVAILABLE' ? 'selected' : ''}>🟢 Sẵn sàng phục vụ</option>
                                <option value="UNAVAILABLE" ${car.status == 'UNAVAILABLE' ? 'selected' : ''}>🔴 Đang bảo trì</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-5">
                        <label class="modern-label">MÃ SỐ NHẬN DIỆN (LICENSE PLATE)</label>
                        <div class="plate-input-container">
                            <input type="text" name="licensePlate" class="plate-field"
                                   value="${car.licensePlate}" placeholder="30H-123.45">
                        </div>
                        <small class="text-muted ps-2 mt-1 d-block italic">Để trống nếu chưa gán biển số</small>
                    </div>

                    <div class="d-flex align-items-center justify-content-center gap-4 pt-4 border-top">
                        <button type="submit" class="btn btn-update">CẬP NHẬT HỆ THỐNG</button>
                        <a href="${pageContext.request.contextPath}/product" class="btn-cancel-outline">HỦY</a>
                    </div>

                    <div class="text-center text-lg-start">
                        <div class="update-info">
                            <i class="bi bi-shield-check-fill text-success"></i>
                            <span>Dữ liệu xác thực: <fmt:formatDate value="${now}" pattern="dd/MM/yyyy HH:mm"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    // Preview ảnh thời gian thực khi dán link
    const imgInput = document.getElementById('imageUrlInput');
    const previewImg = document.getElementById('previewImg');
    if(imgInput && previewImg) {
        imgInput.addEventListener('input', function() {
            previewImg.src = this.value || 'https://img.vanhai.vn/202304/xe-dien-vinfast-vf8.jpg';
        });
    }

    // Tự động định dạng tiền tệ (ví dụ: 1.000.000)
    const priceInput = document.getElementById('edit_price');
    if (priceInput) {
        priceInput.addEventListener('input', function (e) {
            let cursorPosition = this.selectionStart;
            let originalLength = this.value.length;
            let rawValue = this.value.replace(/[^0-9]/g, '');
            if (rawValue === "") { this.value = ""; return; }
            let formattedValue = new Intl.NumberFormat('vi-VN').format(parseInt(rawValue));
            this.value = formattedValue;
            let newLength = this.value.length;
            cursorPosition = cursorPosition + (newLength - originalLength);
            this.setSelectionRange(cursorPosition, cursorPosition);
        });
    }
</script>