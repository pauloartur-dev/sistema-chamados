<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="pageTitle" value="Chamado #${chamado.id}" scope="request"/>
<c:set var="activeMenu" value="chamados" scope="request"/>
<%@ include file="../shared/header.jsp" %>
<a href="<c:url value='/chamados'/>" class="btn btn-outline btn-sm mb-4">&#8592; Voltar</a>
<div class="chamado-header">
  <div class="chamado-id">Chamado #${chamado.id}</div>
  <div class="chamado-titulo">${chamado.titulo}</div>
  <div class="chamado-meta">
    <span>&#127968; ${chamado.unidade.bloco.identificacao} — Ap ${chamado.unidade.identificacao}</span>
    <span>&#127991; ${chamado.tipo.titulo} (SLA: ${chamado.tipo.slaHoras}h)</span>
    <span>&#128100; ${chamado.abertoPor.nome}</span>
    <span>&#128197; ${dateUtil.formatLong(chamado.abertoEm)}</span>
    <span class="${chamado.atrasado?'atrasado':''}">&#9200; Prazo: ${dateUtil.formatLong(chamado.prazoLimite)}${chamado.atrasado?' — ATRASADO':''}</span>
    <c:if test="${chamado.concluidoEm != null}"><span>&#10003; Concluido: ${dateUtil.formatLong(chamado.concluidoEm)}</span></c:if>
  </div>
  <div style="margin-top:14px;display:flex;align-items:center;gap:12px;flex-wrap:wrap">
    <span>Status:</span>
    <span class="badge ${chamado.status.finalStatus?'badge-success':'badge-primary'}" style="font-size:13px;padding:5px 14px">${chamado.status.titulo}</span>
    <sec:authorize access="hasAnyRole('ADMINISTRADOR','COLABORADOR')">
      <c:if test="${not chamado.status.finalStatus}">
        <form method="post" action="<c:url value='/chamados/${chamado.id}/status'/>" class="d-flex gap-2 align-center">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <select name="statusId" class="form-select" style="width:180px">
            <c:forEach var="s" items="${statusList}">
              <c:if test="${s.id != chamado.status.id}"><option value="${s.id}">${s.titulo}</option></c:if>
            </c:forEach>
          </select>
          <input type="text" name="observacao" class="form-control" placeholder="Observacao (opcional)" style="width:220px">
          <button type="submit" class="btn btn-primary btn-sm">Alterar Status</button>
        </form>
      </c:if>
    </sec:authorize>
  </div>
</div>
<div style="display:grid;grid-template-columns:1fr 340px;gap:20px" class="mb-4">
  <div class="card">
    <div class="card-header"><span class="card-title">&#128221; Descricao</span></div>
    <div class="card-body"><p style="white-space:pre-wrap;line-height:1.6">${chamado.descricao}</p>
      <c:if test="${not empty chamado.anexos}">
        <div style="margin-top:16px;border-top:1px solid var(--gray-200);padding-top:14px">
          <strong class="text-sm">&#128206; Anexos</strong>
          <div style="margin-top:8px;display:flex;flex-wrap:wrap;gap:8px">
            <c:forEach var="a" items="${chamado.anexos}">
              <span class="badge badge-gray">&#128196; ${a.nome}</span>
            </c:forEach>
          </div>
        </div>
      </c:if>
    </div>
  </div>
  <div class="card">
    <div class="card-header"><span class="card-title">&#128260; Historico</span></div>
    <div class="card-body">
      <div class="timeline">
        <c:forEach var="h" items="${chamado.historico}">
          <div class="timeline-item">
            <div class="timeline-dot"></div>
            <div class="timeline-content">
              <div class="timeline-header">
                <span class="timeline-author">${h.alteradoPor.nome}</span>
                <span class="timeline-date">${dateUtil.format(h.alteradoEm)}</span>
              </div>
              <div class="text-sm">
                <c:if test="${h.statusAnterior != null}"><span class="badge badge-gray">${h.statusAnterior.titulo}</span> &#8594; </c:if>
                <span class="badge badge-primary">${h.statusNovo.titulo}</span>
              </div>
              <c:if test="${not empty h.observacao}"><p class="text-sm text-muted" style="margin-top:6px">${h.observacao}</p></c:if>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>
<div class="card">
  <div class="card-header"><span class="card-title">&#128172; Comentarios (${chamado.comentarios.size()})</span></div>
  <div class="card-body">
    <c:forEach var="cm" items="${chamado.comentarios}">
      <div style="display:flex;gap:12px;margin-bottom:18px">
        <div class="user-avatar" style="width:36px;height:36px;flex-shrink:0">${cm.autor.nome.substring(0,1).toUpperCase()}</div>
        <div style="flex:1">
          <div class="d-flex justify-between align-center" style="margin-bottom:4px">
            <strong class="text-sm">${cm.autor.nome}</strong>
            <span class="text-sm text-muted">${dateUtil.formatLong(cm.criadoEm)}</span>
          </div>
          <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:6px;padding:10px 14px;font-size:13.5px;line-height:1.6;white-space:pre-wrap">${cm.conteudo}</div>
        </div>
      </div>
    </c:forEach>
    <c:if test="${empty chamado.comentarios}"><p class="text-muted text-sm">Nenhum comentario ainda.</p></c:if>
    <c:if test="${not chamado.status.finalStatus}">
      <div style="border-top:1px solid var(--gray-200);padding-top:16px;margin-top:16px">
        <form method="post" action="<c:url value='/chamados/${chamado.id}/comentario'/>">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <div class="form-group">
            <label class="form-label">Adicionar comentario</label>
            <textarea name="conteudo" class="form-control" rows="3" placeholder="Escreva seu comentario..." required></textarea>
          </div>
          <button type="submit" class="btn btn-primary btn-sm">&#128172; Comentar</button>
        </form>
      </div>
    </c:if>
  </div>
</div>
<%@ include file="../shared/footer.jsp" %>
