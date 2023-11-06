import {Handler, S3Event} from 'aws-lambda';
import {GetObjectCommand, S3Client} from "@aws-sdk/client-s3";
import {SendMessageBatchCommand, SQSClient} from "@aws-sdk/client-sqs";
import {parse} from 'papaparse';

const s3Client = new S3Client({});
const sqsClient = new SQSClient({region: "eu-west-1"});

const queueUrl = process.env.QUEUE_URL || '';

export const handler: Handler = async (event: S3Event, context): Promise<any> => {
    console.log('EVENT: \n' + JSON.stringify(event, null, 2));

    const getObjectCommand = new GetObjectCommand({
        Bucket: event["Records"][0]["s3"]["bucket"]["name"],
        Key: event["Records"][0]["s3"]["object"]["key"]
    });

    const getObjectCommandOutput = await s3Client.send(getObjectCommand);
    const data = await getObjectCommandOutput?.Body?.transformToString();

    const jsonData = await parse(data, {header: true});
    const chunkedJobs = spliceIntoChunks(jsonData?.data, 10);

    const responses = chunkedJobs.map(async (jobs) => {
        return await sendMessageToSQS(jobs);
    });

    await Promise.all(responses);
};

export const spliceIntoChunks = (arr: any[], size: number) => {
    return Array.from({length: Math.ceil(arr.length / size)}, (_: any, i: number) => arr.slice(i * size, i * size + size));
}
const sendMessageToSQS = async (bodies: any[]) => {
    const batch: any[] = [];
    bodies.forEach((item) => {
        batch.push({
            Id: item.id,
            MessageAttributes: {},
            MessageBody: JSON.stringify(item),
        })
    })

    const command = new SendMessageBatchCommand({
        Entries: batch,
        QueueUrl: queueUrl
    });

    try {
        await sqsClient.send(command);
    } catch (error) {
        console.error(error);
        console.log(batch)
    }

}
