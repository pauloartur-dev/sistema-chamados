package com.dunnas.condominio.exception;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(BusinessException.class)
    public String handleBusiness(BusinessException ex, Model model) {
        model.addAttribute("erro", ex.getMessage());
        return "shared/erro";
    }
    @ExceptionHandler(AcessoNegadoException.class)
    public String handleAcesso(AcessoNegadoException ex, Model model) {
        model.addAttribute("erro", ex.getMessage());
        return "shared/acesso-negado";
    }
    @ExceptionHandler(Exception.class)
    public String handleGeneral(Exception ex, Model model) {
        model.addAttribute("erro", "Erro inesperado: " + ex.getMessage());
        return "shared/erro";
    }
}
