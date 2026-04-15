package com.dunnas.condominio.service;
import com.dunnas.condominio.entity.StatusChamado;
import com.dunnas.condominio.exception.BusinessException;
import com.dunnas.condominio.repository.StatusChamadoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @RequiredArgsConstructor
public class StatusChamadoService {
    private final StatusChamadoRepository repository;
    public List<StatusChamado> listarTodos() { return repository.findAllByOrderByOrdemAsc(); }
    public StatusChamado buscarPorId(Long id) { return repository.findById(id).orElseThrow(() -> new BusinessException("Status nao encontrado")); }
    @Transactional
    public StatusChamado salvar(StatusChamado s) {
        if (Boolean.TRUE.equals(s.getPadrao())) {
            repository.findByPadraoTrue().ifPresent(existing -> { if (!existing.getId().equals(s.getId())) { existing.setPadrao(false); repository.save(existing); } });
        }
        return repository.save(s);
    }
    @Transactional
    public void excluir(Long id) {
        StatusChamado s = buscarPorId(id);
        if (Boolean.TRUE.equals(s.getPadrao())) throw new BusinessException("Nao e possivel excluir o status padrao");
        repository.delete(s);
    }
}
