<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Status de Chamado" scope="request"/>
<c:set var="activeMenu" value="status" scope="request"/>
<%@ include file="../../shared/header.jsp" %>
<div style="display:grid;grid-template-columns:1fr 360px;gap:20px">
  <div class="card">
    <div class="card-header"><span class="card-title">&#128260; Status Configurados</span></div>
    <div class="table-wrapper">
      <table><thead><tr><th>Ordem</th><th>Titulo</th><th>Padrao</th><th>Final</th><th>Acoes</th></tr></thead>
      <tbody>
        <c:forEach var="s" items="${statusList}">
        <tr>
          <td>${s.ordem}</td>
          <td class="fw-600">${s.titulo}</td>
          <td>${s.padrao?'<span class=\"badge badge-info\">Sim</span>':'—'}</td>
          <td>${s.finalStatus?'<span class=\"badge badge-success\">Sim</span>':'—'}</td>
          <td>
            <c:if test="${!s.padrao}">
              <form method="post" action="<c:url value='/admin/status/${s.id}/excluir'/>" style="display:inline" onsubmit="return confirm('Excluir?')">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-danger btn-sm">&#128465;</button>
              </form>
            </c:if>
          </td>
        </tr>
        </c:forEach>
      </tbody></table>
    </div>
  </div>
  <div class="card" style="align-self:start">
    <div class="card-header"><span class="card-title">&#10133; Novo Status</span></div>
    <div class="card-body">
      <form method="post" action="<c:url value='/admin/status/salvar'/>">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="form-group">
          <label class="form-label">Titulo <span class="required">*</span></label>
          <input type="text" name="titulo" class="form-control" placeholder="Ex: Em Analise" required>
        </div>
        <div class="form-group">
          <label class="form-label">Ordem</label>
          <input type="number" name="ordem" class="form-control" value="0" min="0">
        </div>
        <div class="form-group" style="display:flex;gap:20px">
          <label style="display:flex;align-items:center;gap:6px;font-size:13px;cursor:pointer"><input type="checkbox" name="padrao" value="true"> Status padrao (inicial)</label>
          <label style="display:flex;align-items:center;gap:6px;font-size:13px;cursor:pointer"><input type="checkbox" name="finalStatus" value="true"> Status final</label>
        </div>
        <button type="submit" class="btn btn-primary w-100" style="justify-content:center">Salvar Status</button>
      </form>
    </div>
  </div>
</div>
<%@ include file="../../shared/footer.jsp" %>
