<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>${pageTitle} — CondoDesk</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value='/css/app.css'/>">
</head>
<body>
<div class="app-wrapper">
  <aside class="sidebar">
    <div class="sidebar-brand">
      <div class="brand-icon">&#127963;</div> CondoDesk
    </div>
    <nav class="sidebar-nav">
      <div class="nav-section-label">Principal</div>
      <a href="<c:url value='/dashboard'/>" class="nav-item ${activeMenu=='dashboard'?'active':''}"><span class="nav-icon">&#128202;</span> Dashboard</a>
      <a href="<c:url value='/chamados'/>" class="nav-item ${activeMenu=='chamados'?'active':''}"><span class="nav-icon">&#127915;</span> Chamados</a>
      <sec:authorize access="hasRole('MORADOR')">
        <a href="<c:url value='/chamados/novo'/>" class="nav-item ${activeMenu=='novo-chamado'?'active':''}"><span class="nav-icon">&#10133;</span> Abrir Chamado</a>
      </sec:authorize>
      <sec:authorize access="hasRole('ADMINISTRADOR')">
        <div class="nav-section-label" style="margin-top:12px">Administracao</div>
        <a href="<c:url value='/admin/usuarios'/>" class="nav-item ${activeMenu=='usuarios'?'active':''}"><span class="nav-icon">&#128101;</span> Usuarios</a>
        <a href="<c:url value='/admin/blocos'/>" class="nav-item ${activeMenu=='blocos'?'active':''}"><span class="nav-icon">&#127959;</span> Blocos</a>
        <a href="<c:url value='/admin/tipos'/>" class="nav-item ${activeMenu=='tipos'?'active':''}"><span class="nav-icon">&#127991;</span> Tipos de Chamado</a>
        <a href="<c:url value='/admin/status'/>" class="nav-item ${activeMenu=='status'?'active':''}"><span class="nav-icon">&#128260;</span> Status</a>
      </sec:authorize>
    </nav>
    <div class="sidebar-footer">
      <div class="user-info">
        <div class="user-avatar"><sec:authentication property="principal.nome" var="nomeUsuario"/>${nomeUsuario.substring(0,1).toUpperCase()}</div>
        <div><div class="user-name">${nomeUsuario}</div><div class="user-role"><sec:authentication property="principal.roleNome"/></div></div>
      </div>
      <form method="post" action="<c:url value='/logout'/>">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-outline w-100" style="justify-content:center;font-size:12px">&#128682; Sair</button>
      </form>
    </div>
  </aside>
  <main class="main-content">
    <div class="topbar">
      <span class="topbar-title">${pageTitle}</span>
      <div class="topbar-actions">
        <sec:authorize access="hasAnyRole('ADMINISTRADOR','COLABORADOR')">
          <a href="<c:url value='/chamados/novo'/>" class="btn btn-primary btn-sm">&#10133; Novo Chamado</a>
        </sec:authorize>
      </div>
    </div>
    <div class="page-content">
      <c:if test="${not empty sucesso}"><div class="alert alert-success">&#10003; ${sucesso}</div></c:if>
      <c:if test="${not empty erro}"><div class="alert alert-danger">&#9888; ${erro}</div></c:if>
