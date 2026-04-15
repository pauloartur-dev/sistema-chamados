package com.dunnas.condominio.dto;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@Data
public class ChamadoDTO {
    private Long id;
    @NotBlank @Size(max=200) private String titulo;
    @NotBlank private String descricao;
    @NotNull private Long unidadeId;
    @NotNull private Long tipoId;
    private Long statusId;
    private List<MultipartFile> anexos;
}
