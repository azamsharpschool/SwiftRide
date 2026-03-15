
const express = require('express')
const router = express.Router()
const rideController = require('../controllers/rideController')

router.post('/', rideController.createRideRequest)

module.exports = router 