package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Answers")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Answer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AnswerID")
    private int answerId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "QuestionID", nullable = false)
    private Question question;

    @Column(name = "AnswerText", nullable = false, columnDefinition = "NVARCHAR(MAX)")
    private String answerText;

    @Column(name = "IsCorrect", nullable = false)
    private boolean isCorrect;
}
