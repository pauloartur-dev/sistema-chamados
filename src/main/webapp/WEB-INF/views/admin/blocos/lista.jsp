<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Blocos" scope="request"/>
<c:set var="activeMenu" value="blocos" scope="request"/>
<%@ include file="../../shared/header.jsp" %>
<div class="d-flex justify-between align-center mb-4">
  <span class="text-muted">${blocos.size()} bloco(s)</span>
  <a href="<c:url value='/admin/blocos/novo'/>" class="btn btn-primary btn-sm">&#10133; Novo Bloco</a>
</div>
<div class="card">
  <div class="table-wrapper">
    <table><thead><tr><th>Identificacao</th><th>Andares</th><th>Apts/Andar</th><th>Total Unidades</th><th>Descricao</th><th>Acoes</th></tr></thead>
    <tbody>
      <c:forEach var="b" items="${blocos}">
      <tr>
        <td class="fw-600">${b.identificacao}</td>
        <td>${b.qtdAndares}</td>
        <td>${b.aptsPorAndar}</td>
        <td><span class="badge badge-primary">${b.qtdAndares * b.aptsPorAndar}</span></td>
        <td class="text-muted">${not empty b.descricao ? b.descricao : '—'}</td>
        <td>
          <form method="post" action="<c:url value='/admin/blocos/${b.id}/excluir'/>" style="display:inline" onsubmit="return confirm('Excluir bloco ${b.identificacao}?')">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-danger btn-sm">&#128465; Excluir</button>
          </form>
        </td>
      </tr>
      </c:forEach>
      <c:if test="${empty blocos}"><tr><td colspan="6" style="text-align:center;padding:40px;color:var(--gray-500)">Nenhum bloco cadastrado.</td></tr></c:if>
    </tbody></table>
  </div>
</div>
<%@ include file="../../shared/footer.jsp" %>
