<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    :root {
        --vin-blue: #063197;
        --vin-red: #da291c;
    }
    .dashboard-wrapper { background: #f8f9fa; padding: 20px; min-height: 100vh; }
    .icon-box {
        width: 54px; height: 54px;
        display: flex; align-items: center; justify-content: center;
        border-radius: 14px; font-size: 1.6rem;
    }
    .card-stat {
        border-radius: 16px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        border: none !important;
    }
    .card-stat:hover {
        transform: translateY(-7px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.08) !important;
    }
    .chart-card {
        background: white; border-radius: 20px; padding: 24px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }
    .stat-label { font-size: 0.85rem; letter-spacing: 0.5px; color: #6c757d; }

    /* Hiệu ứng nháy cho đơn hàng mới */
    @keyframes pulse-red {
        0% { transform: scale(1); opacity: 1; }
        50% { transform: scale(1.1); opacity: 0.7; }
        100% { transform: scale(1); opacity: 1; }
    }
    .pulsate { animation: pulse-red 2s infinite; }
</style>

<div class="dashboard-wrapper">
    <div class="d-flex justify-content-end align-items-center mb-4">
        <div class="badge bg-white text-dark shadow-sm p-2 px-3 border border-0">
            <i class="bi bi-clock-history me-2 text-primary"></i>
            <span id="current-time"></span>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card card-stat p-3 bg-white shadow-sm">
                <div class="d-flex align-items-center">
                    <div class="icon-box bg-success-subtle text-success me-3">
                        <i class="bi bi-cash-coin"></i>
                    </div>
                    <div>
                        <p class="mb-0 stat-label fw-bold text-uppercase">Doanh thu thực</p>
                        <h4 class="mb-0 fw-bold text-dark">
                            <fmt:formatNumber value="${TotalRevenue != null ? TotalRevenue : 0}" type="currency" currencySymbol="₫" />
                        </h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card card-stat p-3 bg-white shadow-sm" onclick="location.href='user'">
                <div class="d-flex align-items-center">
                    <div class="icon-box bg-primary-subtle text-primary me-3">
                        <i class="bi bi-people"></i>
                    </div>
                    <div>
                        <p class="mb-0 stat-label fw-bold text-uppercase">Khách hàng</p>
                        <h4 class="mb-0 fw-bold text-dark">${TotalUser != null ? TotalUser : 0}</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card card-stat p-3 bg-white shadow-sm" onclick="location.href='admin-orders'">
                <div class="d-flex align-items-center">
                    <div class="icon-box bg-danger-subtle text-danger me-3">
                        <i class="bi bi-bell-fill pulsate"></i>
                    </div>
                    <div>
                        <p class="mb-0 stat-label fw-bold text-uppercase">Chờ duyệt</p>
                        <h4 class="mb-0 fw-bold text-danger">${NewOrders != null ? NewOrders : 0}</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card card-stat p-3 bg-white shadow-sm" onclick="location.href='product'">
                <div class="d-flex align-items-center">
                    <div class="icon-box bg-warning-subtle text-warning me-3">
                        <i class="bi bi-car-front-fill"></i>
                    </div>
                    <div>
                        <p class="mb-0 stat-label fw-bold text-uppercase">Tổng xe</p>
                        <h4 class="mb-0 fw-bold text-dark">${TotalCar != null ? TotalCar : 0}</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="chart-card shadow-sm h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0">Hiệu suất doanh thu (Số thực)</h5>
                    <span class="badge bg-light text-dark border">6 tháng gần nhất</span>
                </div>
                <div style="height: 320px;">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="chart-card shadow-sm h-100 text-center">
                <h5 class="fw-bold mb-4 text-start">Tình trạng xe</h5>
                <div style="height: 250px;">
                    <canvas id="carStatusChart"></canvas>
                </div>
                <div class="mt-4 pt-3 border-top">
                    <div class="row text-center">
                        <div class="col-6 border-end">
                            <p class="text-muted mb-1 small">Đang thuê</p>
                            <h5 class="fw-bold text-danger">${TotalCarUnavailable != null ? TotalCarUnavailable : 0}</h5>
                        </div>
                        <div class="col-6">
                            <p class="text-muted mb-1 small">Sẵn sàng</p>
                            <h5 class="fw-bold text-success">${TotalCarAvailable != null ? TotalCarAvailable : 0}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Cập nhật thời gian thực
    const updateTime = () => {
        document.getElementById('current-time').innerText = new Date().toLocaleString('vi-VN');
    }
    setInterval(updateTime, 1000);
    updateTime();

    document.addEventListener('DOMContentLoaded', function() {
        // 1. Biểu đồ Doanh thu số thực
        const ctxRev = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctxRev, {
            type: 'line',
            data: {
                labels: ['Tháng 11', 'Tháng 12', 'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4'],
                datasets: [{
                    label: 'Doanh thu thực tế',
                    // Đổ chuỗi số thực từ Servlet vào đây, ví dụ: 10.5, 20.2...
                    data: [${RevenueData != null ? RevenueData : "0, 0, 0, 0, 0, 0"}],
                    borderColor: '#063197',
                    backgroundColor: 'rgba(6, 49, 151, 0.1)',
                    fill: true,
                    tension: 0.4,
                    pointRadius: 6,
                    pointBackgroundColor: '#063197',
                    borderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) label += ': ';
                                if (context.parsed.y !== null) {
                                    label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
                                }
                                return label;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString('vi-VN') + ' ₫';
                            }
                        }
                    },
                    x: { grid: { display: false } }
                }
            }
        });

        // 2. Biểu đồ Trạng thái Xe số thực
        const ctxCar = document.getElementById('carStatusChart').getContext('2d');
        new Chart(ctxCar, {
            type: 'doughnut',
            data: {
                labels: ['Sẵn sàng', 'Đang thuê'],
                datasets: [{
                    data: [
                        ${TotalCarAvailable != null ? TotalCarAvailable : 0},
                        ${TotalCarUnavailable != null ? TotalCarUnavailable : 0}
                    ],
                    backgroundColor: ['#198754', '#da291c'],
                    hoverOffset: 20,
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '75%',
                plugins: {
                    legend: { position: 'bottom', labels: { padding: 20, usePointStyle: true } }
                }
            }
        });
    });
</script>