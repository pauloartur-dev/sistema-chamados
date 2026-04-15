package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;

@Entity @Table(name="status_chamados")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @EqualsAndHashCode(of="id")
public class StatusChamado {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @Column(nullable=false, unique=true, length=80) private String titulo;
    @Column(nullable=false) private Boolean padrao = false;
    @Column(name="finalstatus", nullable=false) private Boolean finalStatus = false;
    @Column(nullable=false) private Integer ordem = 0;
}
