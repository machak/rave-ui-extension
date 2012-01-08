<%--
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License"); you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
  --%>
<%@ page language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="portal" uri="http://www.apache.org/rave/tags" %>
<%@ taglib prefix="rave" tagdir="/WEB-INF/tags" %>
<fmt:setBundle basename="messages"/>

<header>
  <nav class="topbar">
    <div class="topbar-inner">
      <div class="container">
        <ul class="nav">
          <li>
            <a href="<spring:url value="/app/store/widget/add?referringPageId=${referringPageId}"/>">
              <fmt:message key="page.addwidget.title"/></a>
          </li>
          <li>
            <c:choose>
              <c:when test="${empty referringPageId}">
                <spring:url value="/index.html" var="gobackurl"/>
              </c:when>
              <c:otherwise>
                <spring:url value="/app/page/view/${referringPageId}" var="gobackurl"/>
              </c:otherwise>
            </c:choose>
            <a href="<c:out value="${gobackurl}"/>"><fmt:message key="page.general.back"/></a>
          </li>
          <sec:authorize url="/app/admin/">
            <li>
              <a href="<spring:url value="/app/admin/"/>">
                <fmt:message key="page.general.toadmininterface"/>
              </a>
            </li>
          </sec:authorize>
          <li>
            <a href="<spring:url value="/j_spring_security_logout" htmlEscape="true" />">
              <fmt:message key="page.general.logout"/></a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <h1>${pagetitle}</h1>
</header>

