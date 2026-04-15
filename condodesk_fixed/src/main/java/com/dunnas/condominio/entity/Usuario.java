package com.dunnas.condominio.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity @Table(name="usuarios")
@Getter @Setter @NoArgsConstructor
@EqualsAndHashCode(of="id")
public class Usuario {
    @Id @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    @Column(nullable=false, length=150)
    private String nome;
    @Column(nullable=false, unique=true, length=150)
    private String email;
    @Column(nullable=false, length=255)
    private String senha;
    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="role_id", nullable=false)
    private Role role;
    @Column(nullable=false)
    private Boolean ativo = true;
    @CreationTimestamp
    @Column(name="criado_em", updatable=false)
    private LocalDateTime criadoEm;
    @UpdateTimestamp
    @Column(name="atualizado_em")
    private LocalDateTime atualizadoEm;
    @ManyToMany(fetch=FetchType.LAZY)
    @JoinTable(name="usuario_unidades",
        joinColumns=@JoinColumn(name="usuario_id"),
        inverseJoinColumns=@JoinColumn(name="unidade_id"))
    private Set<Unidade> unidades = new HashSet<>();

    public boolean isAdministrador() { return role != null && "ADMINISTRADOR".equals(role.getNome()); }
    public boolean isColaborador()   { return role != null && "COLABORADOR".equals(role.getNome()); }
    public boolean isMorador()       { return role != null && "MORADOR".equals(role.getNome()); }
}
