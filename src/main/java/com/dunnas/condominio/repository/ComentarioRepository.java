package com.dunnas.condominio.repository;
import com.dunnas.condominio.entity.Comentario;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface ComentarioRepository extends JpaRepository<Comentario, Long> {
    List<Comentario> findByChamadoIdOrderByCriadoEmAsc(Long chamadoId);
}
