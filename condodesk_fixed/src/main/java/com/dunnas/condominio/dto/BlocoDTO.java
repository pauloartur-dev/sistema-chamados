package com.dunnas.condominio.dto;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class BlocoDTO {
    private Long id;
    @NotBlank @Size(max=50) private String identificacao;
    @NotNull @Min(1) @Max(100) private Integer qtdAndares;
    @NotNull @Min(1) @Max(50)  private Integer aptsPorAndar;
    private String descricao;
}
