'use strict';

(function(root, factory) {
	if(typeof define === 'function' && define.amd) {
		define(['jquery', 'materialize-css'], factory);
	}
	else if(typeof module === 'object' && module.exports) {
		module.exports = factory(require('jquery'), require('materialize-css'));
	}
	else {
		root.app = factory(root.jQuery);
	}
})(this, function($) {
	var exports = {};
