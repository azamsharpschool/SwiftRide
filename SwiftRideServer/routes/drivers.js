const express = require('express')
const router = express.Router()
const driverController = require('../controllers/driverController')
const authenticate = require('../middlewares/authenticate')

router.patch('/me/update-status', driverController.updateOnlineStatus)

module.exports = router 