<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="Abrir Chamado" scope="request"/>
<c:set var="activeMenu" value="novo-chamado" scope="request"/>
<%@ include file="../shared/header.jsp" %>
<div class="card" style="max-width:700px">
  <div class="card-header"><span class="card-title">&#127915; Novo Chamado</span></div>
  <div class="card-body">
    <form:form method="post" action="/chamados/novo" modelAttribute="chamadoDTO" enctype="multipart/form-data">
      <div class="form-group">
        <label class="form-label">Titulo <span class="required">*</span></label>
        <form:input path="titulo" cssClass="form-control" placeholder="Descreva o problema brevemente"/>
        <form:errors path="titulo" cssClass="form-error"/>
      </div>
      <div class="form-grid-2">
        <div class="form-group">
          <label class="form-label">Unidade <span class="required">*</span></label>
          <form:select path="unidadeId" cssClass="form-select">
            <form:option value="" label="— Selecione —"/>
            <c:forEach var="u" items="${unidades}">
              <form:option value="${u.id}" label="${u.bloco.identificacao} — Ap ${u.identificacao}"/>
            </c:forEach>
          </form:select>
          <form:errors path="unidadeId" cssClass="form-error"/>
        </div>
        <div class="form-group">
          <label class="form-label">Tipo <span class="required">*</span></label>
          <form:select path="tipoId" cssClass="form-select">
            <form:option value="" label="— Selecione —"/>
            <c:forEach var="t" items="${tipos}">
              <form:option value="${t.id}" label="${t.titulo} (SLA: ${t.slaHoras}h)"/>
            </c:forEach>
          </form:select>
          <form:errors path="tipoId" cssClass="form-error"/>
        </div>
      </div>
      <div class="form-group">
        <label class="form-label">Descricao <span class="required">*</span></label>
        <form:textarea path="descricao" cssClass="form-control" rows="5" placeholder="Detalhe o problema..."/>
        <form:errors path="descricao" cssClass="form-error"/>
      </div>
      <div class="form-group">
        <label class="form-label">Anexos (opcional)</label>
        <input type="file" name="anexos" class="form-control" multiple accept="image/*,.pdf,.doc,.docx">
        <p class="form-hint">Maximo 10MB por arquivo.</p>
      </div>
      <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">&#10003; Abrir Chamado</button>
        <a href="<c:url value='/chamados'/>" class="btn btn-outline">Cancelar</a>
      </div>
    </form:form>
  </div>
</div>
<%@ include file="../shared/footer.jsp" %>
