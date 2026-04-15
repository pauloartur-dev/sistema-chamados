<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="${usuarioDTO.id==null?'Novo Usuario':'Editar Usuario'}" scope="request"/>
<c:set var="activeMenu" value="usuarios" scope="request"/>
<%@ include file="../../shared/header.jsp" %>
<a href="<c:url value='/admin/usuarios'/>" class="btn btn-outline btn-sm mb-4">&#8592; Voltar</a>
<div style="display:grid;grid-template-columns:1fr ${not empty unidades?'320px':''};gap:20px">
  <div class="card">
    <div class="card-header"><span class="card-title">${usuarioDTO.id==null?'&#10133; Novo Usuario':'&#9998; Editar Usuario'}</span></div>
    <div class="card-body">
      <c:set var="action" value="${usuarioDTO.id==null?'/admin/usuarios/novo':'/admin/usuarios/'.concat(usuarioDTO.id).concat('/editar')}"/>
      <form:form method="post" action="${action}" modelAttribute="usuarioDTO">
        <div class="form-grid-2">
          <div class="form-group">
            <label class="form-label">Nome <span class="required">*</span></label>
            <form:input path="nome" cssClass="form-control" placeholder="Nome completo"/>
            <form:errors path="nome" cssClass="form-error"/>
          </div>
          <div class="form-group">
            <label class="form-label">Email <span class="required">*</span></label>
            <form:input path="email" cssClass="form-control" type="email"/>
            <form:errors path="email" cssClass="form-error"/>
          </div>
        </div>
        <div class="form-grid-2">
          <div class="form-group">
            <label class="form-label">Senha ${usuarioDTO.id!=null?'(vazio = manter)':''}<c:if test="${usuarioDTO.id==null}"><span class="required">*</span></c:if></label>
            <form:password path="senha" cssClass="form-control" placeholder="Min. 6 caracteres"/>
            <form:errors path="senha" cssClass="form-error"/>
          </div>
          <div class="form-group">
            <label class="form-label">Perfil <span class="required">*</span></label>
            <form:select path="roleId" cssClass="form-select">
              <form:option value="" label="— Selecione —"/>
              <c:forEach var="r" items="${roles}"><form:option value="${r.id}" label="${r.nome}"/></c:forEach>
            </form:select>
            <form:errors path="roleId" cssClass="form-error"/>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label d-flex align-center gap-2"><form:checkbox path="ativo"/> Usuario ativo</label>
        </div>
        <div class="d-flex gap-2">
          <button type="submit" class="btn btn-primary">${usuarioDTO.id==null?'&#10003; Criar':'&#128190; Salvar'}</button>
          <a href="<c:url value='/admin/usuarios'/>" class="btn btn-outline">Cancelar</a>
        </div>
      </form:form>
    </div>
  </div>
  <c:if test="${not empty unidades or usuarioDTO.id!=null}">
  <div class="card" style="align-self:start">
    <div class="card-header"><span class="card-title">&#127968; Unidades Vinculadas</span></div>
    <div class="card-body">
      <c:forEach var="u" items="${unidades}">
        <div class="d-flex justify-between align-center mb-4">
          <span class="text-sm">${u.bloco.identificacao} — Ap ${u.identificacao}</span>
          <form method="post" action="<c:url value='/admin/usuarios/${usuarioDTO.id}/desvincular/${u.id}'/>">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-danger btn-sm">&#10006;</button>
          </form>
        </div>
      </c:forEach>
      <c:if test="${empty unidades}"><p class="text-muted text-sm">Nenhuma unidade vinculada.</p></c:if>
      <c:if test="${usuarioDTO.id!=null}">
        <form method="post" action="<c:url value='/admin/usuarios/${usuarioDTO.id}/vincular'/>" class="d-flex gap-2 align-center mt-4" style="border-top:1px solid var(--gray-200);padding-top:12px;margin-top:12px">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <select name="unidadeId" class="form-select">
            <option value="">— Selecione unidade —</option>
            <c:forEach var="u" items="${todasUnidades}"><option value="${u.id}">${u.bloco.identificacao} — Ap ${u.identificacao}</option></c:forEach>
          </select>
          <button type="submit" class="btn btn-primary btn-sm">Vincular</button>
        </form>
      </c:if>
    </div>
  </div>
  </c:if>
</div>
<%@ include file="../../shared/footer.jsp" %>
