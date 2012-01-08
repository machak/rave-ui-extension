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
<%--@elvariable id="searchResult" type="org.apache.rave.portal.model.util.SearchResult<org.apache.rave.portal.model.Widget>"--%>
<fmt:message key="${pageTitleKey}" var="pagetitle"/>
<rave:header pageTitle="${pagetitle}"/>
<rave:admin_tabsheader/>
<div class="container">
  <article class="admincontent">
    <c:if test="${actionresult eq 'delete' or actionresult eq 'update'}">
      <div class="alert-message success">
        <p>
          <fmt:message key="admin.widgetdetail.action.${actionresult}.success"/>
        </p>
      </div>
    </c:if>

    <div class="row">
      <div class="span7">
        <form action="<spring:url value="/app/admin/widgets/search"/>" method="get" class="form">
          <fieldset>
            <label for="searchTerm"><fmt:message key="admin.widgets.search"/></label>
            <div class="input">
              <input type="text" id="searchTerm" name="searchTerm" value="<c:out value="${searchTerm}"/>"/></div>
          </fieldset>
          <label for="widgettype" class="hidden"><fmt:message key="widget.type"/></label>
          <div class="input">
            <select name="widgettype" id="widgettype" class="dropdown">
              <option value=""><fmt:message key="admin.widgets.search.choosetype"/></option>
              <option value="OpenSocial" <c:if test="${selectedWidgetType eq 'OpenSocial'}"> selected="selected"</c:if>>
                <fmt:message key="widget.type.OpenSocial"/>
              </option>
              <option value="W3C" <c:if test="${selectedWidgetType eq 'W3C'}"> selected="selected"</c:if>>
                <fmt:message key="widget.type.W3C"/></option>
            </select>
          </div>

          <div class="clearfix">&nbsp;</div>
          <div class="input align-right">
            <fmt:message key="page.store.search.button" var="searchButtonText"/>
            <button type="submit" class="btn primary" value="${searchButtonText}">${searchButtonText}</button>
            <c:if test="${not empty searchTerm or not empty selectedWidgetType or not empty selectedWidgetStatus}">
              <a href="<spring:url value="/app/admin/widgets"/>"><span class="label"><fmt:message key="admin.clearsearch"/></span></a>


            </c:if>
          </div>
          <div class="clearfix">&nbsp;</div>
        </form>
      </div>
    </div>


    <rave:admin_listheader/>
    <rave:admin_paging/>

    <c:if test="${searchResult.totalResults > 0}">
      <table class="condensed-table">
        <thead>
        <tr>
          <th><fmt:message key="widget.title"/></th>
          <th><fmt:message key="widget.type"/></th>
          <th><fmt:message key="widget.widgetStatus"/></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="widget" items="${searchResult.resultSet}">
          <spring:url value="/app/admin/widgetdetail/${widget.entityId}" var="detaillink"/>
          <tr data-detaillink="${detaillink}">
            <td><a href="${detaillink}"><c:out value="${widget.title}"/></a></td>
            <td><a href="${detaillink}"><fmt:message key="widget.type.${widget.type}"/></a></td>
            <td><a href="${detaillink}"><c:out value="${widget.widgetStatus}"/></a></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:if>

    <rave:admin_paging/>

  </article>
</div>


<script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.min.js"></script>
<script src="<spring:url value="/script/rave_admin.js"/>"></script>
<script>$(function () {
  rave.admin.initAdminUi();
});</script>