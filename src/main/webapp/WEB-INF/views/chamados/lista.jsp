<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="pageTitle" value="Chamados" scope="request"/>
<c:set var="activeMenu" value="chamados" scope="request"/>
<%@ include file="../shared/header.jsp" %>
<div class="card mb-4">
  <div class="card-body" style="padding:14px 20px">
    <form method="get" action="<c:url value='/chamados'/>" class="d-flex gap-3 align-center flex-wrap">
      <select name="statusId" class="form-select" style="width:180px">
        <option value="">Todos os status</option>
        <c:forEach var="s" items="${status}"><option value="${s.id}" ${statusFiltro==s.id?'selected':''}>${s.titulo}</option></c:forEach>
      </select>
      <select name="tipoId" class="form-select" style="width:200px">
        <option value="">Todos os tipos</option>
        <c:forEach var="t" items="${tipos}"><option value="${t.id}" ${tipoFiltro==t.id?'selected':''}>${t.titulo}</option></c:forEach>
      </select>
      <button type="submit" class="btn btn-outline btn-sm">&#128269; Filtrar</button>
      <a href="<c:url value='/chamados'/>" class="btn btn-outline btn-sm">&#10006; Limpar</a>
      <sec:authorize access="hasRole('MORADOR')">
        <a href="<c:url value='/chamados/novo'/>" class="btn btn-primary btn-sm" style="margin-left:auto">&#10133; Abrir Chamado</a>
      </sec:authorize>
    </form>
  </div>
</div>
<div class="card">
  <div class="card-header"><span class="card-title">${chamados.size()} chamado(s)</span></div>
  <div class="table-wrapper">
    <table><thead><tr><th>#</th><th>Titulo</th><th>Unidade</th><th>Tipo</th><th>Status</th><th>Aberto por</th><th>Abertura</th><th>Prazo</th><th></th></tr></thead>
    <tbody>
      <c:forEach var="ch" items="${chamados}">
      <tr>
        <td class="text-muted text-sm">#${ch.id}</td>
        <td class="fw-600">${ch.titulo}</td>
        <td>${ch.unidade.bloco.identificacao} — ${ch.unidade.identificacao}</td>
        <td>${ch.tipo.titulo}</td>
        <td>
          <c:choose>
            <c:when test="${ch.status.finalStatus}"><span class="badge badge-success">${ch.status.titulo}</span></c:when>
            <c:when test="${ch.atrasado}"><span class="badge badge-danger">${ch.status.titulo} &#9888;</span></c:when>
            <c:otherwise><span class="badge badge-primary">${ch.status.titulo}</span></c:otherwise>
          </c:choose>
        </td>
        <td>${ch.abertoPor.nome}</td>
        <td class="text-sm">${dateUtil.format(ch.abertoEm)}</td>
        <td class="text-sm ${ch.atrasado?'atrasado':''}">${dateUtil.format(ch.prazoLimite)}</td>
        <td><a href="<c:url value='/chamados/${ch.id}'/>" class="btn btn-outline btn-sm">Ver</a></td>
      </tr>
      </c:forEach>
      <c:if test="${empty chamados}">
        <tr><td colspan="9" style="text-align:center;padding:40px;color:var(--gray-500)">Nenhum chamado encontrado.</td></tr>
      </c:if>
    </tbody></table>
  </div>
</div>
<%@ include file="../shared/footer.jsp" %>
