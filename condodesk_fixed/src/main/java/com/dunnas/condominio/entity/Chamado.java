package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity @Table(name="chamados")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode(of="id")
public class Chamado {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @Column(nullable=false, length=200) private String titulo;
    @Column(nullable=false, columnDefinition="TEXT") private String descricao;
    @ManyToOne(fetch=FetchType.LAZY) @JoinColumn(name="unidade_id", nullable=false) private Unidade unidade;
    @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="tipo_id", nullable=false) private TipoChamado tipo;
    @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="status_id", nullable=false) private StatusChamado status;
    @ManyToOne(fetch=FetchType.LAZY) @JoinColumn(name="aberto_por_id", nullable=false) private Usuario abertoPor;
    @CreationTimestamp @Column(name="aberto_em", updatable=false) private LocalDateTime abertoEm;
    @UpdateTimestamp @Column(name="atualizado_em") private LocalDateTime atualizadoEm;
    @Column(name="concluido_em") private LocalDateTime concluidoEm;
    @Column(name="prazo_limite", nullable=false) private LocalDateTime prazoLimite;
    @OneToMany(mappedBy="chamado", cascade=CascadeType.ALL, orphanRemoval=true)
    @OrderBy("criadoEm ASC") private List<Comentario> comentarios = new ArrayList<>();
    @OneToMany(mappedBy="chamado", cascade=CascadeType.ALL, orphanRemoval=true)
    private List<Anexo> anexos = new ArrayList<>();
    @OneToMany(mappedBy="chamado", cascade=CascadeType.ALL, orphanRemoval=true)
    @OrderBy("alteradoEm DESC") private List<HistoricoStatus> historico = new ArrayList<>();
    public boolean isAtrasado() { return concluidoEm == null && prazoLimite != null && LocalDateTime.now().isAfter(prazoLimite); }
    public boolean isConcluido() { return status != null && status.getFinalStatus() && concluidoEm != null; }
}
