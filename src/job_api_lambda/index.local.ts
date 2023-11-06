import 'reflect-metadata';

import app from './src/lambda';

const port = process.env.PORT || 3034;

app.listen(port, () => {
    console.log('Server is listening...')
});
