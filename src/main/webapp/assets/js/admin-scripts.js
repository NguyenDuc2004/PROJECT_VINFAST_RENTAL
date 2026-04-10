/**
 * Admin Panel Main Script
 * Quản lý các tương tác logic cho bộ khung Layout
 */
document.addEventListener("DOMContentLoaded", function () {

    // 1. KHAI BÁO CÁC PHẦN TỬ CHÍNH
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const btnCollapse = document.getElementById('sidebarCollapse');

    // 2. LOGIC ẨN/HIỆN SIDEBAR
    if (btnCollapse && sidebar && content) {
        btnCollapse.addEventListener('click', function () {
            // Toggle class để thay đổi chiều rộng sidebar và margin của content
            sidebar.classList.toggle('collapsed');
            content.classList.toggle('expanded');

            // Lưu trạng thái vào LocalStorage (giống như Persistence State trong React)
            // Để khi reload trang người dùng không bị reset trạng thái đóng/mở
            const isCollapsed = sidebar.classList.contains('collapsed');
            localStorage.setItem('sidebar-status', isCollapsed ? 'collapsed' : 'expanded');
        });

        // Khôi phục trạng thái sidebar từ lần truy cập trước
        const savedStatus = localStorage.getItem('sidebar-status');
        if (savedStatus === 'collapsed') {
            sidebar.classList.add('collapsed');
            content.classList.add('expanded');
        }
    }

    // 3. HIỆU ỨNG GỢN SÓNG (RIPPLE EFFECT) CHO CARD VÀ BUTTON
    // Áp dụng cho bất kỳ phần tử nào có class .card-stat hoặc .btn-primary
    const rippleElements = document.querySelectorAll('.card-stat, .btn-primary, .btn-action');

    rippleElements.forEach(el => {
        el.addEventListener('click', function (e) {
            // Tạo phần tử span để làm vòng tròn gợn sóng
            let x = e.clientX - e.target.getBoundingClientRect().left;
            let y = e.clientY - e.target.getBoundingClientRect().top;

            let ripples = document.createElement('span');
            ripples.classList.add('ripple'); // Class này đã có trong CSS của bạn
            ripples.style.left = x + 'px';
            ripples.style.top = y + 'px';

            this.appendChild(ripples);

            // Xóa sau khi animation kết thúc (600ms)
            setTimeout(() => {
                ripples.remove();
            }, 600);
        });
    });

    // 4. TỰ ĐỘNG ĐÓNG SIDEBAR TRÊN MOBILE
    const handleResize = () => {
        if (window.innerWidth < 768) {
            sidebar.classList.add('collapsed');
            content.classList.add('expanded');
        } else {
            // Nếu không phải mobile, khôi phục theo localStorage
            const savedStatus = localStorage.getItem('sidebar-status');
            if (savedStatus !== 'collapsed') {
                sidebar.classList.remove('collapsed');
                content.classList.remove('expanded');
            }
        }
    };

    window.addEventListener('resize', handleResize);
    handleResize(); // Chạy lần đầu khi load trang
});