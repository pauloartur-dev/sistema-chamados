<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="Novo Bloco" scope="request"/>
<c:set var="activeMenu" value="blocos" scope="request"/>
<%@ include file="../../shared/header.jsp" %>
<a href="<c:url value='/admin/blocos'/>" class="btn btn-outline btn-sm mb-4">&#8592; Voltar</a>
<div class="card" style="max-width:600px">
  <div class="card-header"><span class="card-title">&#127959; Cadastrar Novo Bloco</span></div>
  <div class="card-body">
    <div class="alert alert-info">&#128161; Unidades serao geradas automaticamente no padrao Andar+Numero (ex: A, andar 1, apt 01 = 101)</div>
    <form:form method="post" action="/admin/blocos/novo" modelAttribute="blocoDTO">
      <div class="form-grid-2">
        <div class="form-group">
          <label class="form-label">Identificacao <span class="required">*</span></label>
          <form:input path="identificacao" cssClass="form-control" placeholder="Ex: A, Torre Norte"/>
          <form:errors path="identificacao" cssClass="form-error"/>
        </div>
        <div class="form-group">
          <label class="form-label">Descricao</label>
          <form:input path="descricao" cssClass="form-control" placeholder="Opcional"/>
        </div>
      </div>
      <div class="form-grid-2">
        <div class="form-group">
          <label class="form-label">Qtd Andares <span class="required">*</span></label>
          <form:input path="qtdAndares" cssClass="form-control" type="number" min="1" max="100"/>
          <form:errors path="qtdAndares" cssClass="form-error"/>
        </div>
        <div class="form-group">
          <label class="form-label">Apts por Andar <span class="required">*</span></label>
          <form:input path="aptsPorAndar" cssClass="form-control" type="number" min="1" max="50"/>
          <form:errors path="aptsPorAndar" cssClass="form-error"/>
        </div>
      </div>
      <p class="text-muted text-sm mb-4" id="preview"></p>
      <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">&#10003; Criar Bloco</button>
        <a href="<c:url value='/admin/blocos'/>" class="btn btn-outline">Cancelar</a>
      </div>
    </form:form>
  </div>
</div>
<script>
function upd(){var a=parseInt(document.querySelector('[name=qtdAndares]')?.value)||0,b=parseInt(document.querySelector('[name=aptsPorAndar]')?.value)||0;document.getElementById('preview').textContent=a&&b?'Serao criadas '+(a*b)+' unidades automaticamente.':'';}
document.querySelectorAll('[name=qtdAndares],[name=aptsPorAndar]').forEach(function(el){el.addEventListener('input',upd);});
</script>
<%@ include file="../../shared/footer.jsp" %>
