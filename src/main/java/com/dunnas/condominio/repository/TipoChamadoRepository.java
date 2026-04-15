package com.dunnas.condominio.repository;
import com.dunnas.condominio.entity.TipoChamado;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface TipoChamadoRepository extends JpaRepository<TipoChamado, Long> {
    List<TipoChamado> findByAtivoTrueOrderByTituloAsc();
    boolean existsByTitulo(String titulo);
}
