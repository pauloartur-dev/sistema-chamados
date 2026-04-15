package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity @Table(name="blocos")
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode(of="id")
public class Bloco {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @Column(nullable=false, unique=true, length=50) private String identificacao;
    @Column(name="qtd_andares", nullable=false) private Integer qtdAndares;
    @Column(name="apts_por_andar", nullable=false) private Integer aptsPorAndar;
    @Column(length=255) private String descricao;
    @CreationTimestamp @Column(name="criado_em", updatable=false) private LocalDateTime criadoEm;
    @OneToMany(mappedBy="bloco", cascade=CascadeType.ALL, orphanRemoval=true)
    private List<Unidade> unidades = new ArrayList<>();
    public int totalUnidades() { return qtdAndares * aptsPorAndar; }
}
