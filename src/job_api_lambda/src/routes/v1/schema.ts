import * as BaseJoi from 'joi';

const Joi = BaseJoi
const postJob = Joi.object({
    city: Joi.string().required(),
    company_name: Joi.string().required(),
    title: Joi.string().required(),
    url: Joi.string(),
    contract_type: Joi.string().required(),
    company_sector: Joi.string(),
    user_experience: Joi.string(),
    keyword: Joi.string(),
    created_date: Joi.string(),
    provider: Joi.string(),
});

export const putJob = Joi.object({
    body: Joi.object({
        company_name: Joi.string().optional(),
        title: Joi.string().optional(),
        url: Joi.string().optional(),
        contract_type: Joi.string().optional(),
        company_sector: Joi.string().optional(),
        user_experience: Joi.string().optional(),
        keyword: Joi.string().optional(),
        created_date: Joi.string().optional(),
        provider: Joi.string().optional(),
    }).optional(),
});


export default {
    postJob,
    putJob
}
