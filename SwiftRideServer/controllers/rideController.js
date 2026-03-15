
const models = require('../models')

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