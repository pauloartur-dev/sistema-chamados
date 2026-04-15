package com.dunnas.condominio.repository;
import com.dunnas.condominio.entity.StatusChamado;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
public interface StatusChamadoRepository extends JpaRepository<StatusChamado, Long> {
    Optional<StatusChamado> findByPadraoTrue();
    List<StatusChamado> findAllByOrderByOrdemAsc();
}
