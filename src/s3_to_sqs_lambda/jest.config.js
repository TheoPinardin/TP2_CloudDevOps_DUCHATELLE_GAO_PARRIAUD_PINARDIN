module.exports = {
	preset: 'ts-jest',
	testEnvironment: 'node',
	transform: {
		'^.+\\.ts?$': 'ts-jest',
	},
	collectCoverage: true,
	collectCoverageFrom: ['src/**/*.{js,ts}', '!src/model/**'],
	transformIgnorePatterns: ['<rootDir>/node_modules/'],
};
