<%--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~   http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ page language="java" trimDirectiveWhitespaces="true" %>

<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>

<fmt:setBundle basename="messages"/>
<%-- Note: This page has the body definition embedded so we can reference it directly from the security config file. --%>
<tiles:insertDefinition name="templates.base">
  <%-- Override the default pageTitleKey and then export it to the request scope for use later on this page --%>
  <tiles:putAttribute name="pageTitleKey" value="page.login.title"/>
  <tiles:importAttribute name="pageTitleKey" scope="request"/>

  <tiles:putAttribute name="body">
    <div class="container-fluid">
      <div class="row">
        <div class="modal-header"><h1><fmt:message key="${pageTitleKey}"/></h1></div>
      </div>
      <div class="row">
        <div class="span4">
          <form id="loginForm" name="loginForm" action="j_spring_security_check" method="post" class="form-stacked">
            <legend><fmt:message key="page.login.usernamepassword"/></legend>
            <c:if test="${param['authfail'] eq 'form'}">
              <div class="clearfix error">
                <span class="help-inline"><fmt:message key="page.login.usernamepassword.fail"/></span>
              </div>
            </c:if>
            <fieldset>
              <div class="clearfix">
                <label for="usernameField"><fmt:message key="page.general.username" var="usernameTxt"/></label>
                <div class="input">
                  <input id="usernameField" type="text" name="j_username" placeholder="${usernameTxt}" autofocus="autofocus" class="large"/>
                </div>
              </div>
              <div class="clearfix">
                <label for="passwordField"><fmt:message key="page.general.password" var="passwordTxt"/></label>
                <div class="input">
                  <input id="passwordField" type="password" placeholder="${passwordTxt}" name="j_password" class="large"/>
                </div>
              </div>
              <div class="clearfix">
                <ul class="inputs-list">
                  <li>
                    <label>
                      <input type='checkbox' name='_spring_security_remember_me' id="remember_me" value="true"/>
                      <span><fmt:message key="page.login.rememberme"/></span>
                    </label>
                  </li>
                </ul>
              </div>
            </fieldset>
            <fieldset>
              <div class="align-right">
                <fmt:message key="page.login.usernamepassword.login" var="loginButtonText"/>
                <button type="submit" value="${loginButtonText}" class="btn primary">${loginButtonText}</button>
              </div>
            </fieldset>
          </form>

        </div>
        <div class="span2"></div>
        <div class="span4">
          <form id="oidForm" name="oidf" action="j_spring_openid_security_check" method="post" class="form-stacked">
            <legend><fmt:message key="page.login.openid"/></legend>
            <c:if test="${param['authfail'] eq 'openid'}">
              <div class="clearfix error">
                <span class="help-inline"><fmt:message key="page.login.openid.fail"/></span>
              </div>
            </c:if>
            <fieldset>
              <div class="clearfix">
                <label for="usernameField"><fmt:message key="page.general.username" var="usernameTxt"/></label>
                <div class="input">
                  <fmt:message key="page.login.openid.identifier" var="openidTxt"/>
                  <input type='text' id="openid_identifier" name='openid_identifier' placeholder="${openidTxt}" class="long"/>
                </div>
              </div>
              <div class="clearfix">
                <ul class="inputs-list">
                  <li>
                    <label>
                      <input type='checkbox' name='_spring_security_remember_me' id="remember_me_openid" value="true"/>
                      <span><fmt:message key="page.login.rememberme"/></span>
                    </label>
                  </li>
                </ul>
              </div>
            </fieldset>
            <fieldset>
              <div class="align-right">
                <fmt:message key="page.login.openid.button" var="openidButtonText"/>
                <button type="submit" value="${openidButtonText}" class="btn primary">${openidButtonText}</button>
              </div>
            </fieldset>
          </form>
        </div>
      </div>
      <div class="row">
        <div class="modal-header"><h1><fmt:message key="page.login.createaccount"/></h1></div>
      </div>
      <div class="row">
        <div class="span4">
          <form id="newAccount" action="<c:url value="
/app/newaccount.jsp"/>" method="get" class="form-stacked">
          <fieldset>
            <div class="align-right">
              <fmt:message key="page.login.createaccount.button" var="createAccountButtonText"/>
              <button id="createNewAccountButton" type="submit" value="${createAccountButtonText}" class="btn primary">${createAccountButtonText}</button>
            </div>
          </fieldset>
          </form>
        </div>
      </div>
    </div>

  </tiles:putAttribute>
</tiles:insertDefinition>