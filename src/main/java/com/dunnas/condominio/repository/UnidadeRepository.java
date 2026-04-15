package com.dunnas.condominio.repository;
import com.dunnas.condominio.entity.Unidade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
public interface UnidadeRepository extends JpaRepository<Unidade, Long> {
    List<Unidade> findByBlocoIdOrderByIdentificacaoAsc(Long blocoId);
    @Query("SELECT u FROM Unidade u JOIN u.moradores m WHERE m.id = :uid ORDER BY u.identificacao")
    List<Unidade> findByMoradorId(@Param("uid") Long usuarioId);
    @Query("SELECT u FROM Unidade u LEFT JOIN FETCH u.bloco ORDER BY u.bloco.identificacao, u.andar, u.numero")
    List<Unidade> findAllComBloco();
}
