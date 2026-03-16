
const express = require('express')
const router = express.Router()
const serviceTypeController = require('../controllers/serviceTypeController')

router.get('/', serviceTypeController.getServiceTypes)

module.exports = router 