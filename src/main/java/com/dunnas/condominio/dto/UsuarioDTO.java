package com.dunnas.condominio.dto;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class UsuarioDTO {
    private Long id;
    @NotBlank @Size(min=3, max=150) private String nome;
    @NotBlank @Email private String email;
    @Size(min=6, max=100) private String senha;
    @NotNull private Long roleId;
    private Boolean ativo = true;
}