<div class="clearfix">&nbsp;</div>
<div class="container">

  <section>
    <form action="<c:url value="/app/store/search"/>" method="get">
      <fieldset>
        <input type="hidden" name="referringPageId" value="${referringPageId}">
        <label for="searchTerm"><fmt:message key="page.store.search"/></label>
        <div class="input">
          <input type="search" id="searchTerm" name="searchTerm" value="<c:out value="${searchTerm}"/>"/>
          <fmt:message key="page.store.search.button" var="searchButtonText"/>
          <button type="submit" class="btn primary" value="${searchButtonText}">${searchButtonText}</button>
          <c:if test="${not empty searchTerm}">
            <a href="<spring:url value="/app/store?referringPageId=${referringPageId}"/>"><fmt:message key="admin.clearsearch"/></a>
          </c:if>
        </div>
      </fieldset>
    </form>

    <div>
      <a class="btn secondary-action" href="<spring:url value="/app/store/mine?referringPageId=${referringPageId}"/>"><fmt:message key="page.store.list.widgets.mine"/></a>
    </div>
    <div>
      <a class="btn secondary-action" href="<spring:url value="/app/store?referringPageId=${referringPageId}"/>"><fmt:message key="page.store.list.widgets.all"/></a>
    </div>
  </section>

  <section>
    <c:choose>
      <c:when test="${empty searchTerm and (empty widgets or widgets.totalResults eq 0)}">
        <%-- Empty db --%>
        <fmt:message key="page.store.list.noresult" var="listheader"/>
      </c:when>
      <c:when test="${empty searchTerm}">
        <fmt:message key="page.store.list.result.x.to.y" var="listheader">
          <fmt:param value="${widgets.offset + 1}"/>
          <fmt:param value="${widgets.offset + fn:length(widgets.resultSet)}"/>
          <fmt:param value="${widgets.totalResults}"/>
        </fmt:message>
      </c:when>
      <c:when test="${not empty searchTerm and widgets.totalResults eq 0}">
        <fmt:message key="page.store.list.search.noresult" var="listheader">
          <fmt:param><c:out value="${searchTerm}"/></fmt:param>
        </fmt:message>
      </c:when>
      <c:otherwise>
        <fmt:message key="page.store.list.search.result.x.to.y" var="listheader">
          <fmt:param value="${widgets.offset + 1}"/>
          <fmt:param value="${widgets.offset + fn:length(widgets.resultSet)}"/>
          <fmt:param value="${widgets.totalResults}"/>
          <fmt:param><c:out value="${searchTerm}"/></fmt:param>
        </fmt:message>
      </c:otherwise>
    </c:choose>
    <h2>${listheader}</h2>
    <%--@elvariable id="widgets" type="org.apache.rave.portal.model.util.SearchResult"--%>
    <c:if test="${widgets.totalResults gt 0}">
      <c:if test="${widgets.numberOfPages gt 1}">
        <div class="pagination">
          <ul>
            <c:forEach var="i" begin="1" end="${widgets.numberOfPages}">
              <c:url var="pageUrl" value="">
                <c:param name="referringPageId" value="${referringPageId}"/>
                <c:param name="searchTerm" value="${searchTerm}"/>
                <c:param name="offset" value="${(i - 1) * widgets.pageSize}"/>
              </c:url>
              <c:choose>
                <c:when test="${i eq widgets.currentPage}">
                  <li class="active"><a>${i}</a></li>
                </c:when>
                <c:otherwise>
                  <li><a href="<c:out value="${pageUrl}"/>">${i}</a></li>
                </c:otherwise>
              </c:choose>

            </c:forEach>
          </ul>
        </div>

      </c:if>

      <div class="row">
          <%--@elvariable id="widget" type="org.apache.rave.portal.model.Widget"--%>
        <c:forEach var="widget" items="${widgets.resultSet}">
          <div class="hero-unit">

              <%--@elvariable id="widgetsStatistics" type="org.apache.rave.portal.model.util.WidgetStatistics"--%>
            <div class="span-two-thirds">
              <c:if test="${not empty widget.thumbnailUrl}">
                <ul class="media-grid small">
                  <li><img class="storeWidgetThumbnail" src="${widget.thumbnailUrl}" title="<c:out value="${widget.title}"/>" alt="" width="120" height="60"/></li>
                </ul>
              </c:if>

              <div class="actions align-right" id="widgetAdded_${widget.entityId}">
                <button class="btn primary" id="addWidget_${widget.entityId}" onclick="rave.api.rpc.addWidgetToPage({widgetId: ${widget.entityId}, pageId: ${referringPageId}, buttonId: this.id});">
                  <fmt:message key="page.widget.addToPage"/>
                </button>
                <a class="btn primary" href="<spring:url value="/app/store/widget/${widget.entityId}" />?referringPageId=${referringPageId}">
                  <c:out value="${widget.title}"/>
                </a>
              </div>
            </div>

            <div class="span7">

              <c:if test="${not empty widget.author}">
                <span class="label success"><fmt:message key="widget.author"/>: <c:out value="${widget.author}"/></span>
              </c:if>
              <c:if test="${not empty widget.description}">
                <div class="storeWidgetDesc"><c:out
                  value="${fn:substring(widget.description, 0, 200)}..."/></div>
              </c:if>
              <div class="span2">
                <fmt:message key="page.widget.rate"/>
                <c:set var="totalLikes" value="${widgetsStatistics[widget.entityId].totalLike}"/>
                <c:set var="totalDislikes" value="${widgetsStatistics[widget.entityId].totalDislike}"/>
                <div id="rating-${widget.entityId}" class="input">
                  <input type="radio" id="like-${widget.entityId}" class="widgetLikeButton" name="rating-${widget.entityId}"${widgetsStatistics[widget.entityId].userRating==10?" checked='true'":""}>
                  <label for="like-${widget.entityId}">${widgetsStatistics[widget.entityId]!=null?widgetsStatistics[widget.entityId].totalLike:"0"}</label>
                  <input type="radio" id="dislike-${widget.entityId}" class="widgetDislikeButton" name="rating-${widget.entityId}"${widgetsStatistics[widget.entityId].userRating==0?" checked='true'":""}>
                  <label for="dislike-${widget.entityId}">${widgetsStatistics[widget.entityId]!=null?widgetsStatistics[widget.entityId].totalDislike:"0"}</label>
                </div>
              </div>
            </div>

          </div>
        </c:forEach>
      </div>

      <c:if test="${widgets.numberOfPages gt 1}">

        <div class="pagination">
          <ul>
            <c:forEach var="i" begin="1" end="${widgets.numberOfPages}">
              <c:url var="pageUrl" value="">
                <c:param name="referringPageId" value="${referringPageId}"/>
                <c:param name="searchTerm" value="${searchTerm}"/>
                <c:param name="offset" value="${(i - 1) * widgets.pageSize}"/>
              </c:url>

              <c:choose>
                <c:when test="${i eq widgets.currentPage}">
                  <li class="active"><a>${i}</a>
                </c:when>
                <c:otherwise>
                  <li><a href="<c:out value="${pageUrl}"/>">${i}</a></li>
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </ul>
        </div>

      </c:if>
    </c:if>
  </section>

</div>

<script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.min.js"></script>
<script src="//ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/jquery-ui.min.js"></script>
<!--[if lt IE 9]><script src=//css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js></script><![endif]-->
<script src="<spring:url value="
/script/rave.js"/>"></script>
<script src="<spring:url value="/script/rave_api.js"/>"></script>
<script src="<spring:url value="
/script/rave_store.js"/>"></script>
<script>
  $(function () {
    rave.setContext("<spring:url value="/app/" />");
    rave.store.init();
  });
</script>