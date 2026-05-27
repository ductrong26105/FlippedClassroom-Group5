package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "MilestoneAssignments",
       uniqueConstraints = @UniqueConstraint(columnNames = {"NodeID", "StudentID", "Role"}))
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class MilestoneAssignment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NodeID", nullable = false)
    private Node node;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "StudentID", nullable = false)
    private User student;

    /**
     * 0 = Member, 1 = Leader
     */
    @Column(name = "Role", nullable = false)
    private byte role;

    @Column(name = "IsCompleted", nullable = false)
    private boolean isCompleted;

    @Column(name = "UpdatedAt", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
