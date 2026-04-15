package com.dunnas.condominio.security;
import com.dunnas.condominio.entity.Usuario;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Collection;
import java.util.List;

@Getter
public class UsuarioPrincipal implements UserDetails {
    private final Usuario usuario;
    public UsuarioPrincipal(Usuario u) { this.usuario = u; }
    public Long getId() { return usuario.getId(); }
    public String getNome() { return usuario.getNome(); }
    public String getRoleNome() { return usuario.getRole().getNome(); }
    @Override public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_" + usuario.getRole().getNome()));
    }
    @Override public String getPassword() { return usuario.getSenha(); }
    @Override public String getUsername() { return usuario.getEmail(); }
    @Override public boolean isAccountNonExpired() { return true; }
    @Override public boolean isAccountNonLocked() { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled() { return usuario.getAtivo(); }
}
