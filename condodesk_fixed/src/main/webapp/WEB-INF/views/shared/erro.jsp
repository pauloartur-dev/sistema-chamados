<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Erro" scope="request"/>
<%@ include file="header.jsp" %>
<div class="card" style="max-width:500px;margin:40px auto;text-align:center;padding:40px">
  <div style="font-size:48px;margin-bottom:16px">&#9888;</div>
  <h2 style="margin-bottom:12px">Ocorreu um erro</h2>
  <p class="text-muted" style="margin-bottom:24px">${not empty erro ? erro : 'Erro inesperado.'}</p>
  <a href="<c:url value='/dashboard'/>" class="btn btn-primary">&#8592; Voltar</a>
</div>
<%@ include file="footer.jsp" %>
