package com.dunnas.condominio.service;
import com.dunnas.condominio.dto.UsuarioDTO;
import com.dunnas.condominio.entity.*;
import com.dunnas.condominio.exception.BusinessException;
import com.dunnas.condominio.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service @RequiredArgsConstructor
public class UsuarioService {
    private final UsuarioRepository usuarioRepository;
    private final RoleRepository roleRepository;
    private final UnidadeRepository unidadeRepository;
    private final PasswordEncoder passwordEncoder;

    public List<Usuario> listarTodos() { return usuarioRepository.findAll(); }
    public Usuario buscarPorId(Long id) { return usuarioRepository.findById(id).orElseThrow(() -> new BusinessException("Usuario nao encontrado")); }

    @Transactional
    public Usuario criar(UsuarioDTO dto) {
        if (usuarioRepository.existsByEmail(dto.getEmail())) throw new BusinessException("Email ja cadastrado");
        Role role = roleRepository.findById(dto.getRoleId()).orElseThrow(() -> new BusinessException("Role invalida"));
        Usuario u = new Usuario();
        u.setNome(dto.getNome()); u.setEmail(dto.getEmail());
        u.setSenha(passwordEncoder.encode(dto.getSenha()));
        u.setRole(role); u.setAtivo(dto.getAtivo() != null ? dto.getAtivo() : true);
        return usuarioRepository.save(u);
    }

    @Transactional
    public Usuario atualizar(Long id, UsuarioDTO dto) {
        Usuario u = buscarPorId(id);
        if (!u.getEmail().equals(dto.getEmail()) && usuarioRepository.existsByEmail(dto.getEmail()))
            throw new BusinessException("Email ja em uso");
        Role role = roleRepository.findById(dto.getRoleId()).orElseThrow(() -> new BusinessException("Role invalida"));
        u.setNome(dto.getNome()); u.setEmail(dto.getEmail()); u.setRole(role);
        u.setAtivo(dto.getAtivo() != null ? dto.getAtivo() : u.getAtivo());
        if (dto.getSenha() != null && !dto.getSenha().isBlank())
            u.setSenha(passwordEncoder.encode(dto.getSenha()));
        return usuarioRepository.save(u);
    }

    @Transactional
    public void vincularUnidade(Long usuarioId, Long unidadeId) {
        Usuario u = buscarPorId(usuarioId);
        if (!u.isMorador()) throw new BusinessException("Apenas moradores podem ser vinculados a unidades");
        Unidade un = unidadeRepository.findById(unidadeId).orElseThrow(() -> new BusinessException("Unidade nao encontrada"));
        u.getUnidades().add(un); usuarioRepository.save(u);
    }

    @Transactional
    public void desvincularUnidade(Long usuarioId, Long unidadeId) {
        Usuario u = buscarPorId(usuarioId);
        u.getUnidades().removeIf(un -> un.getId().equals(unidadeId));
        usuarioRepository.save(u);
    }

    @Transactional
    public void alternarAtivo(Long id) {
        Usuario u = buscarPorId(id); u.setAtivo(!u.getAtivo()); usuarioRepository.save(u);
    }
}
