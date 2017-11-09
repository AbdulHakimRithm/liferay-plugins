<%--
/**
 * Copyright (c) SMC Treviso Srl. All rights reserved.
 */
--%>

<%@ include file="/init.jsp" %>

<liferay-portlet:actionURL name="savePolicyPreferences" var="savePolicyPreferencesURL">
	<liferay-portlet:param name="mvcPath" value="/admin/privacy-admin/view.jsp" />
</liferay-portlet:actionURL>

<aui:form action="<%= savePolicyPreferencesURL %>" method="post" name="fm" onSubmit='<%= "event.preventDefault(); " + renderResponse.getNamespace() + "savePolicySettings();" %>'>
	<aui:input name="redirect" type="hidden" value="<%= redirect %>" />

	<aui:fieldset>

		<aui:input name="privacy-enabled" type="checkbox" id="privacyEnabled"
				checked="<%= privacyEnabled %>"
				onchange='<%= renderResponse.getNamespace() + \"checkStatus()\" %>' />

		<div id="idsPanel" style="display:none"> <!-- mail server panel -->

			<aui:input name="privacy-policy-web-content-id" value="<%= privacyPolicyArticleId %>" />

			<aui:input name="privacy-info-web-content-id" value="<%= privacyInfoMessageArticleId %>" />

			<aui:input name="cookie-expiration" value="<%= String.valueOf(cookieExpiration) %>" />

			<aui:input name="reset-previous-cookies" type="checkbox" id="resetPreviousCookies" checked="false" />
			
			<aui:field-wrapper name="position">
			
				<c:set var="position" value="<%= position %>"/>
				
				<c:choose>
				
					<c:when test="${position == 'top'}" >
					
						<aui:input inlineLabel="right" name="position" type="radio" value="top" label="top" checked="<%= true %>" />
						
						<aui:input inlineLabel="right" name="position" type="radio" value="bottom" label="bottom" />
						
					</c:when>
					
					<c:otherwise>
					
						<aui:input inlineLabel="right" name="position" type="radio" value="top" label="top" />
						
						<aui:input inlineLabel="right" name="position" type="radio" value="bottom" label="bottom" checked="<%= true %>" />
						
					</c:otherwise>
					
				</c:choose>
				
			</aui:field-wrapper>
			
			<aui:field-wrapper name="color">
				
				<aui:input name="privacy-banner-color" value="<%= bannerColor %>" />
				
				<aui:input name="privacy-banner-font-color" value="<%= bannerFontColor %>" />
				
				<aui:input name="privacy-readmore-color" value="<%= readMoreColor %>" />
				
			</aui:field-wrapper>

		</div>

	</aui:fieldset>

	<aui:button-row>
		<aui:button type="submit" />
	</aui:button-row>

</aui:form>

<aui:script>
	function <portlet:namespace/>savePolicySettings() {
		submitForm(document.<portlet:namespace/>fm);
	}
</aui:script>

<aui:script>
	Liferay.provide(
		window,
		'<portlet:namespace />checkStatus',
		function() {
			var A = AUI();
			var checkbox = A.one('#<portlet:namespace />privacyEnabledCheckbox');
			if (checkbox) {
				var status=checkbox.attr('checked');
				//alert("status: "+status);
				privacyEnabled=status;
				if (status) {
					//alert ("Show");
					A.one('#idsPanel').show(true);
				} else {
					//alert ("Hide");
					A.one('#idsPanel').hide(true);
				}
			}
		},
		['aui-base']
	);
</aui:script >

<!-- toggle panel on page load ad reload -->
<aui:script use="aui-base">
	var A = AUI();
	var checkbox = A.one('#<portlet:namespace />privacyEnabledCheckbox');
	if (checkbox) {
		var status=checkbox.attr('checked');
		privacyEnabled=status;
		if (status) {
			A.one('#idsPanel').show(true);
		} else {
			A.one('#idsPanel').hide(true);
		}
	}
</aui:script>