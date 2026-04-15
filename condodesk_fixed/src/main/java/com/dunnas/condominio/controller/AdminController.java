package com.dunnas.condominio.controller;

import com.dunnas.condominio.dto.BlocoDTO;
import com.dunnas.condominio.dto.UsuarioDTO;
import com.dunnas.condominio.entity.*;
import com.dunnas.condominio.repository.RoleRepository;
import com.dunnas.condominio.repository.UnidadeRepository;
import com.dunnas.condominio.service.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMINISTRADOR')")
@RequiredArgsConstructor
public class AdminController {

    private final UsuarioService usuarioService;
    private final BlocoService blocoService;
    private final TipoChamadoService tipoChamadoService;
    private final StatusChamadoService statusChamadoService;
    private final RoleRepository roleRepository;
    private final UnidadeRepository unidadeRepository;

    // ── Usuarios ──
    @GetMapping("/usuarios")
    public String usuarios(Model model) {
        model.addAttribute("usuarios", usuarioService.listarTodos());
        return "admin/usuarios/lista";
    }

    @GetMapping("/usuarios/novo")
    public String novoForm(Model model) {
        model.addAttribute("usuarioDTO", new UsuarioDTO());
        model.addAttribute("roles", roleRepository.findAll());
        return "admin/usuarios/form";
    }

    @PostMapping("/usuarios/novo")
    public String criar(@Valid @ModelAttribute UsuarioDTO dto, BindingResult result,
                        Model model, RedirectAttributes ra) {
        if (result.hasErrors()) { model.addAttribute("roles", roleRepository.findAll()); return "admin/usuarios/form"; }
        usuarioService.criar(dto);
        ra.addFlashAttribute("sucesso", "Usuario criado!");
        return "redirect:/admin/usuarios";
    }

    @GetMapping("/usuarios/{id}/editar")
    public String editarForm(@PathVariable Long id, Model model) {
        Usuario u = usuarioService.buscarPorId(id);
        UsuarioDTO dto = new UsuarioDTO();
        dto.setId(u.getId()); dto.setNome(u.getNome()); dto.setEmail(u.getEmail());
        dto.setRoleId(u.getRole().getId()); dto.setAtivo(u.getAtivo());
        model.addAttribute("usuarioDTO", dto);
        model.addAttribute("roles", roleRepository.findAll());
        model.addAttribute("unidades", u.getUnidades());
        model.addAttribute("todasUnidades", unidadeRepository.findAllComBloco());
        return "admin/usuarios/form";
    }

    @PostMapping("/usuarios/{id}/editar")
    public String editar(@PathVariable Long id, @Valid @ModelAttribute UsuarioDTO dto,
                         BindingResult result, Model model, RedirectAttributes ra) {
        if (result.hasErrors()) { model.addAttribute("roles", roleRepository.findAll()); return "admin/usuarios/form"; }
        usuarioService.atualizar(id, dto);
        ra.addFlashAttribute("sucesso", "Usuario atualizado!");
        return "redirect:/admin/usuarios";
    }

    @PostMapping("/usuarios/{id}/toggle")
    public String toggle(@PathVariable Long id, RedirectAttributes ra) {
        usuarioService.alternarAtivo(id);
        ra.addFlashAttribute("sucesso", "Status alterado!");
        return "redirect:/admin/usuarios";
    }

    @PostMapping("/usuarios/{uid}/vincular")
    public String vincular(@PathVariable Long uid, @RequestParam Long unidadeId, RedirectAttributes ra) {
        usuarioService.vincularUnidade(uid, unidadeId);
        ra.addFlashAttribute("sucesso", "Unidade vinculada!");
        return "redirect:/admin/usuarios/" + uid + "/editar";
    }

    @PostMapping("/usuarios/{uid}/desvincular/{unidadeId}")
    public String desvincular(@PathVariable Long uid, @PathVariable Long unidadeId, RedirectAttributes ra) {
        usuarioService.desvincularUnidade(uid, unidadeId);
        ra.addFlashAttribute("sucesso", "Unidade desvinculada!");
        return "redirect:/admin/usuarios/" + uid + "/editar";
    }

    // ── Blocos ──
    @GetMapping("/blocos")
    public String blocos(Model model) {
        model.addAttribute("blocos", blocoService.listarTodos());
        return "admin/blocos/lista";
    }

    @GetMapping("/blocos/novo")
    public String novoBlocoForm(Model model) {
        model.addAttribute("blocoDTO", new BlocoDTO());
        return "admin/blocos/form";
    }

    @PostMapping("/blocos/novo")
    public String criarBloco(@Valid @ModelAttribute BlocoDTO dto, BindingResult result,
                              Model model, RedirectAttributes ra) {
        if (result.hasErrors()) return "admin/blocos/form";
        blocoService.criar(dto);
        ra.addFlashAttribute("sucesso", "Bloco criado com unidades geradas!");
        return "redirect:/admin/blocos";
    }

    @PostMapping("/blocos/{id}/excluir")
    public String excluirBloco(@PathVariable Long id, RedirectAttributes ra) {
        blocoService.excluir(id);
        ra.addFlashAttribute("sucesso", "Bloco excluido!");
        return "redirect:/admin/blocos";
    }

    // ── Tipos ──
    @GetMapping("/tipos")
    public String tipos(Model model) {
        model.addAttribute("tipos", tipoChamadoService.listarTodos());
        model.addAttribute("novoTipo", new TipoChamado());
        return "admin/tipos/lista";
    }

    @PostMapping("/tipos/salvar")
    public String salvarTipo(@ModelAttribute TipoChamado tipo, RedirectAttributes ra) {
        tipoChamadoService.salvar(tipo);
        ra.addFlashAttribute("sucesso", "Tipo salvo!");
        return "redirect:/admin/tipos";
    }

    @PostMapping("/tipos/{id}/toggle")
    public String toggleTipo(@PathVariable Long id, RedirectAttributes ra) {
        tipoChamadoService.alternarAtivo(id);
        ra.addFlashAttribute("sucesso", "Tipo atualizado!");
        return "redirect:/admin/tipos";
    }

    // ── Status ──
    @GetMapping("/status")
    public String status(Model model) {
        model.addAttribute("statusList", statusChamadoService.listarTodos());
        model.addAttribute("novoStatus", new StatusChamado());
        return "admin/status/lista";
    }

    @PostMapping("/status/salvar")
    public String salvarStatus(@ModelAttribute StatusChamado status, RedirectAttributes ra) {
        statusChamadoService.salvar(status);
        ra.addFlashAttribute("sucesso", "Status salvo!");
        return "redirect:/admin/status";
    }

    @PostMapping("/status/{id}/excluir")
    public String excluirStatus(@PathVariable Long id, RedirectAttributes ra) {
        statusChamadoService.excluir(id);
        ra.addFlashAttribute("sucesso", "Status excluido!");
        return "redirect:/admin/status";
    }
}
