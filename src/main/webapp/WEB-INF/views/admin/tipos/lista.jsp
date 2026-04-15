<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Tipos de Chamado" scope="request"/>
<c:set var="activeMenu" value="tipos" scope="request"/>
<%@ include file="../../shared/header.jsp" %>
<div style="display:grid;grid-template-columns:1fr 360px;gap:20px">
  <div class="card">
    <div class="card-header"><span class="card-title">&#127991; Tipos Cadastrados</span></div>
    <div class="table-wrapper">
      <table><thead><tr><th>Titulo</th><th>SLA</th><th>Status</th><th>Acoes</th></tr></thead>
      <tbody>
        <c:forEach var="t" items="${tipos}">
        <tr>
          <td class="fw-600">${t.titulo}</td>
          <td>${t.slaHoras}h</td>
          <td><span class="badge ${t.ativo?'badge-success':'badge-danger'}">${t.ativo?'Ativo':'Inativo'}</span></td>
          <td>
            <form method="post" action="<c:url value='/admin/tipos/${t.id}/toggle'/>" style="display:inline">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <button type="submit" class="btn btn-sm ${t.ativo?'btn-warning':'btn-success'}">${t.ativo?'Desativar':'Ativar'}</button>
            </form>
          </td>
        </tr>
        </c:forEach>
      </tbody></table>
    </div>
  </div>
  <div class="card" style="align-self:start">
    <div class="card-header"><span class="card-title">&#10133; Novo Tipo</span></div>
    <div class="card-body">
      <form method="post" action="<c:url value='/admin/tipos/salvar'/>">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="form-group">
          <label class="form-label">Titulo <span class="required">*</span></label>
          <input type="text" name="titulo" class="form-control" placeholder="Ex: Manutencao Eletrica" required>
        </div>
        <div class="form-group">
          <label class="form-label">SLA em horas <span class="required">*</span></label>
          <input type="number" name="slaHoras" class="form-control" min="1" placeholder="Ex: 48" required>
          <p class="form-hint">Prazo maximo de resolucao</p>
        </div>
        <button type="submit" class="btn btn-primary w-100" style="justify-content:center">Salvar Tipo</button>
      </form>
    </div>
  </div>
</div>
<%@ include file="../../shared/footer.jsp" %>
