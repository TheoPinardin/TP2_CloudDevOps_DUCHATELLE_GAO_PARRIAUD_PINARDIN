import {Handler, SQSEvent} from 'aws-lambda';
import {DynamoDBClient, PutItemCommand} from "@aws-sdk/client-dynamodb";

export const handler: Handler = async (event: SQSEvent, context): Promise<any> => {
    console.log('EVENT: \n' + JSON.stringify(event, null, 2));

    const dynamoDBClient = new DynamoDBClient({});

    const tableName = process.env.TABLE_NAME;

    if (!tableName) {
        throw new Error("TABLE_NAME must not be undefined");
    }

    const dynamoRequests = event.Records.map((record) => JSON.parse(record.body)).map(async (item) => {
        const command = new PutItemCommand({
            TableName: tableName,
            Item: {
                id: {S: item.id},
                city: {S: item.city},
                company_name: {S: item.company_name},
                title: {S: item.title},
                url: {S: item.url},
                contract_type: {S: item.contract_type},
                company_sector: {S: item.company_sector},
                user_experience: {S: item.user_experience},
                keyword: {S: item.keyword},
                created_date: {S: item.created_date},
                provider: {S: item.provider}
            }
        });
        return await dynamoDBClient.send(command);
    })

    await Promise.all(dynamoRequests);
};
