INSERT INTO roles (nome) VALUES ('ADMINISTRADOR'), ('COLABORADOR'), ('MORADOR')
ON CONFLICT (nome) DO NOTHING;

INSERT INTO status_chamados (titulo, padrao, finalstatus, ordem) VALUES
    ('Aberto',       TRUE,  FALSE, 1),
    ('Em Andamento', FALSE, FALSE, 2),
    ('Aguardando',   FALSE, FALSE, 3),
    ('Resolvido',    FALSE, TRUE,  4),
    ('Cancelado',    FALSE, TRUE,  5)
ON CONFLICT (titulo) DO NOTHING;

INSERT INTO tipos_chamados (titulo, sla_horas) VALUES
    ('Manutencao Eletrica', 48),
    ('Manutencao Hidraulica', 24),
    ('Limpeza e Conservacao', 8),
    ('Seguranca', 4),
    ('Outros', 96)
ON CONFLICT (titulo) DO NOTHING;

-- Senha: Admin@123 (BCrypt cost 10)
INSERT INTO usuarios (nome, email, senha, role_id) VALUES
    ('Administrador', 'admin@condominio.com',
     '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
     (SELECT id FROM roles WHERE nome = 'ADMINISTRADOR'))
ON CONFLICT (email) DO NOTHING;
