/**
 * Collection of handy methods for different operations.
 */
var Util = {
		
	/**
	 * Open a modal jQuery UI dialog. Title and Buttons are optional parameters.
	 * 
	 * @param message
	 * @param [title]
	 * @param [buttons]
	 * @param [width]
	 */
	showDialog: function showDialog(message, title, buttons, width) {
		/*var defaultTitle = LanguageProperties.get('com.rcs.triplestore.title');
		var defaultButtons = [{
			text: LanguageProperties.get('com.rcs.triplestore.close'),
			click: function() {
				$(this).dialog('close');
			}
		}];*/

		$('#dialog').html(message).dialog({
			modal: true,
			width: width || 400,
			dialogClass: 'privacy-cookie-dialog'
		});
	},

	/**
	 * Open a modal jQuery UI dialog showing an unknown error message.
	 * 
	 * @param [error] an optional error message.
	 */
	showErrorDialog: function showErrorDialog(error) {
		error = error ? ' (' + error + ')': ''; 
		this.showDialog(LanguageProperties.get('com.rcs.common.error.unknown') + error);
	},
	
	/**
	 * Mask the body of the document.
	 */
	maskBody: function maskBody() {
		$('body').mask(LanguageProperties.get('loading'));
	},

	/**
	 * Remove the loadmask from the body of the document.
	 */
	unmaskBody: function unmaskBody() {
		$('body').unmask();
	},
	
	/**
	 * Select all the fields of a form with class form-field and add the value to the data object passed as parameter.
	 * If a data object is not sent, it will create a new empty one.
	 * 
	 * @param formSelector
	 * @param [data]
	 * @return the data object with values from the form.
	 */
	getFormValues: function getFormValues(formSelector, data) {
		if (!formSelector || typeof formSelector !== 'string') {
			return;
		}

		// Create empty data object if parameter is empty.
		data = data || {};
		
		// Clean rcs-autocomplete-multiple old items if they exist.
		$(formSelector + ' .rcs_autocomplete_multiple').each(function () {
			delete data[this.name];
		});

		// Add form data to data object.
		$(formSelector + ' .form-field').each(function () {
			var element = $(this);
			if (element.prop('type') === 'checkbox') {
				data[this.name] = element.is(':checked');
			} else if (element.hasClass('hasDatepicker')) {
				var date = element.datepicker('getDate');
				data[this.name] = date ? date.getTime() : '';
			} else if (element.hasClass('rcs-autocomplete-multiple-item')) {
				if (!Array.isArray(data[this.name])) {
					data[this.name] = [];
				}
				data[this.name].push(this.value);
			} else {
				data[this.name] = this.value !== undefined && this.value !== null ? this.value.trim() : '';
			}
		});

		return data;
	},
	
	/**
	 * Fill automatically all the fields of a form whose name matches with a property of the data object.
	 * 
	 * @param formSelector
	 * @param [data]
	 */
	setFormValues: function setFormValues(formSelector, data) {
		if (!formSelector || typeof formSelector !== 'string' || typeof data !== 'object') {
			return;
		}
		
		// Load form fields from data object.
		Object.keys(data).forEach(function (key) {
			var element = $(formSelector + ' [name="' + key + '"]');
		    if (element.length === 1 && typeof data[key] !== 'object') {
		    	if(element.prop('tagName') === 'INPUT' && element.prop('type') === 'checkbox') {
		    		element.prop('checked', data[key]);
		    	} else if (element.prop('tagName') === 'INPUT' && element.hasClass('hasDatepicker')) {
		    		element.datepicker('setDate', new Date(data[key]));
		    	} else {
		    		element.val(data[key]);
		    	}
		    }
		});
	},

	/**
	 * Converts a timestamp in milliseconds to a JavaScript Date() in UTC, 
	 * by the addition of the browser's timezone offset to the timestamp.
	 * 
	 * @param timestamp
	 * @returns {Date}
	 */
	timestampToDateUTC: function timestampToDateUTC(timestamp) {
		if (typeof timestamp !== 'number') {
			return;
		}
		
		var date = new Date(timestamp);
		date.setTime(date.getTime() + date.getTimezoneOffset() * 60 * 1000);
		return date;
	},

	/**
	 * Converts a JavaScript Date() to a timestamp in milliseconds in UTC, 
	 * by the substraction of the browser's timezone offset to the timestamp.
	 * 
	 * @param date
	 * @returns
	 */
	dateToTimestampUTC: function dateToTimestampUTC(date) {
		if (!date instanceof Date) {
			return;
		}
		
		date.setTime(date.getTime() - date.getTimezoneOffset() * 60 * 1000);
		return date.getTime();
	}
};