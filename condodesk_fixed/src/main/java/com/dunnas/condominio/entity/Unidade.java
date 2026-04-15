package com.dunnas.condominio.entity;
import jakarta.persistence.*;
import lombok.*;
import java.util.HashSet;
import java.util.Set;

@Entity @Table(name="unidades", uniqueConstraints=@UniqueConstraint(columnNames={"bloco_id","identificacao"}))
@Getter @Setter @NoArgsConstructor @EqualsAndHashCode(of="id")
public class Unidade {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
    @ManyToOne(fetch=FetchType.LAZY) @JoinColumn(name="bloco_id", nullable=false) private Bloco bloco;
    @Column(nullable=false, length=20) private String identificacao;
    @Column(nullable=false) private Integer andar;
    @Column(nullable=false) private Integer numero;
    @ManyToMany(mappedBy="unidades", fetch=FetchType.LAZY) private Set<Usuario> moradores = new HashSet<>();
}
