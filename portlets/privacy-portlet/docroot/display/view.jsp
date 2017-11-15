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
		Liferay.on('portletReady', function (event) {
			//$('.portlet-dropzone .smc-privacy-portlet').hide();
			
			var privacyPortletPosition = "<%= position %>";
			if (privacyPortletPosition == "top") {
				$('#top-privacy-portlet').show();
				$('#bottom-privacy-portlet').hide();
			} else {
				$('#top-privacy-portlet').hide();
				$('#bottom-privacy-portlet').show();
			}
			
			setReadMoreColor();
		});
		
		function openPrivacyDetailDialog() {
			$('#<portlet:namespace />privacy-policy').dialog({
				modal: true,
				width: 400,
				dialogClass: 'privacy-cookie-dialog'
			});
		}
		
		function setReadMoreColor() {
			//var readMoreButton = $('#privacyPolicyReadMore');
			var readMoreButtonColor = "<%= readMoreColor %>";
			
			$("a[id*='privacyPolicyReadMore']").each(function (i, el) {
		        $(this).css('color',readMoreButtonColor);
		    });
		}
	</script>
	
	<aui:script use="aui-base,aui-io-deprecated,cookie,liferay-util-window">
		var okButton = A.all('#<portlet:namespace />okButton');
		var readMore = A.all('#<portlet:namespace />readMore');

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

		var privacyInfoMessage = A.all('.smc-privacy-portlet .privacy-info-message');

		if (privacyInfoMessage) {
			wrapper.addClass('wrapper-for-privacy-portlet');

			var hideStripPrivacyInfoMessage = privacyInfoMessage.all('.hide-strip-privacy-info-message');

			var hidePrivacyMessage = function() {
				
				privacyInfoMessage.each(function() {
					this.ancestor('.smc-privacy-portlet').hide();
				});
				
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