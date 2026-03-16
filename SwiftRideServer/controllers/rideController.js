
const models = require('../models')

exports.getAvailableServiceTypes = async (req, res) => {

    try {
        
        const serviceTypes = await models.ServiceType.findAll({
            include: [
                {
                    model: models.DriverProfile, 
                    as: 'driverProfiles',
                    where: { isOnline: true }, 
                    attributes: [], 
                    required: true 
                }
            ], 
             attributes: {
                exclude: ['createdAt', 'updatedAt']
            }
        })

        return res.status(200).json(serviceTypes)

    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: 'Unable to get service types.'
        })
    }

}

exports.createRideRequest = async (req, res) => {

    const riderId = req.userId

    const {
        serviceType,
        pickupLatitude,
        pickupLongitude,
        pickupAddress,
        destinationLatitude,
        destinationLongitude,
        destinationAddress
    } = req.body

    try {
        const ride = await models.RideRequest.create({
            riderId,
            serviceType,
            pickupLatitude,
            pickupLongitude,
            pickupAddress,
            destinationLatitude,
            destinationLongitude,
            destinationAddress,
            status: 'REQUESTED'
        })

        return res.status(201).json({
            success: true,
            ride
        })
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: 'Unable to create ride request.'
        })
    }


}