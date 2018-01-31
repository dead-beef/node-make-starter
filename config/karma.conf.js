module.exports = (config) => {
	const fs = require('fs');

	let app = './dist/js/app.js';
	let vendor = './dist/js/vendor.js';
	if(!fs.existsSync(vendor)) {
		vendor = './build/vendor.js';
	}

	let files = [
		vendor,
		{
			pattern: require.resolve('jasmine-jquery'),
			watched: false,
			served: true
		},
		/*{
			pattern: './dist/js/*.map',
			included: false,
			served: true
		},*/
		app,
		'./tests/**/*.test.js'
	];

	let browsers = process.env.TEST_BROWSERS;
	if(browsers) {
		browsers = browsers.split(/\s+/);
	}
	if(!(browsers && browsers[0])) {
		browsers = ['Chromium'];
	}

	config.set({
		basePath: '../',

		files: files,
		preprocessors: {
			'**/*.js': ['sourcemap']
		},

		frameworks: ['jasmine'],

		reporters: ['spec'],
		specReporter: {
			maxLogLines: 5,
			suppressErrorSummary: true,
			suppressFailed: false,
			suppressPassed: false,
			suppressSkipped: true,
			showSpecTiming: false,
			failFast: false
		},

		port: 9876,

		colors: true,
		logLevel: config.LOG_INFO,

		autoWatch: true,
		singleRun: false,

		browsers: browsers
	});
};
