<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Usuarios" scope="request"/>
<c:set var="activeMenu" value="usuarios" scope="request"/>
<%@ include file="../../shared/header.jsp" %>
<div class="d-flex justify-between align-center mb-4">
  <span class="text-muted">${usuarios.size()} usuario(s)</span>
  <a href="<c:url value='/admin/usuarios/novo'/>" class="btn btn-primary btn-sm">&#10133; Novo Usuario</a>
</div>
<div class="card">
  <div class="table-wrapper">
    <table><thead><tr><th>#</th><th>Nome</th><th>Email</th><th>Perfil</th><th>Unidades</th><th>Status</th><th>Acoes</th></tr></thead>
    <tbody>
      <c:forEach var="u" items="${usuarios}">
      <tr>
        <td class="text-muted text-sm">${u.id}</td>
        <td class="fw-600">${u.nome}</td>
        <td>${u.email}</td>
        <td><span class="badge ${u.role.nome=='ADMINISTRADOR'?'badge-warning':u.role.nome=='COLABORADOR'?'badge-info':'badge-gray'}">${u.role.nome}</span></td>
        <td class="text-sm text-muted"><c:choose><c:when test="${u.role.nome=='MORADOR'}">${u.unidades.size()} unidade(s)</c:when><c:otherwise>—</c:otherwise></c:choose></td>
        <td><span class="badge ${u.ativo?'badge-success':'badge-danger'}">${u.ativo?'Ativo':'Inativo'}</span></td>
        <td>
          <div class="d-flex gap-2">
            <a href="<c:url value='/admin/usuarios/${u.id}/editar'/>" class="btn btn-outline btn-sm">&#9998; Editar</a>
            <form method="post" action="<c:url value='/admin/usuarios/${u.id}/toggle'/>">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <button type="submit" class="btn btn-sm ${u.ativo?'btn-warning':'btn-success'}">${u.ativo?'Desativar':'Ativar'}</button>
            </form>
          </div>
        </td>
      </tr>
      </c:forEach>
    </tbody></table>
  </div>
</div>
<%@ include file="../../shared/footer.jsp" %>
