package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "Classes")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class ClassRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ClassID")
    private int classId;

    @Column(name = "ClassName", nullable = false, length = 100)
    private String className;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TeacherID", nullable = false)
    private User teacher;

    @Column(name = "InviteCode", nullable = false, length = 10, unique = true)
    private String inviteCode;

    @Column(name = "IsActive", nullable = false)
    private boolean isActive;

    @Column(name = "CreatedAt", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        isActive = true;
    }
}
