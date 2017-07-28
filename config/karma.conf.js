module.exports = (config) => {
	const fs = require('fs');

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
		}
	];

	if(process.env.TEST_BUNDLE) {
		files.push('./dist/js/app.js');
	}
	else {
		files.push.apply(files, [
			'./tests/test_start.js',
			'./src/js/**/*.js'
		]);
	}

	files.push('./tests/**/*.test.js');

	let browsers = process.env.TEST_BROWSERS;
	if(!browsers) {
		browsers = ['Chromium'];
	}
	else {
		browsers = browsers.split(/\s+/);
	}

	config.set({
		basePath: '../',

		files: files,

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
