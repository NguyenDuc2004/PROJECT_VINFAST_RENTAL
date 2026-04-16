<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid px-4">
    <h2 class="mt-4">Thêm mới đơn hàng</h2>
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <form action="admin-orders?action=insert" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên khách hàng</label>
                    <input type="text" name="customerName" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Dòng xe</label>
                    <select name="carModel" class="form-select">
                        <option value="VinFast VF8">VinFast VF8</option>
                        <option value="VinFast VF9">VinFast VF9</option>
                        <option value="VinFast e34">VinFast VF e34</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Tổng tiền (VNĐ)</label>
                    <input type="number" name="totalPrice" class="form-control" required>
                </div>
                <div class="text-end">
                    <a href="admin-orders" class="btn btn-secondary">Hủy</a>
                    <button type="submit" class="btn btn-primary">Lưu đơn hàng</button>
                </div>
            </form>
        </div>
    </div>
</div>