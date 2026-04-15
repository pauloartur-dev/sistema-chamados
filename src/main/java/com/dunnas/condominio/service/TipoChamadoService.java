package com.dunnas.condominio.service;
import com.dunnas.condominio.entity.TipoChamado;
import com.dunnas.condominio.exception.BusinessException;
import com.dunnas.condominio.repository.TipoChamadoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @RequiredArgsConstructor
public class TipoChamadoService {
    private final TipoChamadoRepository repository;
    public List<TipoChamado> listarAtivos() { return repository.findByAtivoTrueOrderByTituloAsc(); }
    public List<TipoChamado> listarTodos() { return repository.findAll(); }
    public TipoChamado buscarPorId(Long id) { return repository.findById(id).orElseThrow(() -> new BusinessException("Tipo nao encontrado")); }
    @Transactional
    public TipoChamado salvar(TipoChamado t) {
        if (t.getId() == null && repository.existsByTitulo(t.getTitulo())) throw new BusinessException("Ja existe tipo com esse titulo");
        return repository.save(t);
    }
    @Transactional
    public void alternarAtivo(Long id) { TipoChamado t = buscarPorId(id); t.setAtivo(!t.getAtivo()); repository.save(t); }
}
