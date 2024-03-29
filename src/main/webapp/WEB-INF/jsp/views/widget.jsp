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
  <h1><c:out value="${widget.title}"/></h1>
</header>


<div class="container">

  <h2>
    <c:choose>
      <c:when test="${not empty widget.titleUrl}">
        <a href="<c:out value="${widget.titleUrl}"/>" rel="external"><c:out value="${widget.title}"/></a>
      </c:when>
      <c:otherwise>
        <c:out value="${widget.title}"/>
      </c:otherwise>
    </c:choose>
  </h2>


  <ul class="media-grid">
    <c:if test="${not empty widget.screenshotUrl}">
      <li>
        <img src="${widget.screenshotUrl}" alt="<fmt:message key="page.general.screenshot"/>" title="<c:out value="${widget.title}"/> <fmt:message key="page.general.screenshot"/>"/>
      </li>
    </c:if>
    <c:if test="${not empty widget.thumbnailUrl}">
      <li>
        <img src="<c:out value="${widget.thumbnailUrl}"/>" title="<c:out value="${widget.title}"/>" alt="<fmt:message key="page.general.thumbnail"/>"/>
      </li>
    </c:if>
  </ul>

  <div class="row">
    <div class="span16">
      <c:if test="${not empty widget.author}">
      <span class="label success">
        <fmt:message key="widget.author"/>
        <c:out value=" "/><%-- intentional empty String in the c:out --%>
        <c:choose>
          <c:when test="${not empty widget.authorEmail}">
            <a href="mailto:<c:out value="${widget.authorEmail}"/>"><c:out
              value="${widget.author}"/></a>
          </c:when>
          <c:otherwise><c:out value="${widget.author}"/></c:otherwise>
        </c:choose>
      </span>
      </c:if>

      <c:if test="${not empty widget.description}">
        <p class="storeWidgetDesc"><c:out value="${widget.description}"/></p>
      </c:if>

      <div class="hero-unit">
        <fmt:message key="page.widget.rate"/>
        <div id="radio" class="input">
          <input type="radio" id="like-${widget.entityId}" class="widgetDislikeButton widgetRatingButton"
                 value="10"
                 name="rating-${widget.entityId}"${widgetStatistics.userRating=='10'?" checked='true'":""}>
          <label for="like-${widget.entityId}">${widgetStatistics.totalLike}</label>
          <input type="radio" id="dislike-${widget.entityId}"
                 class="widgetDislikeButton widgetRatingButton" value="0"
                 name="rating-${widget.entityId}"${widgetStatistics.userRating=='0'?" checked='true'":""}>
          <label for="dislike-${widget.entityId}">${widgetStatistics.totalDislike}</label>
        </div>
      </div>
    </div>
  </div>
  <div class="clearfix"></div>
  <div class="row">
    <div class="span16">
      <c:choose>
        <c:when test="${widget.widgetStatus eq 'PUBLISHED'}">
          <div id="widgetAdded_${widget.entityId}" class="actions align-right">
            <button class="btn primary" id="addWidget_${widget.entityId}" onclick="rave.api.rpc.addWidgetToPage({widgetId: ${widget.entityId}, pageId: ${referringPageId}, redirectAfterAdd:true});">
              <fmt:message key="page.widget.addToPage"/>
            </button>
          </div>
        </c:when>
        <c:when test="${widget.widgetStatus eq 'PREVIEW'}">
          <div class="alert-message info">
            <p><fmt:message key="widget.widgetStatus.PREVIEW"/></p>
          </div>
        </c:when>
      </c:choose>
    </div>
  </div>


  <div class="row">
    <div class="span16">
      <h3><fmt:message key="page.widget.comments"/></h3>

      <form class="form">
        <div class="input">
          <textarea class="large" id="newComment-${widget.entityId}" rows="3" cols="50"></textarea>
        </div>
        <div class="actions align-right">
          <button id="comment-new-${widget.entityId}" class="btn primary commentNewButton"></button>
        </div>
      </form>
    </div>
    <c:if test="${not empty widget.comments}">
      <ul class="comments">
        <c:forEach var="comment" items="${widget.comments}">
          <li class="comment">

            <fmt:formatDate value="${comment.createdDate}" type="both" var="commentDate"/>
            <c:choose>
              <c:when test="${not empty comment.user.displayName}">
                <c:out value="${comment.user.displayName}"/>
              </c:when>
              <c:otherwise><c:out value="${comment.user.username}"/></c:otherwise>
            </c:choose>
            <c:out value=" - ${commentDate} "/>

            <c:if test="${userProfile.entityId eq comment.user.entityId}">
              <button id="comment-delete-${comment.entityId}" class="commentDeleteButton"
                      value="Delete" data-widgetid="<c:out value="${comment.widgetId}"/>"></button>
              <button id="comment-edit-${comment.entityId}" class="commentEditButton" value="Edit"
                      data-widgetid="<c:out value="${comment.widgetId}"/>"></button>
            </c:if>

            <p class="commentText"><c:out value="${comment.text}"/></p>

          </li>
        </c:forEach>
      </ul>
    </c:if>
  </div>


</div>

<fmt:message key="page.widget.comment.edit" var="editCommentTitle"/>
<div id="editComment-dialog" title="<c:out value="${editCommentTitle}"/>" style="display: none;">
  <textarea id="editComment" rows="3" cols="50"> </textarea>
</div>
<script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.min.js"></script>
<script src="//ajax.aspnetcdn.com/ajax/jquery.ui/1.8.16/jquery-ui.min.js"></script>
<!--[if lt IE 9]><script src=//css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js></script><![endif]-->
<script src="<spring:url value="/script/rave.js"/>"></script>
<script src="<spring:url value="/script/rave_api.js"/>"></script>
<script src="<spring:url value="/script/rave_store.js"/>"></script>
<script>
  $(function () {
    rave.setContext("<spring:url value="/app/" />");
    rave.store.init();
    rave.store.initComments();
  });
</script>