
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const models = require('../models')
const { Op } = require('sequelize')
const { validationResult } = require('express-validator')
const constants = require('../config/constants')

// configure the dotenv package 
require('dotenv').config()

exports.login = async (req, res) => {

    try {
        
        const { username, password } = req.body
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })

        if (!existingUser) {
           
            return res.status(401).json({
                success: false,
                message: 'Invalid username or password'
            });
        }

        // compare password 
        const isPasswordValid = await bcrypt.compare(password, existingUser.password)

        if (!isPasswordValid) {
            return res.status(401).json({
                success: false,
                message: 'Invalid username or password'
            })
        }

        // create the token and return the token 
        const token = jwt.sign(
            { userId: existingUser.id, roleId: existingUser.roleId },
            process.env.JWT_SECRET_KEY,
            { expiresIn: '7d' }
        )

        return res.status(200).json({
            success: true,
            message: 'Login successful',
            token, 
            userId: existingUser.id, 
            roleId: existingUser.roleId 
        })
    } catch (error) {
        return res.status(500).json({
            success: false,
            message: 'Internal server error'
        });
    }

}

exports.register = async (req, res) => {

    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        return res.status(400).json({
            success: false,
            message: errors.array().map(e => e.msg).join(', ')
        });
    }

    try {

        const { username, password, roleId, make, model, licensePlate } = req.body

        // find if the username already exists 
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })

        if (existingUser) {
            return res.status(409).json({ message: 'Username is already taken', success: false })
        }

        await models.sequelize.transaction(async (t) => {
            // now hash the password for new user 
            const salt = await bcrypt.genSalt(10)
            const hash = await bcrypt.hash(password, salt)

            // create the user 
            const user = await models.User.create({
                username: username,
                password: hash,
                roleId: roleId
            }, { transaction: t })

            // check if the user is a driver 
            if (roleId == constants.DRIVER) {
                // save information in DriverProfile table 
                await models.DriverProfile.create({
                    userId: user.id,
                    make: make,
                    model: model,
                    licensePlate: licensePlate
                }, { transaction: t })
            }
        })

        res.status(201).json({ success: true })

    } catch (error) {
        return res.status(500).json({ message: 'Internal server error', success: false })
    }

}