import {Service} from "typedi";
import {
    DeleteItemCommand,
    DynamoDBClient,
    PutItemCommand,
    PutItemCommandOutput,
    QueryCommand,
    ScanCommand,
    UpdateItemCommand
} from "@aws-sdk/client-dynamodb";
import {Job} from "../model/job.model";

@Service()
export default class JobsRepository {
    private readonly tableName: string | undefined;
    private dynamoDBClient: DynamoDBClient;

    constructor() {
        this.tableName = process.env.TABLE_NAME;

        this.dynamoDBClient = new DynamoDBClient();

        if (!this.tableName) {
            throw new Error("TABLE_NAME must not be undefined");
        }
    }


    public async getAll(): Promise<Job[] | undefined> {
        const getAllJobsCommand = new ScanCommand({
            TableName: this.tableName
        });
        const res = await this.dynamoDBClient.send(getAllJobsCommand);
        return res.Items?.map((job) => ({
            id: job.id?.S,
            city: job.city?.S,
            company_name: job.company_name?.S,
            title: job.title?.S,
            url: job.url?.S,
            contract_type: job.contract_type?.S,
            company_sector: job.company_sector?.S,
            user_experience: job.user_experience?.S,
            keyword: job.keyword?.S,
            created_date: job.created_date?.S,
            provider: job.provider?.S,
        } as Job))
    }

    public async getById(jobId: string): Promise<Job | undefined> {
        const getJobByIdCommand = new QueryCommand({
            TableName: this.tableName,
            ExpressionAttributeValues: {
                ':a': {S: jobId},
            },
            KeyConditionExpression: 'id = :a',
            ProjectionExpression: 'id, city, company_name, title, #a, contract_type, company_sector, user_experience, keyword, created_date, provider',
            ExpressionAttributeNames: { '#a': 'url' }
        });
        const res = await this.dynamoDBClient.send(getJobByIdCommand);
        return res.Items?.map((job) => ({
            id: job.id?.S,
            city: job.city?.S,
            company_name: job.company_name?.S,
            title: job.title?.S,
            url: job.url?.S,
            contract_type: job.contract_type?.S,
            company_sector: job.company_sector?.S,
            user_experience: job.user_experience?.S,
            keyword: job.keyword?.S,
            created_date: job.created_date?.S,
            provider: job.provider?.S,
        } as Job)).shift();
    }

    public async create(jobRequest: Job): Promise<PutItemCommandOutput> {
        const createJobCommand = new PutItemCommand({
            TableName: this.tableName,
            Item: {
                id: {S: jobRequest.id},
                city: {S: jobRequest.city},
                company_name: {S: jobRequest.company_name},
                title: {S: jobRequest.title},
                url: {S: jobRequest.url},
                contract_type: {S: jobRequest.contract_type},
                company_sector: {S: jobRequest.company_sector},
                user_experience: {S: jobRequest.user_experience},
                keyword: {S: jobRequest.keyword},
                created_date: {S: jobRequest.created_date},
                provider: {S: jobRequest.provider}
            }
        });
        return this.dynamoDBClient.send(createJobCommand);
    }

    public async updateJob(job: Job, updatedJob: Job) {
        const updateJobCommand = new UpdateItemCommand({
            TableName: this.tableName,
            Key: {
                id: {
                    S: job.id,
                },
                city: {
                    S: job.city,
                },
            },
            UpdateExpression: 'set #a = :m, #b = :n, #c = :o, #d = :p, #e = :q, #f = :r, #g = :s, #h = :t, #i = u',
            ExpressionAttributeNames: {
                '#a': 'company_name',
                '#b': 'title',
                '#c': 'url',
                '#d': 'contract_type',
                '#e': 'company_sector',
                '#f': 'user_experience',
                '#g': 'keyword',
                '#h': 'created_date',
                '#i': 'provider',
            },
            ExpressionAttributeValues: {
                ':m': {S: updatedJob.company_name ? updatedJob.company_name : job.company_name},
                ':n': {S: updatedJob.title ? updatedJob.title : job.title},
                ':o': {S: updatedJob.url ? updatedJob.url : job.url},
                ':p': {S: updatedJob.contract_type ? updatedJob.contract_type : job.contract_type},
                ':q': {S: updatedJob.company_sector ? updatedJob.company_sector : job.company_sector},
                ':r': {S: updatedJob.user_experience ? updatedJob.user_experience : job.user_experience},
                ':s': {S: updatedJob.keyword ? updatedJob.keyword : job.keyword},
                ':t': {S: updatedJob.created_date ? updatedJob.created_date : job.created_date},
                ':u': {S: updatedJob.provider ? updatedJob.provider : job.provider},
            },
        })
        return this.dynamoDBClient.send(updateJobCommand);
    }

    public async deleteJob(job: Job) {
        const deleteJobCommand = new DeleteItemCommand({
            TableName: this.tableName,
            Key: {
                id: {
                    S: job.id,
                },
                city: {
                    S: job.city,
                },
            },
        })
        await this.dynamoDBClient.send(deleteJobCommand);
    }

}
