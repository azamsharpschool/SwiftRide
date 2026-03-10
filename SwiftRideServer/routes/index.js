const express = require('express')
const router = express.Router()
const authenticationController = require('../controllers/authenticationController')
const { body } = require('express-validator')
const constants = require('../config/constants')
const authenticate = require('../middlewares/authenticate')

router.get("/secure-route", authenticate, authenticationController.secure)

router.post('/login',
    [
        body('username')
            .notEmpty().withMessage('Username is required'), 
        
        body('password')
            .notEmpty().withMessage('Password is required')
    ],
    
    authenticationController.login)

router.post('/register',
    [
        body('username')
            .notEmpty().withMessage('Username is required'),

        body('password')
            .notEmpty().withMessage('Password is required'),

        body('roleId')
            .notEmpty().withMessage('Role is required')
            .isInt().withMessage('Role must be an integer')
            .isIn([1, 2]).withMessage('Role must be either 1 (Rider) or 2 (Driver)'),

        // Conditional driver validations 
        body('make')
            .if(body('roleId').equals(String(constants.DRIVER_ROLE_ID)))
            .notEmpty().withMessage('Make is required for drivers'),

        body('model')
            .if(body('roleId').equals(String(constants.DRIVER_ROLE_ID)))
            .notEmpty().withMessage('Model is required for drivers'),

        body('licensePlate')
            .if(body('roleId').equals(String(constants.DRIVER_ROLE_ID)))
            .notEmpty().withMessage('License plate is required for drivers')

    ],
    authenticationController.register)

module.exports = router 
