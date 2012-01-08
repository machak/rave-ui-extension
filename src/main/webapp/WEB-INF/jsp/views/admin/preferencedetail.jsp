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

<fmt:message key="${pageTitleKey}" var="pagetitle"/>
<rave:header pageTitle="${pagetitle}"/>
<rave:admin_tabsheader/>
<div class="container">
  <article class="admincontent">
    <ul class="pills">
      <li><a href="<spring:url value="/app/admin/preferences"/>">
        <fmt:message key="admin.preferencedetail.goback"/></a>
      </li>
    </ul>
    <h2><fmt:message key="admin.preferences.shorttitle"/></h2>

    <div class="row">
      <div class="span-one-third">
        <section>
          <spring:url value="/app/admin/preferencedetail/update" var="formAction"/>
          <form:form action="${formAction}" method="POST" modelAttribute="preferenceForm" cssClass="form">
            <form:errors cssClass="error" element="p"/>
            <fieldset>
              <input type="hidden" name="token" value="<c:out value="${tokencheck}"/>"/>
              <div class="clearfix input">
                <span class="label warning"><fmt:message key="form.some.fields.required"/></span></div>

              <form:label path="titleSuffix.value"><fmt:message key="admin.preferencedetail.titleSuffix"/></form:label>
              <div class="clearfix input">
                <form:input path="titleSuffix.value" cssClass="input-large"/>
                <form:errors path="titleSuffix.value" cssClass="error"/>
              </div>
            </fieldset>
            <fieldset>
              <label for="pageSize"><fmt:message key="admin.preferencedetail.pageSize"/> *</label>
              <div class="input">
                <spring:bind path="pageSize.value">
                  <input id="pageSize" name="pageSize.value" type="number" step="1" value="<c:out value="${status.value}"/>" class="input-large"/>
                </spring:bind>
                <form:errors path="pageSize.value" cssClass="error"/>
              </div>
            </fieldset>
            <fieldset>
              <fmt:message key="admin.preferencedetail.updateButton" var="updateButtonText"/>
              <div class="input align-right span5">
                <button type="submit" value="${updateButtonText}" class="btn primary">${updateButtonText}</button>
              </div>
            </fieldset>
          </form:form>
        </section>
      </div>
      <div class="clearfix">&nbsp;</div>

    </div>
  </article>
</div>