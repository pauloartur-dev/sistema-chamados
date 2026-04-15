<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>CondoDesk — Acesso</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">
  <style>
    :root {
      --bg: #0d0d12;
      --surface: #16161f;
      --border: rgba(255,255,255,0.07);
      --accent: #6366f1;
      --accent2: #818cf8;
      --text: #f1f1f3;
      --muted: rgba(241,241,243,0.45);
      --danger: #f87171;
      --success: #4ade80;
    }
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    html, body { height: 100%; }
    body {
      font-family: 'DM Sans', sans-serif;
      background: var(--bg);
      color: var(--text);
      display: flex;
      min-height: 100vh;
      overflow: hidden;
    }

    /* Background grid */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image:
        linear-gradient(rgba(99,102,241,0.04) 1px, transparent 1px),
        linear-gradient(90deg, rgba(99,102,241,0.04) 1px, transparent 1px);
      background-size: 40px 40px;
      z-index: 0;
    }

    /* Glow blobs */
    .blob {
      position: fixed;
      border-radius: 50%;
      filter: blur(80px);
      opacity: 0.18;
      pointer-events: none;
      z-index: 0;
    }
    .blob-1 { width: 500px; height: 500px; background: #6366f1; top: -150px; right: -100px; animation: blobmove 8s ease-in-out infinite alternate; }
    .blob-2 { width: 400px; height: 400px; background: #8b5cf6; bottom: -100px; left: -100px; animation: blobmove 10s ease-in-out infinite alternate-reverse; }
    @keyframes blobmove { from { transform: translate(0,0) scale(1); } to { transform: translate(30px,20px) scale(1.05); } }

    /* Split layout */
    .left-panel {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 60px 80px;
      position: relative;
      z-index: 10;
    }
    .right-panel {
      width: 480px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 40px;
      position: relative;
      z-index: 10;
    }

    /* Left panel content */
    .logo-row {
      display: flex;
      align-items: center;
      gap: 14px;
      margin-bottom: 64px;
    }
    .logo-mark {
      width: 46px;
      height: 46px;
      background: var(--accent);
      border-radius: 13px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 22px;
      box-shadow: 0 0 32px rgba(99,102,241,0.5);
    }
    .logo-text {
      font-size: 20px;
      font-weight: 700;
      letter-spacing: -0.5px;
      color: var(--text);
    }
    .logo-text span { color: var(--accent2); }

    .hero-title {
      font-size: 52px;
      font-weight: 700;
      line-height: 1.08;
      letter-spacing: -2px;
      margin-bottom: 20px;
      color: var(--text);
    }
    .hero-title .highlight {
      background: linear-gradient(135deg, var(--accent), var(--accent2), #c084fc);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .hero-sub {
      font-size: 16px;
      color: var(--muted);
      line-height: 1.7;
      max-width: 380px;
      margin-bottom: 52px;
    }

    .features {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
    .feature-item {
      display: flex;
      align-items: center;
      gap: 14px;
    }
    .feature-dot {
      width: 8px;
      height: 8px;
      border-radius: 50%;
      background: var(--accent);
      box-shadow: 0 0 10px var(--accent);
      flex-shrink: 0;
    }
    .feature-text {
      font-size: 14px;
      color: rgba(241,241,243,0.6);
    }

    /* Divider */
    .divider {
      width: 1px;
      background: var(--border);
      align-self: stretch;
      margin: 60px 0;
      position: relative;
      z-index: 10;
    }

    /* Login card */
    .login-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 20px;
      padding: 42px 40px;
      width: 100%;
      max-width: 400px;
      position: relative;
      overflow: hidden;
      box-shadow: 0 30px 80px rgba(0,0,0,0.4), 0 0 0 1px rgba(99,102,241,0.1);
    }
    .login-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0;
      height: 1px;
      background: linear-gradient(90deg, transparent, var(--accent), transparent);
    }

    .card-heading {
      margin-bottom: 32px;
    }
    .card-heading h2 {
      font-size: 24px;
      font-weight: 700;
      letter-spacing: -0.5px;
      margin-bottom: 6px;
    }
    .card-heading p {
      font-size: 13.5px;
      color: var(--muted);
    }

    /* Alert */
    .alert {
      padding: 11px 14px;
      border-radius: 10px;
      font-size: 13px;
      margin-bottom: 22px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .alert-error {
      background: rgba(248,113,113,0.1);
      border: 1px solid rgba(248,113,113,0.25);
      color: var(--danger);
    }
    .alert-success {
      background: rgba(74,222,128,0.1);
      border: 1px solid rgba(74,222,128,0.2);
      color: var(--success);
    }

    /* Form */
    .field { margin-bottom: 18px; }
    .field label {
      display: block;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.8px;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 8px;
    }
    .field input {
      width: 100%;
      padding: 11px 14px;
      background: rgba(255,255,255,0.04);
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 10px;
      font-size: 14px;
      color: var(--text);
      font-family: 'DM Sans', sans-serif;
      outline: none;
      transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
    }
    .field input::placeholder { color: rgba(241,241,243,0.2); }
    .field input:focus {
      border-color: var(--accent);
      background: rgba(99,102,241,0.06);
      box-shadow: 0 0 0 3px rgba(99,102,241,0.15);
    }

    .btn-login {
      width: 100%;
      padding: 13px;
      background: var(--accent);
      color: #fff;
      border: none;
      border-radius: 10px;
      font-size: 15px;
      font-weight: 600;
      font-family: 'DM Sans', sans-serif;
      cursor: pointer;
      margin-top: 6px;
      transition: all 0.2s;
      position: relative;
      overflow: hidden;
    }
    .btn-login:hover {
      background: #5558e8;
      transform: translateY(-1px);
      box-shadow: 0 8px 25px rgba(99,102,241,0.45);
    }
    .btn-login:active { transform: translateY(0); }

    .hint {
      margin-top: 22px;
      padding-top: 18px;
      border-top: 1px solid var(--border);
      text-align: center;
    }
    .hint p {
      font-size: 11.5px;
      color: rgba(241,241,243,0.25);
      line-height: 1.8;
    }
    .hint code {
      font-family: 'DM Mono', monospace;
      font-size: 11px;
      color: rgba(241,241,243,0.45);
      background: rgba(255,255,255,0.05);
      padding: 2px 7px;
      border-radius: 4px;
    }

    /* Responsive */
    @media(max-width: 1024px) {
      .left-panel { display: none; }
      .divider { display: none; }
      .right-panel { width: 100%; }
    }

    /* Fade in */
    .login-card { animation: fadein 0.5s ease both; }
    .left-panel { animation: fadein 0.6s ease 0.1s both; }
    @keyframes fadein { from { opacity:0; transform:translateY(12px); } to { opacity:1; transform:translateY(0); } }
  </style>
</head>
<body>
  <div class="blob blob-1"></div>
  <div class="blob blob-2"></div>

  <div class="left-panel">
    <div class="logo-row">
      <div class="logo-mark">&#127963;</div>
      <div class="logo-text">Condo<span>Desk</span></div>
    </div>
    <h1 class="hero-title">
      Gestão de<br>
      chamados<br>
      <span class="highlight">simplificada.</span>
    </h1>
    <p class="hero-sub">
      Plataforma completa para condomínios gerenciarem solicitações, acompanharem prazos e manterem a comunicação em dia.
    </p>
    <div class="features">
      <div class="feature-item">
        <div class="feature-dot"></div>
        <span class="feature-text">Gestão de blocos, andares e unidades</span>
      </div>
      <div class="feature-item">
        <div class="feature-dot"></div>
        <span class="feature-text">SLA automático por tipo de chamado</span>
      </div>
      <div class="feature-item">
        <div class="feature-dot"></div>
        <span class="feature-text">Perfis: Administrador, Colaborador, Morador</span>
      </div>
      <div class="feature-item">
        <div class="feature-dot"></div>
        <span class="feature-text">Histórico completo de interações</span>
      </div>
    </div>
  </div>

  <div class="divider"></div>

  <div class="right-panel">
    <div class="login-card">
      <div class="card-heading">
        <h2>Bem-vindo de volta</h2>
        <p>Entre com suas credenciais para acessar o sistema</p>
      </div>

      <c:if test="${hasError}">
        <div class="alert alert-error">
          <span>&#9888;</span> E-mail ou senha incorretos. Tente novamente.
        </div>
      </c:if>
      <c:if test="${hasLogout}">
        <div class="alert alert-success">
          <span>&#10003;</span> Você saiu com sucesso.
        </div>
      </c:if>
      <c:if test="${hasDenied}">
        <div class="alert alert-error">
          <span>&#128683;</span> Acesso negado para esta área.
        </div>
      </c:if>

      <form method="post" action="<c:url value='/do-login'/>">
        <div class="field">
          <label>E-mail</label>
          <input type="email" name="email" placeholder="seu@email.com" required autofocus autocomplete="email"/>
        </div>
        <div class="field">
          <label>Senha</label>
          <input type="password" name="senha" placeholder="••••••••" required autocomplete="current-password"/>
        </div>
        <button type="submit" class="btn-login">Entrar no sistema →</button>
      </form>

      <div class="hint">
        <p>Credencial padrão do sistema</p>
        <p><code>admin@condominio.com</code> &nbsp;/&nbsp; <code>Admin@123</code></p>
      </div>
    </div>
  </div>
</body>
</html>
