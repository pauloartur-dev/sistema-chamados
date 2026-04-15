package com.dunnas.condominio.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuthController {

    @GetMapping("/login")
    public String login(HttpServletRequest request, Model model) {
        model.addAttribute("hasError", request.getParameter("error") != null);
        model.addAttribute("hasLogout", request.getParameter("logout") != null);
        model.addAttribute("hasDenied", request.getParameter("denied") != null);
        return "login";
    }

    // FIX: Endpoint dedicado para acesso negado
    // Evita loop: usuário autenticado sem permissão → /acesso-negado (em vez de /login)
    @GetMapping("/acesso-negado")
    public String acessoNegado() {
        return "shared/acesso-negado";
    }
}
