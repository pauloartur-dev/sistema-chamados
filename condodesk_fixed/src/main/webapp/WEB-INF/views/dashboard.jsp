<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<c:set var="activeMenu" value="dashboard" scope="request"/>
<%@ include file="shared/header.jsp" %>
<div class="stats-grid">
  <div class="stat-card"><div class="stat-icon">&#127915;</div><div class="stat-value">${totalChamados}</div><div class="stat-label">Total de Chamados</div></div>
  <div class="stat-card"><div class="stat-icon">&#128275;</div><div class="stat-value">${chamadosAbertos}</div><div class="stat-label">Em Aberto</div></div>
  <div class="stat-card"><div class="stat-icon">&#9888;</div><div class="stat-value" style="color:var(--danger)">${chamadosAtrasados}</div><div class="stat-label">Atrasados</div></div>
  <sec:authorize access="hasRole('ADMINISTRADOR')">
  <div class="stat-card"><div class="stat-icon">&#128101;</div><div class="stat-value">${totalUsuarios}</div><div class="stat-label">Usuarios Cadastrados</div></div>
  </sec:authorize>
</div>
<div class="card">
  <div class="card-header"><span class="card-title">Chamados Recentes</span><a href="<c:url value='/chamados'/>" class="btn btn-outline btn-sm">Ver todos</a></div>
  <div class="table-wrapper">
    <table><thead><tr><th>#</th><th>Titulo</th><th>Unidade</th><th>Tipo</th><th>Status</th><th>Abertura</th><th>Prazo</th><th></th></tr></thead>
    <tbody>
      <c:forEach var="ch" items="${chamados}" varStatus="vs" end="9">
      <tr>
        <td class="text-muted text-sm">#${ch.id}</td>
        <td class="fw-600">${ch.titulo}</td>
        <td>${ch.unidade.bloco.identificacao} — ${ch.unidade.identificacao}</td>
        <td>${ch.tipo.titulo}</td>
        <td><span class="badge ${ch.status.finalStatus ? 'badge-success' : 'badge-primary'}">${ch.status.titulo}</span></td>
        <td class="text-sm">${dateUtil.format(ch.abertoEm)}</td>
        <td class="text-sm ${ch.atrasado ? 'atrasado' : ''}">${dateUtil.format(ch.prazoLimite)}${ch.atrasado ? ' &#9888;' : ''}</td>
        <td><a href="<c:url value='/chamados/${ch.id}'/>" class="btn btn-outline btn-sm">Ver</a></td>
      </tr>
      </c:forEach>
      <c:if test="${empty chamados}">
        <tr><td colspan="8" style="text-align:center;padding:32px;color:var(--gray-500)">Nenhum chamado encontrado.</td></tr>
      </c:if>
    </tbody></table>
  </div>
</div>
<%@ include file="shared/footer.jsp" %>
