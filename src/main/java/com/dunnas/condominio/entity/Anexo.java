package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDateTime;

@Entity @Table(name="anexos")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode(of="id")
public class Anexo {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @ManyToOne(fetch=FetchType.LAZY) @JoinColumn(name="chamado_id", nullable=false) private Chamado chamado;
    @Column(nullable=false, length=255) private String nome;
    @Column(nullable=false, length=500) private String caminho;
    @Column(nullable=false) private Long tamanho;
    @Column(name="tipo_mime", length=100) private String tipoMime;
    @CreationTimestamp @Column(name="enviado_em", updatable=false) private LocalDateTime enviadoEm;
}
