import {Router} from 'express';
import {Container} from 'typedi';
import JobsController from "./jobs.route";
import HealthController from "./health.route";

const router = Router();

router.use('/jobs', Container.get(JobsController).router);
router.use('/health', Container.get(HealthController).router);

export default router;
