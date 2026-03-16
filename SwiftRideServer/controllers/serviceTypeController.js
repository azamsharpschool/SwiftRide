
const models = require('../models')


exports.getServiceTypes = async (req, res) => {

    try {
        const serviceTypes = await models.ServiceType.findAll({
            attributes: {
                exclude: ['createdAt', 'updatedAt']
            },
            where: {
                isActive: true
            }
        })

        return res.status(200).json(serviceTypes)
    } catch (error) {
        return res.status(500).json({
            message: 'Unable to fetch service types.'
        })
    }

}