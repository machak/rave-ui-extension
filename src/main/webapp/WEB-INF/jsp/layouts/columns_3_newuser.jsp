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
<%--@elvariable id="page" type="org.apache.rave.portal.model.Page"--%>
<div class="alert-message block-message info">
    <fmt:message key="page.layout.newuser.introtext"/>
</div>

<div class="columns_3_newuser_widgets">
    <div class="columns_3_newuser_subtitle"><fmt:message key="page.layout.newuser.subtitle"/></div>
    <rave:region region="${page.regions[0]}" regionIdx="1" />
    <rave:region region="${page.regions[1]}" regionIdx="2" />
    <rave:region region="${page.regions[2]}" regionIdx="3" />
</div>
