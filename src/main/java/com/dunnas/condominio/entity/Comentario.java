package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDateTime;

@Entity @Table(name="comentarios")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode(of="id")
public class Comentario {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @ManyToOne(fetch=FetchType.LAZY) @JoinColumn(name="chamado_id", nullable=false) private Chamado chamado;
    @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="autor_id", nullable=false) private Usuario autor;
    @Column(nullable=false, columnDefinition="TEXT") private String conteudo;
    @CreationTimestamp @Column(name="criado_em", updatable=false) private LocalDateTime criadoEm;
}
