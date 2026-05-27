package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "LiveSessions")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class LiveSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SessionID")
    private int sessionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ClassID", nullable = false)
    private ClassRoom classRoom;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TeacherID", nullable = false)
    private User teacher;

    @Column(name = "StartedAt", nullable = false, updatable = false)
    private LocalDateTime startedAt;

    @Column(name = "EndedAt")
    private LocalDateTime endedAt;

    @PrePersist
    protected void onCreate() {
        if (startedAt == null) {
            startedAt = LocalDateTime.now();
        }
    }
}
