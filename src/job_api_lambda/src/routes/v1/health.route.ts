import {Service} from "typedi";
import {Request, Response, Router} from "express";

@Service()
export default class HealthController {
    public router = Router();

    constructor() {
        this.router.get('/', async (req: Request, res: Response) => {
            res.status(200).json([]);
        });
    }
}
