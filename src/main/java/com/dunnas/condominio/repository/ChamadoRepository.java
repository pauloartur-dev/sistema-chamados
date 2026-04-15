package com.dunnas.condominio.repository;
import com.dunnas.condominio.entity.Chamado;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.util.Optional;
public interface ChamadoRepository extends JpaRepository<Chamado, Long> {
    @Query("SELECT DISTINCT c FROM Chamado c JOIN FETCH c.unidade u JOIN FETCH u.bloco JOIN FETCH c.tipo JOIN FETCH c.status JOIN FETCH c.abertoPor ORDER BY c.abertoEm DESC")
    List<Chamado> findAllComDetalhes();
    @Query("SELECT c FROM Chamado c JOIN FETCH c.unidade u JOIN FETCH u.bloco JOIN FETCH c.tipo JOIN FETCH c.status JOIN FETCH c.abertoPor WHERE c.id = :id")
    Optional<Chamado> findByIdComDetalhes(@Param("id") Long id);
    @Query("SELECT DISTINCT c FROM Chamado c JOIN c.unidade u JOIN u.moradores m WHERE m.id = :mid ORDER BY c.abertoEm DESC")
    List<Chamado> findByMoradorId(@Param("mid") Long moradorId);
}
