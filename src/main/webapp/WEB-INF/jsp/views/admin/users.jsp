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
<%--@elvariable id="searchResult" type="org.apache.rave.portal.model.util.SearchResult<org.apache.rave.portal.model.User>"--%>

<fmt:message key="${pageTitleKey}" var="pagetitle"/>
<rave:header pageTitle="${pagetitle}"/>
<rave:admin_tabsheader/>

<div class="container">
  <article class="admincontent">
    <c:if test="${actionresult eq 'delete' or actionresult eq 'update'}">
      <div class="alert-message success">
        <p>
          <fmt:message key="admin.userdetail.action.${actionresult}.success"/>
        </p>
      </div>
    </c:if>

    <div class="row">
      <div class="span16">
        <ul class="pills">
          <li>
            <a href="<spring:url value="/app/newaccount.jsp"/>"><fmt:message key="admin.users.add"/></a>
          </li>
          <li>
            <form action="<spring:url value="/app/admin/users/search"/>" method="get">
              <label for="searchTerm"><fmt:message key="admin.users.search"/></label>
              <div class="input">
                <input type="search" id="searchTerm" name="searchTerm" value="<c:out value="${searchTerm}"/>"/>
                <fmt:message key="page.store.search.button" var="searchButtonText"/>
                <button type="submit" value="${searchButtonText}" class="btn primary">${searchButtonText}</button>

              </div>

            </form>
          </li>
          <c:if test="${not empty searchTerm}">
            <li>
              <a href="<spring:url value="/app/admin/users"/>"><fmt:message key="admin.clearsearch"/></a>
            </li>
          </c:if>
        </ul>
      </div>
    </div>

    <rave:admin_listheader/>
    <rave:admin_paging/>

    <c:if test="${searchResult.totalResults > 0}">
      <table class="condensed-table">
        <thead>
        <tr>
          <th><fmt:message key="admin.userdata.username"/></th>
          <th><fmt:message key="admin.userdata.email"/></th>
          <th><fmt:message key="admin.userdata.enabled"/></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${searchResult.resultSet}">
          <spring:url value="/app/admin/userdetail/${user.entityId}" var="detaillink"/>
          <tr data-detaillink="${detaillink}">
            <td><a href="${detaillink}"><c:out value="${user.username}"/></a></td>
            <td><a href="${detaillink}"><c:out value="${user.email}"/></a></td>
            <td><a href="${detaillink}">${user.enabled}</a></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:if>

    <rave:admin_paging/>

  </article>
</div>

<script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.min.js"></script>
<script src="<spring:url value="
/script/rave_admin.js"/>"></script>
<script>$(function () {
  rave.admin.initAdminUi();
});</script>