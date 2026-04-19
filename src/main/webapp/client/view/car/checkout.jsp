<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    :root { --vf-blue: #0062ff; --text-main: #0f172a; --bg-gray: #f8fafc; }
    .checkout-container { padding: 60px 0; }
    .form-control { border-radius: 12px; padding: 15px; background: var(--bg-gray); border: 1px solid #e2e8f0; font-weight: 600; }
    .summary-card { background: var(--bg-gray); border-radius: 28px; padding: 35px; border: 1px solid #f1f5f9; position: sticky; top: 100px; }
    .btn-confirm-order { background: var(--text-main); color: #fff; width: 100%; padding: 20px; border-radius: 18px; font-weight: 800; border: none; transition: 0.3s; }
    .btn-confirm-order:hover { background: var(--vf-blue); transform: translateY(-3px); }
    .price-item { display: flex; justify-content: space-between; margin-bottom: 15px; font-weight: 600; }
    .total-amount { font-size: 1.8rem; font-weight: 900; color: var(--vf-blue); }
</style>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<div class="container checkout-container">
    <div class="row g-5">
        <div class="col-lg-7">
            <h2 class="fw-bold mb-4 text-uppercase">Xác nhận đặt xe</h2>
            <form id="checkoutForm" action="${pageContext.request.contextPath}/order?action=create" method="POST">
                <input type="hidden" name="carId" value="${car.id}">
                <input type="hidden" id="hiddenTotalPrice" name="totalPrice" value="${car.pricePerDay}">

                <div class="row">
                    <div class="col-md-12 mb-4">
                        <label class="fw-bold small text-muted mb-2 text-uppercase">Họ tên người nhận</label>
                        <input type="text" name="customerName" class="form-control" value="${sessionScope.currUser.fullname}" required>
                    </div>
                    <div class="col-md-6 mb-4">
                        <label class="fw-bold small text-muted mb-2 text-uppercase">Số điện thoại</label>
                        <input type="tel" name="phone" class="form-control" value="${sessionScope.currUser.phone}" required>
                    </div>
                    <div class="col-md-6 mb-4">
                        <label class="fw-bold small text-muted mb-2 text-uppercase">Email</label>
                        <input type="email" name="email" class="form-control" value="${sessionScope.currUser.email}">
                    </div>
                    <div class="col-md-6 mb-4">
                        <label class="fw-bold small text-muted mb-2 text-uppercase">Ngày nhận xe</label>
                        <input type="date" name="startDate" id="startDate" class="form-control"
                               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                    </div>
                    <div class="col-md-6 mb-4">
                        <label class="fw-bold small text-muted mb-2 text-uppercase">Ngày trả xe</label>
                        <input type="date" name="endDate" id="endDate" class="form-control" required>
                    </div>
                    <div class="col-md-12 mb-4">
                        <label class="fw-bold small text-muted mb-2 text-uppercase">Ghi chú thêm</label>
                        <textarea name="note" class="form-control" rows="3"></textarea>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-lg-5">
            <div class="summary-card shadow-sm">
                <div class="d-flex gap-3 mb-4 pb-4 border-bottom">
                    <img src="${car.imageUrl}" style="width: 100px; height: 60px; object-fit: contain; background: #fff; border-radius: 10px;">
                    <div>
                        <h5 class="fw-bold mb-0">${car.modelName}</h5>
                        <small class="text-muted">${car.locationName}</small>
                    </div>
                </div>

                <div class="price-details">
                    <div class="price-item"><span>Đơn giá</span><span><fmt:formatNumber value="${car.pricePerDay}" pattern="#,###"/>đ/ngày</span></div>
                    <div class="price-item"><span>Số ngày thuê</span><span id="dayDisplay">0 ngày</span></div>
                    <div class="price-item text-success"><span>Phí dịch vụ</span><span>0đ</span></div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="fw-bold">TỔNG CỘNG</span>
                        <span id="totalDisplay" class="total-amount">0đ</span>
                    </div>
                </div>

                <button type="button" onclick="confirmOrder()" class="btn-confirm-order mt-4 shadow">XÁC NHẬN ĐẶT XE</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Logic tính tiền
    const startIn = document.getElementById('startDate');
    const endIn = document.getElementById('endDate');
    const pricePerDay = ${car.pricePerDay};

    function updatePrice() {
        if (startIn.value && endIn.value) {
            const start = new Date(startIn.value);
            const end = new Date(endIn.value);
            if (end <= start) {
                Swal.fire('Lỗi', 'Ngày trả phải sau ngày nhận!', 'error');
                endIn.value = ""; return;
            }
            const diff = Math.ceil((end - start) / (1000 * 60 * 60 * 24));
            document.getElementById('dayDisplay').innerText = diff + " ngày";
            document.getElementById('totalDisplay').innerText = (diff * pricePerDay).toLocaleString('vi-VN') + "đ";
            document.getElementById('hiddenTotalPrice').value = diff * pricePerDay;
        }
    }
    startIn.onchange = updatePrice; endIn.onchange = updatePrice;

    function confirmOrder() {
        if(!startIn.value || !endIn.value) { Swal.fire('Chú ý', 'Vui lòng chọn ngày!', 'warning'); return; }
        Swal.fire({
            title: 'Xác nhận đặt xe?',
            text: "Yêu cầu sẽ được gửi tới Admin phê duyệt.",
            icon: 'question', showCancelButton: true, confirmButtonColor: '#0062ff', confirmButtonText: 'Đồng ý'
        }).then((res) => { if(res.isConfirmed) document.getElementById('checkoutForm').submit(); });
    }
</script>

<c:if test="${not empty sessionScope.orderStatus}">
    <script>
        const status = "${sessionScope.orderStatus}";
        if (status === "success") {
            Swal.fire('Thành công!', 'Yêu cầu của bạn đã được ghi nhận!', 'success');
        } else {
            Swal.fire('Lỗi', 'Có lỗi xảy ra, vui lòng thử lại.', 'error');
        }
    </script>
    <c:remove var="orderStatus" scope="session" />
</c:if>