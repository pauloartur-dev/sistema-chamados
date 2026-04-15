package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDateTime;

@Entity @Table(name="historico_status")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode(of="id")
public class HistoricoStatus {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @ManyToOne(fetch=FetchType.LAZY) @JoinColumn(name="chamado_id", nullable=false) private Chamado chamado;
    @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="status_anterior") private StatusChamado statusAnterior;
    @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="status_novo", nullable=false) private StatusChamado statusNovo;
    @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="alterado_por_id", nullable=false) private Usuario alteradoPor;
    @CreationTimestamp @Column(name="alterado_em", updatable=false) private LocalDateTime alteradoEm;
    @Column(length=500) private String observacao;
}
