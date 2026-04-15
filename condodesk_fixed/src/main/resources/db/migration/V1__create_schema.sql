CREATE TABLE roles (
    id   BIGSERIAL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    id            BIGSERIAL PRIMARY KEY,
    nome          VARCHAR(150) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    senha         VARCHAR(255) NOT NULL,
    role_id       BIGINT NOT NULL REFERENCES roles(id),
    ativo         BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em     TIMESTAMP NOT NULL DEFAULT NOW(),
    atualizado_em TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE blocos (
    id             BIGSERIAL PRIMARY KEY,
    identificacao  VARCHAR(50) NOT NULL UNIQUE,
    qtd_andares    INT NOT NULL CHECK (qtd_andares > 0),
    apts_por_andar INT NOT NULL CHECK (apts_por_andar > 0),
    descricao      VARCHAR(255),
    criado_em      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE unidades (
    id            BIGSERIAL PRIMARY KEY,
    bloco_id      BIGINT NOT NULL REFERENCES blocos(id) ON DELETE CASCADE,
    identificacao VARCHAR(20) NOT NULL,
    andar         INT NOT NULL,
    numero        INT NOT NULL,
    UNIQUE (bloco_id, identificacao)
);

CREATE TABLE usuario_unidades (
    id           BIGSERIAL PRIMARY KEY,
    usuario_id   BIGINT NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    unidade_id   BIGINT NOT NULL REFERENCES unidades(id) ON DELETE CASCADE,
    vinculado_em TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (usuario_id, unidade_id)
);

CREATE TABLE status_chamados (
    id        BIGSERIAL PRIMARY KEY,
    titulo    VARCHAR(80) NOT NULL UNIQUE,
    padrao    BOOLEAN NOT NULL DEFAULT FALSE,
    finalstatus BOOLEAN NOT NULL DEFAULT FALSE,
    ordem     INT NOT NULL DEFAULT 0
);

CREATE TABLE tipos_chamados (
    id        BIGSERIAL PRIMARY KEY,
    titulo    VARCHAR(100) NOT NULL UNIQUE,
    sla_horas INT NOT NULL CHECK (sla_horas > 0),
    ativo     BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE chamados (
    id            BIGSERIAL PRIMARY KEY,
    titulo        VARCHAR(200) NOT NULL,
    descricao     TEXT NOT NULL,
    unidade_id    BIGINT NOT NULL REFERENCES unidades(id),
    tipo_id       BIGINT NOT NULL REFERENCES tipos_chamados(id),
    status_id     BIGINT NOT NULL REFERENCES status_chamados(id),
    aberto_por_id BIGINT NOT NULL REFERENCES usuarios(id),
    aberto_em     TIMESTAMP NOT NULL DEFAULT NOW(),
    atualizado_em TIMESTAMP NOT NULL DEFAULT NOW(),
    concluido_em  TIMESTAMP,
    prazo_limite  TIMESTAMP NOT NULL
);

CREATE TABLE anexos (
    id         BIGSERIAL PRIMARY KEY,
    chamado_id BIGINT NOT NULL REFERENCES chamados(id) ON DELETE CASCADE,
    nome       VARCHAR(255) NOT NULL,
    caminho    VARCHAR(500) NOT NULL,
    tamanho    BIGINT NOT NULL,
    tipo_mime  VARCHAR(100),
    enviado_em TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE comentarios (
    id         BIGSERIAL PRIMARY KEY,
    chamado_id BIGINT NOT NULL REFERENCES chamados(id) ON DELETE CASCADE,
    autor_id   BIGINT NOT NULL REFERENCES usuarios(id),
    conteudo   TEXT NOT NULL,
    criado_em  TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE historico_status (
    id              BIGSERIAL PRIMARY KEY,
    chamado_id      BIGINT NOT NULL REFERENCES chamados(id) ON DELETE CASCADE,
    status_anterior BIGINT REFERENCES status_chamados(id),
    status_novo     BIGINT NOT NULL REFERENCES status_chamados(id),
    alterado_por_id BIGINT NOT NULL REFERENCES usuarios(id),
    alterado_em     TIMESTAMP NOT NULL DEFAULT NOW(),
    observacao      VARCHAR(500)
);

CREATE INDEX idx_chamados_status   ON chamados(status_id);
CREATE INDEX idx_chamados_unidade  ON chamados(unidade_id);
CREATE INDEX idx_chamados_aberto   ON chamados(aberto_por_id);
CREATE INDEX idx_comentarios       ON comentarios(chamado_id);
CREATE INDEX idx_usuario_unidades  ON usuario_unidades(usuario_id);
CREATE INDEX idx_unidades_bloco    ON unidades(bloco_id);
