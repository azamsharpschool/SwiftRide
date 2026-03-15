const express = require('express')
const router = express.Router()
const driverController = require('../controllers/driverController')

router.patch('/me/update-status', driverController.updateOnlineStatus)

module.exports = router 