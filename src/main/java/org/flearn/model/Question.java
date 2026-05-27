package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Questions")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "QuestionID")
    private int questionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NodeID")
    private Node node;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ClassID")
    private ClassRoom classRoom;

    @Column(name = "QuestionText", nullable = false, columnDefinition = "NVARCHAR(MAX)")
    private String questionText;

    /**
     * 0 = Multiple Choice, 1 = True/False, 2 = Essay
     */
    @Column(name = "QuestionType", nullable = false)
    private byte questionType;

    @Column(name = "PopUpTime")
    private Integer popUpTime;

    @Column(name = "BonusPoint", nullable = false)
    private int bonusPoint;

    /**
     * 0 = Node-level, 1 = Class-level, 2 = Survey
     */
    @Column(name = "Scope", nullable = false)
    private byte scope;

    @Column(name = "IsActive", nullable = false)
    private boolean isActive;

    @PrePersist
    protected void onCreate() {
        isActive = true;
    }
}
