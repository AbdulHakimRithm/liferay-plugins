<%--
/**
 * Copyright (c) SMC Treviso Srl. All rights reserved.
 */
--%>

<div id="<portlet:namespace />privacy-policy" hidden="true">
	<c:if test="<%= Validator.isNotNull(privacyPolicyArticleId) %>">
		<liferay-ui:journal-article
			articleId="<%= privacyPolicyArticleId %>"
			groupId="<%= groupId %>"
		/>
	</c:if>
</div>