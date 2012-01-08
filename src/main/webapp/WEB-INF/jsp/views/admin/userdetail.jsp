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
<c:set var="canChangeUserStatus" value="${user.username ne loggedInUser}"/>
<rave:header pageTitle="${pagetitle}"/>
<rave:admin_tabsheader/>

<div class="container">
  <article class="admincontent">
    <ul class="pills">
      <li><a href="<spring:url value="/app/admin/users"/>"><fmt:message key="admin.userdetail.goback"/></a></li>
    </ul>
    <h2><c:out value="${user.username}"/></h2>

    <div class="row">
      <div class="span7">
        <c:if test="${canChangeUserStatus}">
          <section>
            <h3><fmt:message key="admin.delete"/> <c:out value=" ${user.username}"/></h3>
            <form:form id="deleteUserProfile" action="delete" commandName="user" method="POST">
              <fieldset>
                <input type="hidden" name="token" value="<c:out value="${tokencheck}"/>"/>
                  <div class="input">
                    <ul class="inputs-list">
                      <li>
                        <input type="checkbox" name="confirmdelete" id="confirmdelete" value="true"/>
                        <label for="confirmdelete"><fmt:message key="admin.userdetail.action.delete.confirm"/></label>

                        <c:if test="${missingConfirm}">
                          <p class="error"><fmt:message key="admin.userdetail.action.delete.confirm.required"/></p>
                        </c:if>
                      </li>
                    </ul>
                </div>
              </fieldset>
              <fieldset>
                <div class="input align-right">
                  <button type="submit" value="Delete the user" class="btn primary">Delete the user</button>
                </div>
              </fieldset>
            </form:form>
          </section>
        </c:if>
      </div>
    </div>

    <div class="row">
      <div class="span7">
        <section class="formbox">
          <h3><fmt:message key="admin.userdetail.editdata"/></h3>
          <form:form id="updateUserProfile" action="update" commandName="user" method="post" cssClass="form">
          <form:errors cssClass="error" element="p"/>
          <fieldset>
            <input type="hidden" name="token" value="<c:out value="${tokencheck}"/>"/>
            <div class="clearfix">
              <label for="email"><fmt:message key="page.general.email"/></label>
              <div class="input">
                <spring:bind path="email">
                  <input type="email" name="email" id="email" value="<c:out value="${status.value}"/>" class="long"/>
                  <form:errors path="email" cssClass="input-error"/>
                </spring:bind>
              </div>
            </div>
            <div class="clearfix">
              <label for="openIdField"><fmt:message key="page.userprofile.openid.url"/></label>
              <div class="input">
                <spring:bind path="openId">
                  <input type="url" id="openIdField" name="openId" value="<c:out value="${status.value}"/>" class="long"/>
                </spring:bind>
                <form:errors path="openId" cssClass="error"/>
              </div>
            </div>

            <span class="label important"><fmt:message key="admin.userdata.accountstatus"/></span>
            <div class="clearfix">
              <div class="input">
                <ul class="inputs-list">
                  <li>
                    <fmt:message key="admin.userdata.enabled" var="labelEnabled"/>
                    <form:checkbox path="enabled" label="${labelEnabled}"
                                   disabled="${canChangeUserStatus ne true}"/>
                  </li>
                  <li>
                    <fmt:message key="admin.userdata.expired" var="labelExpired"/>
                    <form:checkbox path="expired" label="${labelExpired}"
                                   disabled="${canChangeUserStatus ne true}"/>
                  </li>
                  <li>
                    <fmt:message key="admin.userdata.locked" var="labelLocked"/>
                    <form:checkbox path="locked" label="${labelLocked}"
                                   disabled="${canChangeUserStatus ne true}"/>
                  </li>
                </ul>
              </div>
            </div>
            <fieldset>
              <fieldset>
                <span class="label important"><fmt:message key="admin.userdata.authorities"/></span>
                  <%--@elvariable id="authorities" type="org.apache.rave.portal.model.util.SearchResult<org.apache.rave.portal.model.Authority>"--%>
                <div class="clearfix">
                  <div class="input">
                    <ul class="inputs-list">
                      <form:checkboxes path="authorities" items="${authorities.resultSet}"
                                       itemLabel="authority" itemValue="authority" element="li"/>
                    </ul>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <fmt:message key="page.userprofile.button" var="updateButtonText"/>
                <div class="input align-right">
                  <button type="submit" value="${updateButtonText}" class="btn primary">${updateButtonText}</button>
                </div>
              </fieldset>
              </form:form>
        </section>
      </div>
    </div>
  </article>
</div>
