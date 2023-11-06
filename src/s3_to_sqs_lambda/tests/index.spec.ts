import {spliceIntoChunks} from "../src";

describe('Index', () => {

    afterEach(() => {
        jest.clearAllMocks();
    });

    it('should split array in 2', async () => {
        // when
        const result = spliceIntoChunks(['1', '2'], 1);

        // then
        expect(result.length)
            .toEqual(2);
        expect(result[0])
            .toEqual(['1']);
    });
});
