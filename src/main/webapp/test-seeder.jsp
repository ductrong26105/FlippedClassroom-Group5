<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="jakarta.persistence.EntityTransaction" %>
<%@ page import="org.flearn.dao.DBContext" %>
<%@ page import="org.flearn.model.*" %>
<%@ page import="org.flearn.util.AppConstants" %>
<%@ page import="org.flearn.util.PasswordUtil" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>FLearn Test Data Seeder</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="bg-dark text-light py-5">
<div class="container" style="max-width: 800px;">
    <div class="card bg-secondary text-light p-4 shadow-lg">
        <h2 class="text-center text-warning mb-4"><i class="fas fa-database me-2"></i> FLearn Seeder Dữ Liệu Thử Nghiệm</h2>
        
        <%
            EntityManager em = DBContext.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            
            boolean seedDefaultUsersSuccess = false;
            boolean seedProgressSuccess = false;
            String errorMessage = null;
            
            User adminUser = null;
            User teacherUser = null;
            User studentUser = null;
            
            User loggedInUser = (User) session.getAttribute("loggedInUser");
            
            try {
                tx.begin();
                
                // 1. Seed Admin User
                List<User> admins = em.createQuery("SELECT u FROM User u WHERE u.username = 'admin_test'", User.class).getResultList();
                if (!admins.isEmpty()) {
                    adminUser = admins.get(0);
                } else {
                    adminUser = User.builder()
                            .username("admin_test")
                            .passwordHash(PasswordUtil.hashPassword("admin123"))
                            .fullName("Quản trị viên Hệ thống")
                            .email("admin@flearn.edu.vn")
                            .role(AppConstants.ROLE_ADMIN)
                            .isActive(true)
                            .createdAt(LocalDateTime.now())
                            .build();
                    em.persist(adminUser);
                }
                
                // 2. Seed Teacher User
                List<User> teachers = em.createQuery("SELECT u FROM User u WHERE u.username = 'teacher_test'", User.class).getResultList();
                if (!teachers.isEmpty()) {
                    teacherUser = teachers.get(0);
                } else {
                    teacherUser = User.builder()
                            .username("teacher_test")
                            .passwordHash(PasswordUtil.hashPassword("teacher123"))
                            .fullName("Thầy Nguyễn Văn Giảng")
                            .email("giangvien@flearn.edu.vn")
                            .role(AppConstants.ROLE_TEACHER)
                            .isActive(true)
                            .createdAt(LocalDateTime.now())
                            .build();
                    em.persist(teacherUser);
                }
                
                // 3. Seed Student User
                List<User> students = em.createQuery("SELECT u FROM User u WHERE u.username = 'student_test'", User.class).getResultList();
                if (!students.isEmpty()) {
                    studentUser = students.get(0);
                } else {
                    studentUser = User.builder()
                            .username("student_test")
                            .passwordHash(PasswordUtil.hashPassword("student123"))
                            .fullName("Sinh viên Thử nghiệm")
                            .email("student@flearn.edu.vn")
                            .role(AppConstants.ROLE_STUDENT)
                            .isActive(true)
                            .createdAt(LocalDateTime.now())
                            .build();
                    em.persist(studentUser);
                }
                
                seedDefaultUsersSuccess = true;
                
                // 3.5. Seed Public IT Courses
                List<ClassRoom> existingCourses = em.createQuery("SELECT c FROM ClassRoom c WHERE c.className LIKE '%IT%' OR c.className LIKE '%Web%'", ClassRoom.class).getResultList();
                if (existingCourses.isEmpty()) {
                    String[] courseNames = {
                        "[IT] Lập trình Java Web cơ bản với Servlet & JSP",
                        "[IT] Xây dựng Web hiện đại với ReactJS và Next.js",
                        "[IT] Cấu trúc Dữ liệu và Giải thuật cơ bản",
                        "[IT] Lập trình Python cho Data Science & AI"
                    };
                    String[] codes = {"JAVA101", "REACT202", "DSA404", "PYDS303"};
                    
                    for (int i = 0; i < courseNames.length; i++) {
                        ClassRoom course = ClassRoom.builder()
                                .teacher(teacherUser)
                                .className(courseNames[i])
                                .inviteCode(codes[i])
                                .isActive(true)
                                .createdAt(LocalDateTime.now())
                                .build();
                        em.persist(course);
                    }
                }
                
                // 4. Seed course progress ONLY if a user is logged in
                if (loggedInUser != null) {
                    
                    // Create completed course
                    ClassRoom completedClass = ClassRoom.builder()
                            .teacher(teacherUser)
                            .className("Lớp học Flipped Classroom Mẫu - F8")
                            .inviteCode("FC100")
                            .isActive(true)
                            .createdAt(LocalDateTime.now())
                            .build();
                    em.persist(completedClass);

                    // Add Student as Class Member
                    ClassMember cm1 = ClassMember.builder()
                            .classRoom(completedClass)
                            .student(loggedInUser)
                            .joinedAt(LocalDateTime.now())
                            .build();
                    em.persist(cm1);

                    // Add 3 Nodes (Video, Quiz, Milestone)
                    Node n1 = Node.builder()
                            .classRoom(completedClass)
                            .title("Bài 1: Giới thiệu mô hình lớp học đảo ngược (Flipped Classroom)")
                            .videoUrl("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
                            .orderIndex(1)
                            .nodeType(AppConstants.NODE_VIDEO)
                            .isActive(true)
                            .build();
                    em.persist(n1);

                    Node n2 = Node.builder()
                            .classRoom(completedClass)
                            .title("Bài kiểm tra kiến thức Flipped Classroom")
                            .orderIndex(2)
                            .nodeType(AppConstants.NODE_QUIZ)
                            .isActive(true)
                            .build();
                    em.persist(n2);

                    Node n3 = Node.builder()
                            .classRoom(completedClass)
                            .title("Báo cáo Milestone 1: Thiết kế kế hoạch tự học")
                            .orderIndex(3)
                            .nodeType(AppConstants.NODE_MILESTONE)
                            .isActive(true)
                            .build();
                    em.persist(n3);

                    // Add Completed Student Progress for all 3 nodes
                    StudentProgress sp1 = StudentProgress.builder()
                            .student(loggedInUser)
                            .node(n1)
                            .isCompleted(true)
                            .lastWatchedSec(180)
                            .totalBonus(10)
                            .updatedAt(LocalDateTime.now())
                            .build();
                    em.persist(sp1);

                    StudentProgress sp2 = StudentProgress.builder()
                            .student(loggedInUser)
                            .node(n2)
                            .isCompleted(true)
                            .lastWatchedSec(0)
                            .totalBonus(20)
                            .updatedAt(LocalDateTime.now())
                            .build();
                    em.persist(sp2);

                    StudentProgress sp3 = StudentProgress.builder()
                            .student(loggedInUser)
                            .node(n3)
                            .isCompleted(true)
                            .lastWatchedSec(0)
                            .totalBonus(30)
                            .updatedAt(LocalDateTime.now())
                            .build();
                    em.persist(sp3);

                    // Create in-progress course
                    ClassRoom ipClass = ClassRoom.builder()
                            .teacher(teacherUser)
                            .className("Lớp thiết kế Web UI/UX chuyên sâu")
                            .inviteCode("UIUX50")
                            .isActive(true)
                            .createdAt(LocalDateTime.now())
                            .build();
                    em.persist(ipClass);

                    // Add Student as Class Member
                    ClassMember cm2 = ClassMember.builder()
                            .classRoom(ipClass)
                            .student(loggedInUser)
                            .joinedAt(LocalDateTime.now())
                            .build();
                    em.persist(cm2);

                    // Add 3 Nodes
                    Node n4 = Node.builder()
                            .classRoom(ipClass)
                            .title("Bài 1: Thiết kế giao diện với Figma cơ bản")
                            .videoUrl("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
                            .orderIndex(1)
                            .nodeType(AppConstants.NODE_VIDEO)
                            .isActive(true)
                            .build();
                    em.persist(n4);

                    Node n5 = Node.builder()
                            .classRoom(ipClass)
                            .title("Bài 2: Hướng dẫn Grid Layout & Flexbox")
                            .videoUrl("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
                            .orderIndex(2)
                            .nodeType(AppConstants.NODE_VIDEO)
                            .isActive(true)
                            .build();
                    em.persist(n5);

                    Node n6 = Node.builder()
                            .classRoom(ipClass)
                            .title("Bài trắc nghiệm về kiến thức UI/UX")
                            .orderIndex(3)
                            .nodeType(AppConstants.NODE_QUIZ)
                            .isActive(true)
                            .build();
                    em.persist(n6);

                    // Complete ONLY 1 node out of 3
                    StudentProgress sp4 = StudentProgress.builder()
                            .student(loggedInUser)
                            .node(n4)
                            .isCompleted(true)
                            .lastWatchedSec(250)
                            .totalBonus(10)
                            .updatedAt(LocalDateTime.now())
                            .build();
                    em.persist(sp4);
                    
                    seedProgressSuccess = true;
                }
                
                tx.commit();
            } catch (Exception e) {
                if (tx.isActive()) tx.rollback();
                errorMessage = e.getMessage();
                e.printStackTrace();
            } finally {
                em.close();
            }
        %>

        <% if (errorMessage != null) { %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>
                <strong>Lỗi hệ thống khi nạp dữ liệu:</strong> <%= errorMessage %>
            </div>
        <% } %>

        <% if (seedDefaultUsersSuccess) { %>
            <div class="alert alert-success text-center mb-4">
                <i class="fas fa-check-circle fa-2x mb-2 d-block text-success"></i>
                <strong>Đã khởi tạo các tài khoản hệ thống thành công!</strong>
            </div>

            <div class="card bg-dark text-light p-3 mb-4">
                <h5 class="text-warning border-bottom border-secondary pb-2 mb-3">Tài khoản thử nghiệm sẵn có (Mật khẩu đã băm BCrypt)</h5>
                <table class="table table-dark table-hover table-sm mb-0">
                    <thead>
                        <tr>
                            <th>Vai trò</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Họ và Tên</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span class="badge bg-danger">ADMIN</span></td>
                            <td><code>admin_test</code></td>
                            <td><code>admin123</code></td>
                            <td><%= adminUser.getFullName() %></td>
                        </tr>
                        <tr>
                            <td><span class="badge bg-primary">TEACHER</span></td>
                            <td><code>teacher_test</code></td>
                            <td><code>teacher123</code></td>
                            <td><%= teacherUser.getFullName() %></td>
                        </tr>
                        <tr>
                            <td><span class="badge bg-success">STUDENT</span></td>
                            <td><code>student_test</code></td>
                            <td><code>student123</code></td>
                            <td><%= studentUser.getFullName() %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        <% } %>

        <% if (loggedInUser == null) { %>
            <div class="alert alert-info text-center">
                <i class="fas fa-info-circle me-2"></i> 
                <strong>Mẹo:</strong> Sau khi đăng nhập với vai trò <strong>Học viên</strong>, hãy truy cập lại trang này để tự động nạp tiến trình học và đăng ký các khóa học mẫu.
                <div class="mt-3">
                    <a href="login" class="btn btn-warning btn-sm"><i class="fas fa-sign-in-alt me-1"></i>Đi tới Đăng nhập</a>
                </div>
            </div>
        <% } else { %>
            <% if (seedProgressSuccess) { %>
                <div class="mb-4">
                    <h5>Dữ liệu học tập được nạp cho tài khoản: <span class="text-warning"><%= loggedInUser.getFullName() %></span></h5>
                    <ul class="list-group list-group-flush bg-secondary text-light rounded border border-light">
                        <li class="list-group-item bg-dark text-light d-flex justify-content-between align-items-center">
                            <strong>Lớp học Flipped Classroom Mẫu - F8</strong>
                            <span class="badge bg-success">100% Hoàn thành (3/3 bài học)</span>
                        </li>
                        <li class="list-group-item bg-dark text-light d-flex justify-content-between align-items-center">
                            <strong>Lớp thiết kế Web UI/UX chuyên sâu</strong>
                            <span class="badge bg-primary">33% Đang học (1/3 bài học)</span>
                        </li>
                    </ul>
                </div>

                <div class="d-grid gap-2">
                    <a href="my-courses" class="btn btn-warning"><i class="fas fa-book-reader me-2"></i>Xem Khóa học của tôi</a>
                    <a href="certificates" class="btn btn-success"><i class="fas fa-award me-2"></i>Xem Kho chứng chỉ</a>
                </div>
            <% } %>
        <% } %>
        
    </div>
</div>
</body>
</html>
