
const express = require('express')
const router = express.Router()
const rideController = require('../controllers/rideController')

router.post('/', rideController.createRideRequest)
router.get('/available-service-types', rideController.getAvailableServiceTypes)

module.exports = router 