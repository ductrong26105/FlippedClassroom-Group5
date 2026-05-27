package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "StudentQuestions")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class StudentQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "QuestionID")
    private int questionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ClassID", nullable = false)
    private ClassRoom classRoom;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "StudentID", nullable = false)
    private User student;

    @Column(name = "TopicTitle", nullable = false, length = 200)
    private String topicTitle;

    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "Upvotes", nullable = false)
    private int upvotes;

    @Column(name = "IsResolved", nullable = false)
    private boolean isResolved;

    @Column(name = "CreatedAt", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        upvotes = 0;
        isResolved = false;
    }
}
