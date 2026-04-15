package com.dunnas.condominio.controller;

import com.dunnas.condominio.repository.UsuarioRepository;
import com.dunnas.condominio.security.UsuarioPrincipal;
import com.dunnas.condominio.service.ChamadoService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller @RequiredArgsConstructor
public class DashboardController {
    private final ChamadoService chamadoService;
    private final UsuarioRepository usuarioRepository;

    @GetMapping({"/", "/dashboard"})
    public String dashboard(@AuthenticationPrincipal UsuarioPrincipal principal, Model model) {
        // Removido: if (principal == null) return "redirect:/login";
        // O Spring Security já protege este endpoint via SecurityConfig (.anyRequest().authenticated())
        // Se chegar aqui sem autenticação, o Spring Security redireciona antes — sem loop.
        var chamados = chamadoService.listarParaUsuario(principal);
        model.addAttribute("chamados", chamados);
        model.addAttribute("totalChamados", chamados.size());
        model.addAttribute("chamadosAbertos", chamados.stream().filter(c -> !c.isConcluido()).count());
        model.addAttribute("chamadosAtrasados", chamados.stream().filter(c -> c.isAtrasado()).count());
        if ("ADMINISTRADOR".equals(principal.getRoleNome()))
            model.addAttribute("totalUsuarios", usuarioRepository.count());
        return "dashboard";
    }
}
