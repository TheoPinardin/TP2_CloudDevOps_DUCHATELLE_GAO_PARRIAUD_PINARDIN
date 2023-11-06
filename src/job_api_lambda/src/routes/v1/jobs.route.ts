import {Request, Response, Router} from 'express';
import {Service} from "typedi";
import JobsService from "../../services/jobs.service";
import schemas from "./schema";
import NotFoundError from "../../model/errors/not.found";

@Service()
export default class JobsController {
    public router = Router();

    constructor(private jobsService: JobsService) {
        this.router.get('/', async (req: Request, res: Response) => {
            try {
                const jobs = await this.jobsService.getAllJobs()
                res.status(200).json(jobs);
            } catch (error) {
                console.error('An error ocurred:', error);
                res.status(500).json(error);
            }
        });

        this.router.get('/:id', async (req: Request, res: Response, next) => {
            try {
                const job = await this.jobsService.getJobById(req.params.id)
                if (job) {
                    res.status(200).json(job);
                } else {
                res.status(404);
                }

            } catch (error) {
                console.error('An error ocurred:', error);
                res.status(500).json(error);
            }
        });

        this.router.post('/', async (req: Request, res: Response) => {
            try {
                const {error, value} = schemas.postJob.validate(req.body);

                if (error) {
                    res.status(400).json(`Validation error: ${error.details.map(x => x.message).join(', ')}`);
                } else {
                    req.body = value;
                    const response = await this.jobsService.createJob(req.body);
                    res.status(201).json({response});
                }

            } catch (error) {
                console.error('An error occurred:', error);
                res.status(500).json(error);
            }
        });

        this.router.put('/:id', async (req: Request, res: Response) => {
            try {
                const {error, value} = schemas.putJob.validate(req.body);

                if (error) {
                    res.status(400).json(`Validation error: ${error.details.map(x => x.message).join(', ')}`);
                } else {
                    req.body = value;
                    const response = await this.jobsService.updateJob(req.params.id, req.body);
                    res.status(200).json({response});
                }
            } catch (error) {
                console.error('An error occurred:', error);
                res.status(500).json(error);
            }
        });

        this.router.delete('/:id', async (req: Request, res: Response) => {
            try {
                const resp = await this.jobsService.deleteJob(req.params.id);
                if (resp instanceof NotFoundError) {
                    res.status(404).json({resp});
                } else {
                res.status(204);
                }
            } catch (error) {
                console.error('An error occurred:', error);
                res.status(500).json(error);
            }
        });
    }
}
