package com.dunnas.condominio.repository;
import com.dunnas.condominio.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.util.Optional;
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Optional<Usuario> findByEmail(String email);
    boolean existsByEmail(String email);
    List<Usuario> findByAtivoTrue();
    @Query("SELECT u FROM Usuario u JOIN u.unidades un WHERE un.id = :uid")
    List<Usuario> findByUnidadeId(@Param("uid") Long unidadeId);
}
