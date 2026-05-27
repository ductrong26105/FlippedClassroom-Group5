package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "StudentAnswers")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class StudentAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "StudentID", nullable = false)
    private User student;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "QuestionID", nullable = false)
    private Question question;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SelectedAnswerID")
    private Answer selectedAnswer;

    @Column(name = "EssayText", columnDefinition = "NVARCHAR(MAX)")
    private String essayText;

    @Column(name = "IsCorrect", nullable = false)
    private boolean isCorrect;

    /**
     * 0 = Self-paced, 1 = Live session
     */
    @Column(name = "Context", nullable = false)
    private byte context;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SessionID")
    private LiveSession session;

    @Column(name = "CreatedAt", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}
