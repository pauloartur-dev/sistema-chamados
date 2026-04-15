package com.dunnas.condominio.controller;

import com.dunnas.condominio.dto.ChamadoDTO;
import com.dunnas.condominio.entity.Chamado;
import com.dunnas.condominio.repository.UnidadeRepository;
import com.dunnas.condominio.security.UsuarioPrincipal;
import com.dunnas.condominio.service.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller @RequestMapping("/chamados") @RequiredArgsConstructor
public class ChamadoController {
    private final ChamadoService chamadoService;
    private final TipoChamadoService tipoChamadoService;
    private final StatusChamadoService statusChamadoService;
    private final UsuarioService usuarioService;
    private final UnidadeRepository unidadeRepository;

    @GetMapping
    public String listar(@AuthenticationPrincipal UsuarioPrincipal principal,
                         @RequestParam(required=false) Long statusId,
                         @RequestParam(required=false) Long tipoId, Model model) {
        var chamados = chamadoService.listarParaUsuario(principal);
        if (statusId != null) chamados = chamados.stream().filter(c -> c.getStatus().getId().equals(statusId)).toList();
        if (tipoId != null)   chamados = chamados.stream().filter(c -> c.getTipo().getId().equals(tipoId)).toList();
        model.addAttribute("chamados", chamados);
        model.addAttribute("status", statusChamadoService.listarTodos());
        model.addAttribute("tipos", tipoChamadoService.listarAtivos());
        model.addAttribute("statusFiltro", statusId);
        model.addAttribute("tipoFiltro", tipoId);
        return "chamados/lista";
    }

    @GetMapping("/novo")
    public String formNovo(@AuthenticationPrincipal UsuarioPrincipal principal, Model model) {
        model.addAttribute("chamadoDTO", new ChamadoDTO());
        model.addAttribute("tipos", tipoChamadoService.listarAtivos());
        var usuario = usuarioService.buscarPorId(principal.getId());
        if (usuario.isMorador()) model.addAttribute("unidades", usuario.getUnidades());
        else model.addAttribute("unidades", unidadeRepository.findAllComBloco());
        return "chamados/form";
    }

    @PostMapping("/novo")
    public String criar(@Valid @ModelAttribute("chamadoDTO") ChamadoDTO dto, BindingResult result,
                        @AuthenticationPrincipal UsuarioPrincipal principal, Model model, RedirectAttributes ra) {
        if (result.hasErrors()) {
            model.addAttribute("tipos", tipoChamadoService.listarAtivos());
            model.addAttribute("unidades", usuarioService.buscarPorId(principal.getId()).getUnidades());
            return "chamados/form";
        }
        Chamado c = chamadoService.abrir(dto, principal);
        ra.addFlashAttribute("sucesso", "Chamado #" + c.getId() + " aberto com sucesso!");
        return "redirect:/chamados/" + c.getId();
    }

    @GetMapping("/{id}")
    public String detalhe(@PathVariable Long id, @AuthenticationPrincipal UsuarioPrincipal principal, Model model) {
        model.addAttribute("chamado", chamadoService.buscarPorId(id, principal));
        model.addAttribute("statusList", statusChamadoService.listarTodos());
        model.addAttribute("rolePrincipal", principal.getRoleNome());
        return "chamados/detalhe";
    }

    @PostMapping("/{id}/status")
    public String atualizarStatus(@PathVariable Long id, @RequestParam Long statusId,
                                  @RequestParam(required=false) String observacao,
                                  @AuthenticationPrincipal UsuarioPrincipal principal, RedirectAttributes ra) {
        chamadoService.atualizarStatus(id, statusId, observacao, principal);
        ra.addFlashAttribute("sucesso", "Status atualizado!");
        return "redirect:/chamados/" + id;
    }

    @PostMapping("/{id}/comentario")
    public String comentario(@PathVariable Long id, @RequestParam String conteudo,
                             @AuthenticationPrincipal UsuarioPrincipal principal, RedirectAttributes ra) {
        if (conteudo == null || conteudo.isBlank()) ra.addFlashAttribute("erro", "Comentario nao pode ser vazio.");
        else { chamadoService.adicionarComentario(id, conteudo, principal); ra.addFlashAttribute("sucesso", "Comentario adicionado!"); }
        return "redirect:/chamados/" + id;
    }
}
