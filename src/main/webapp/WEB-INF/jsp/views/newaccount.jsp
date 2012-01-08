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
<%-- Note: This page has the body definition embedded so we can reference it directly from the security config file. --%>
<tiles:insertDefinition name="templates.base">
  <%-- Override the default pageTitleKey and then export it to the request scope for use later on this page --%>
  <tiles:putAttribute name="pageTitleKey" value="page.login.title"/>
  <tiles:importAttribute name="pageTitleKey" scope="request"/>

  <tiles:putAttribute name="body">

    <div id="content">
      <div class="row">
        <div class="span12">
          <h1>${pagetitle}</h1>
          <form:form id="newAccountForm" commandName="newUser" action="newaccount" method="post">
            <fieldset>
              <legend><fmt:message key="form.all.fields.required"/></legend>
            </fieldset>
            <fieldset>
              <p><form:errors cssClass="error"/></p>
              <div class="clearfix">
                <label for="userNameField"><fmt:message key="page.general.username"/></label>
                <div class="input">
                  <form:input id="userNameField" path="username" required="required" autofocus="autofocus" cssClass="large"/>
                  <form:errors path="username" cssClass="input-error"/>
                </div>

              </div>
              <div class="clearfix">
                <label for="passwordField"><fmt:message key="page.general.password"/></label>
                <div class="input">
                  <form:password id="passwordField" path="password" required="required" cssClass="large"/>
                  <form:errors path="password" cssClass="input-error"/>
                </div>
              </div>
              <div class="clearfix">
                <label for="passwordConfirmField"><fmt:message key="page.general.confirmpassword"/></label>
                <div class="input">
                  <form:password id="passwordConfirmField" path="confirmPassword" required="required" cssClass="large"/>
                  <form:errors path="confirmPassword" cssClass="input-error"/>
                </div>

              </div>
              <div class="clearfix">
                <label for="emailField"><fmt:message key="page.general.email"/></label>
                <spring:bind path="email">
                  <div class="input">
                    <input type="email" name="email" id="emailField" required="required" class="large"/>
                    <form:errors path="email" cssClass="input-error"/>
                  </div>
                </spring:bind>


              </div>
              <div class="clearfix">
                <label for="pageLayoutField"><fmt:message key="page.general.addpage.selectlayout"/></label>
                <div class="input">
                  <form:select cssClass="large" path="pageLayout" id="pageLayoutField">
                    <form:option value="columns_1" id="columns_1_id"><fmt:message key="page.general.addpage.layout.columns_1"/></form:option>
                    <form:option value="columns_2" id="columns_2_id"><fmt:message key="page.general.addpage.layout.columns_2"/></form:option>
                    <form:option value="columns_2wn" id="columns_2wn_id"><fmt:message key="page.general.addpage.layout.columns_2wn"/></form:option>
                    <form:option value="columns_3" id="columns_3_id"><fmt:message key="page.general.addpage.layout.columns_3"/></form:option>
                    <form:option value="columns_3nwn" id="columns_3nwn_id"><fmt:message key="page.general.addpage.layout.columns_3nwn"/></form:option>
                    <form:option value="columns_4" id="columns_4_id"><fmt:message key="page.general.addpage.layout.columns_4"/></form:option>
                    <form:option value="columns_3nwn_1_bottom" id="columns_3nwn_1_bottom"><fmt:message key="page.general.addpage.layout.columns_3nwn_1_bottom"/></form:option>
                  </form:select>
                </div>
              </div>
            </fieldset>
            <fieldset>
              <div class="span6">
                <div class="clearfix align-right">
                  <fmt:message key="page.newaccount.button" var="submitButtonText"/>
                  <button type="submit" class="btn primary" value="${submitButtonText}">${submitButtonText}</button>
                </div>
              </div>
            </fieldset>
          </form:form>
        </div>
      </div>
    </div>
    <script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.6.4.min.js"></script>
    <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>
    <script src="<spring:url value="/script/rave.js"/>"></script>
    <script src="<spring:url value="/script/rave_forms.js"/>"></script>

    <script>$(document).ready(rave.forms.validateNewAccountForm());</script>
  </tiles:putAttribute>
</tiles:insertDefinition>