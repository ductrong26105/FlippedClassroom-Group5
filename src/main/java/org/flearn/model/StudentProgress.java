package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "StudentProgress",
       uniqueConstraints = @UniqueConstraint(columnNames = {"StudentID", "NodeID"}))
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class StudentProgress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProgressID")
    private int progressId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "StudentID", nullable = false)
    private User student;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NodeID", nullable = false)
    private Node node;

    @Column(name = "IsCompleted", nullable = false)
    private boolean isCompleted;

    @Column(name = "LastWatchedSec", nullable = false)
    private int lastWatchedSec;

    @Column(name = "TotalBonus", nullable = false)
    private int totalBonus;

    @Column(name = "UpdatedAt", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
