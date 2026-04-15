package com.dunnas.condominio.service;
import com.dunnas.condominio.dto.BlocoDTO;
import com.dunnas.condominio.entity.*;
import com.dunnas.condominio.exception.BusinessException;
import com.dunnas.condominio.repository.BlocoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @RequiredArgsConstructor
public class BlocoService {
    private final BlocoRepository blocoRepository;

    public List<Bloco> listarTodos() { return blocoRepository.findAllByOrderByIdentificacaoAsc(); }
    public Bloco buscarPorId(Long id) { return blocoRepository.findById(id).orElseThrow(() -> new BusinessException("Bloco nao encontrado")); }

    @Transactional
    public Bloco criar(BlocoDTO dto) {
        if (blocoRepository.existsByIdentificacao(dto.getIdentificacao().toUpperCase().trim()))
            throw new BusinessException("Ja existe bloco com essa identificacao");
        Bloco b = new Bloco();
        b.setIdentificacao(dto.getIdentificacao().toUpperCase().trim());
        b.setQtdAndares(dto.getQtdAndares());
        b.setAptsPorAndar(dto.getAptsPorAndar());
        b.setDescricao(dto.getDescricao());
        for (int andar = 1; andar <= b.getQtdAndares(); andar++) {
            for (int num = 1; num <= b.getAptsPorAndar(); num++) {
                Unidade u = new Unidade();
                u.setBloco(b); u.setAndar(andar); u.setNumero(num);
                u.setIdentificacao(String.format("%d%02d", andar, num));
                b.getUnidades().add(u);
            }
        }
        return blocoRepository.save(b);
    }

    @Transactional
    public void excluir(Long id) {
        Bloco b = buscarPorId(id);
        boolean temMoradores = b.getUnidades().stream().anyMatch(u -> !u.getMoradores().isEmpty());
        if (temMoradores) throw new BusinessException("Nao e possivel excluir: ha moradores vinculados");
        blocoRepository.delete(b);
    }
}
