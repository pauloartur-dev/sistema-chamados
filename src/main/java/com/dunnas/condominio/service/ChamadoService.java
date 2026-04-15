package com.dunnas.condominio.service;

import com.dunnas.condominio.dto.ChamadoDTO;
import com.dunnas.condominio.entity.*;
import com.dunnas.condominio.exception.AcessoNegadoException;
import com.dunnas.condominio.exception.BusinessException;
import com.dunnas.condominio.repository.*;
import com.dunnas.condominio.security.UsuarioPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service @RequiredArgsConstructor
public class ChamadoService {
    private final ChamadoRepository chamadoRepository;
    private final UnidadeRepository unidadeRepository;
    private final TipoChamadoRepository tipoChamadoRepository;
    private final StatusChamadoRepository statusChamadoRepository;
    private final UsuarioRepository usuarioRepository;
    private final ComentarioRepository comentarioRepository;
    private final AnexoRepository anexoRepository;

    @Value("${app.upload.dir:uploads}") private String uploadDir;

    @Transactional(readOnly=true)
    public List<Chamado> listarParaUsuario(UsuarioPrincipal principal) {
        Usuario u = buscarUsuario(principal.getId());
        if (u.isAdministrador() || u.isColaborador()) return chamadoRepository.findAllComDetalhes();
        return chamadoRepository.findByMoradorId(u.getId());
    }

    @Transactional(readOnly=true)
    public Chamado buscarPorId(Long id, UsuarioPrincipal principal) {
        Chamado c = chamadoRepository.findByIdComDetalhes(id).orElseThrow(() -> new BusinessException("Chamado nao encontrado"));
        verificarAcesso(c, principal);
        return c;
    }

    @Transactional
    public Chamado abrir(ChamadoDTO dto, UsuarioPrincipal principal) {
        Usuario usuario = buscarUsuario(principal.getId());
        Unidade unidade = unidadeRepository.findById(dto.getUnidadeId()).orElseThrow(() -> new BusinessException("Unidade nao encontrada"));
        if (usuario.isMorador() && !usuario.getUnidades().contains(unidade))
            throw new AcessoNegadoException("Voce nao esta vinculado a essa unidade");
        TipoChamado tipo = tipoChamadoRepository.findById(dto.getTipoId()).orElseThrow(() -> new BusinessException("Tipo nao encontrado"));
        StatusChamado status = statusChamadoRepository.findByPadraoTrue().orElseThrow(() -> new BusinessException("Nenhum status padrao configurado"));
        Chamado c = new Chamado();
        c.setTitulo(dto.getTitulo()); c.setDescricao(dto.getDescricao());
        c.setUnidade(unidade); c.setTipo(tipo); c.setStatus(status);
        c.setAbertoPor(usuario); c.setPrazoLimite(LocalDateTime.now().plusHours(tipo.getSlaHoras()));
        Chamado salvo = chamadoRepository.save(c);
        if (dto.getAnexos() != null) dto.getAnexos().stream().filter(a -> !a.isEmpty()).forEach(a -> salvarAnexo(salvo, a));
        registrarHistorico(salvo, null, status, usuario, "Chamado aberto");
        return salvo;
    }

    @Transactional
    public Chamado atualizarStatus(Long chamadoId, Long novoStatusId, String obs, UsuarioPrincipal principal) {
        Chamado c = chamadoRepository.findByIdComDetalhes(chamadoId).orElseThrow(() -> new BusinessException("Chamado nao encontrado"));
        Usuario u = buscarUsuario(principal.getId());
        if (u.isMorador()) throw new AcessoNegadoException("Moradores nao podem alterar status");
        StatusChamado anterior = c.getStatus();
        StatusChamado novo = statusChamadoRepository.findById(novoStatusId).orElseThrow(() -> new BusinessException("Status nao encontrado"));
        c.setStatus(novo);
        if (novo.getFinalStatus()) c.setConcluidoEm(LocalDateTime.now());
        else c.setConcluidoEm(null);
        registrarHistorico(c, anterior, novo, u, obs);
        return chamadoRepository.save(c);
    }

    @Transactional
    public Comentario adicionarComentario(Long chamadoId, String conteudo, UsuarioPrincipal principal) {
        Chamado c = chamadoRepository.findByIdComDetalhes(chamadoId).orElseThrow(() -> new BusinessException("Chamado nao encontrado"));
        verificarAcesso(c, principal);
        Usuario u = buscarUsuario(principal.getId());
        Comentario cm = new Comentario();
        cm.setChamado(c); cm.setAutor(u); cm.setConteudo(conteudo.trim());
        return comentarioRepository.save(cm);
    }

    private void verificarAcesso(Chamado c, UsuarioPrincipal principal) {
        Usuario u = buscarUsuario(principal.getId());
        if (u.isAdministrador() || u.isColaborador()) return;
        boolean temAcesso = u.getUnidades().stream().anyMatch(un -> un.getId().equals(c.getUnidade().getId()));
        if (!temAcesso) throw new AcessoNegadoException("Acesso negado ao chamado");
    }

    private void registrarHistorico(Chamado c, StatusChamado anterior, StatusChamado novo, Usuario u, String obs) {
        HistoricoStatus h = new HistoricoStatus();
        h.setChamado(c); h.setStatusAnterior(anterior); h.setStatusNovo(novo); h.setAlteradoPor(u); h.setObservacao(obs);
        c.getHistorico().add(h);
    }

    private void salvarAnexo(Chamado c, MultipartFile arquivo) {
        try {
            Path dir = Paths.get(uploadDir, "chamados", c.getId().toString());
            Files.createDirectories(dir);
            String nome = UUID.randomUUID() + "_" + arquivo.getOriginalFilename();
            Files.copy(arquivo.getInputStream(), dir.resolve(nome), StandardCopyOption.REPLACE_EXISTING);
            Anexo a = new Anexo(); a.setChamado(c); a.setNome(arquivo.getOriginalFilename());
            a.setCaminho(dir.resolve(nome).toString()); a.setTamanho(arquivo.getSize()); a.setTipoMime(arquivo.getContentType());
            anexoRepository.save(a);
        } catch (IOException e) { throw new BusinessException("Erro ao salvar anexo"); }
    }

    private Usuario buscarUsuario(Long id) { return usuarioRepository.findById(id).orElseThrow(() -> new BusinessException("Usuario nao encontrado")); }
}
