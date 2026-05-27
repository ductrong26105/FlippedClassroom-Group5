package org.flearn.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Nodes")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Node {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "NodeID")
    private int nodeId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ClassID", nullable = false)
    private ClassRoom classRoom;

    @Column(name = "Title", nullable = false, length = 200)
    private String title;

    @Column(name = "VideoURL", length = 500)
    private String videoUrl;

    @Column(name = "OrderIndex", nullable = false)
    private int orderIndex;

    /**
     * 0 = Video, 1 = Quiz, 2 = Milestone
     */
    @Column(name = "NodeType", nullable = false)
    private byte nodeType;

    @Column(name = "UnlockAt")
    private java.time.LocalDateTime unlockAt;

    @Column(name = "IsActive", nullable = false)
    private boolean isActive;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PrerequisiteNodeID")
    private Node prerequisiteNode;

    @PrePersist
    protected void onCreate() {
        isActive = true;
    }
}
