<%--
/**
 * Copyright (c) SMC Treviso Srl. All rights reserved.
 */
--%>

<%@page import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@ include file="/init.jsp" %>

<c:if test="<%= privacyInfoMessage %>">

	<div class="privacy-info-message" id="<portlet:namespace />privacy-info-message" style="background-color: <%= bannerColor %>;">
		<c:if test="<%= Validator.isNotNull(privacyInfoMessageArticleId) %>">
			<aui:layout>
				<aui:column columnWidth="100" first="true" last="true">
					<div class="privacy-container">
						<div class="flex-1" style="color:<%= bannerFontColor %>;">
							<liferay-ui:journal-article articleId="<%= privacyInfoMessageArticleId %>" groupId="<%= groupId %>" showTitle="false"/>
							
							<a href="#" onclick="openPrivacyDetailDialog()" id="<portlet:namespace />readMore" style="color:<%= readMoreColor %>;">
							    <b><liferay-ui:message key="privacy-open-detail"/></b>
							</a>
						</div>

						<div>
							<aui:button cssClass="btn btn-primary close privacy-banner-close" aria-label="Close" name="okButton" icon="fa fa-times"/>						
						</div>
					</div>
				</aui:column>
			</aui:layout>
		</c:if>
	</div>
	
	<%@ include file="view_privacy_policy.jsp" %>
	
	<script>
		function openPrivacyDetailDialog() {
			console.log("called");
			
			$('#<portlet:namespace />privacy-policy').dialog({
				modal: true,
				width: 400,
				dialogClass: 'privacy-cookie-dialog'
			});
		}
	</script>
	
	<!-- <div id="privacyCookieDialog"></div> -->
	
	<%-- <script>
		var groupId = <%= groupId %>;
		var privacyPolicyArticleId = <%= privacyPolicyArticleId %>;
		
		console.log(groupId);
		console.log(privacyPolicyArticleId);
		
		function openPrivacyDetailDialog() {
			console.log(groupId);
			console.log(privacyPolicyArticleId);
			
			var html = "<liferay-portlet:renderURL windowState='<%= LiferayWindowState.POP_UP.toString() %>' portletName='<%= PortletKeys.JOURNAL %>'>" +
				 "<portlet:param name='struts_action' value='/journal/view_article_content' />"+
				 "<portlet:param name='articleId' value='<%= String.valueOf(privacyPolicyArticleId) %>' />" +
				 "<portlet:param name='groupId' value='<%= String.valueOf(groupId) %>' />" +
				"</liferay-portlet:renderURL>";
			
			var popup = Liferay.Popup({
				width: 680,
				modal: true,
				noDraggable: true,
				noTitleBar: true,
				message: "",
				messageId: "title"});
			
			$(popup).load(html);
		}
	</script> --%>
	
	<aui:script use="aui-base,aui-io-deprecated,cookie,liferay-util-window">
		var okButton = A.one('#<portlet:namespace />okButton');
		var readMore = A.one('#<portlet:namespace />readMore');

		okButton.on('click', function(e) {

			hidePrivacyMessage();

			e.halt();
		});
		
		/* readMore.on(
			'click',
			function(event) {
				if (!event.metaKey && !event.ctrlKey) {
					Liferay.Util.openInDialog(event);
				}
			}
		); */

		var wrapper = A.one('#wrapper');

		var privacyInfoMessage = A.one('.smc-privacy-portlet .privacy-info-message');

		if (privacyInfoMessage) {
			wrapper.addClass('wrapper-for-privacy-portlet');

			var hideStripPrivacyInfoMessage = privacyInfoMessage.one('.hide-strip-privacy-info-message');

			var hidePrivacyMessage = function() {

				privacyInfoMessage.ancestor('.smc-privacy-portlet').hide();
					// renewal
					var today = new Date();
					var expire = new Date();
					var nDays=<%= cookieExpiration %>;
					expire.setTime(today.getTime() + 3600000*24*nDays);
					var expString="expires="+expire.toGMTString();
					cookieName = "<%= PrivacyUtil.PRIVACY_READ %><%=nameExtend %>";
					cookieValue =today.getTime();
					document.cookie = cookieName+"="+escape(cookieValue)+ ";expires="+expire.toGMTString();

				wrapper.removeClass('wrapper-for-privacy-portlet');
			}

			if (hideStripPrivacyInfoMessage) {

				hideStripPrivacyInfoMessage.on('click', hidePrivacyMessage);
			}

		}
		
		var position = "<%= position %>";
		if (position == "top") {
			privacyInfoMessage.addClass("privacy-position-top");
			privacyInfoMessage.removeClass("privacy-position-bottom");
		} else {
			privacyInfoMessage.removeClass("privacy-position-top");
			privacyInfoMessage.addClass("privacy-position-bottom");
		}
	</aui:script>

</c:if>