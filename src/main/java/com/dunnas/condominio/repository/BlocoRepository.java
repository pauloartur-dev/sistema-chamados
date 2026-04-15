package com.dunnas.condominio.repository;
import com.dunnas.condominio.entity.Bloco;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
public interface BlocoRepository extends JpaRepository<Bloco, Long> {
    boolean existsByIdentificacao(String id);
    Optional<Bloco> findByIdentificacao(String id);
    List<Bloco> findAllByOrderByIdentificacaoAsc();
}
