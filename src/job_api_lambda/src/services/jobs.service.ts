import {Service} from "typedi";
import JobsRepository from "../repositories/jobs.repository";
import {Job} from "../model/job.model";
import NotFoundError from "../model/errors/not.found";
import {v4 as uuidv4} from 'uuid';

@Service()
export default class JobsService {
    constructor(private jobsRepository: JobsRepository) {
    }

    public async getAllJobs(): Promise<Job[] | undefined> {
        return this.jobsRepository.getAll();
    }

    public async getJobById(jobId: string): Promise<Job | undefined> {
        return this.jobsRepository.getById(jobId);
    }

    public async createJob(jobRequest: Job) {
        return this.jobsRepository.create({...jobRequest, id: uuidv4()});
    }

    public async updateJob(jobId: string, jobRequest: Job): Promise<void | NotFoundError> {
        const job = await this.jobsRepository.getById(jobId);
        if(!job){
            return new NotFoundError(`Job with id ${jobId} not found`)
        }

        await this.jobsRepository.updateJob(job, jobRequest);
    }

    public async deleteJob(jobId: string): Promise<void | NotFoundError> {
        const job = await this.jobsRepository.getById(jobId);
        if(!job){
            return new NotFoundError(`Job with id ${jobId} not found`)
        }

        await this.jobsRepository.deleteJob(job);
    }
}
