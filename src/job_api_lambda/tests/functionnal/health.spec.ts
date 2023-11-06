import app from '../../src/lambda';
const request = require('supertest');

describe('GET /health', () => {
    it('should return 200', async () => {

        const response = await request(app).get('/v1/health');
        expect(response.statusCode).toBe(200);
        expect(response.body).toEqual([]);
    });
});
