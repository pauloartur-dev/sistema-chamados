package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDateTime;

@Entity @Table(name="tipos_chamados")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode(of="id")
public class TipoChamado {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @Column(nullable=false, unique=true, length=100) private String titulo;
    @Column(name="sla_horas", nullable=false) private Integer slaHoras;
    @Column(nullable=false) private Boolean ativo = true;
    @CreationTimestamp @Column(name="criado_em", updatable=false) private LocalDateTime criadoEm;
}
