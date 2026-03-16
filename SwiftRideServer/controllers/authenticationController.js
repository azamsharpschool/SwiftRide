
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const models = require('../models')
const { Op } = require('sequelize')
const { validationResult } = require('express-validator')
const constants = require('../config/constants')

exports.secure = async (req, res) => {
    console.log("secure")
    res.status(200).json({
        success: true, 
        message: "Secure"
    })
}

exports.refresh = async (req, res) => {

    // get the refresh token from the body 
    const { refreshToken } = req.body

    console.log(refreshToken)

    // if there is no token 
    if (!refreshToken) {
        return res.status(401).json({
            success: false,
            message: 'Unauthorized.'
        })
    }

    // verify the token 
    try {

        const payload = jwt.verify(refreshToken, process.env.JWT_REFRESH_TOKEN_KEY)

        // check if the token type is refresh 
        if(payload.type != 'refresh') {
            return res.status(401).json({
                success: false, 
                message: 'Invalid refresh token.'
            })
        }

        // check if the user exists or not 
        const user = await models.User.findByPk(payload.userId)

        if (!user) {
            return res.status(401).json({
                success: false,
                message: 'User does not exist.'
            })
        }

        // create the access token
        const accessToken = jwt.sign(
            { userId: user.id, roleId: user.roleId },
            process.env.JWT_SECRET_KEY,
            { expiresIn: '15m' }
        )

        return res.status(200).json({
            success: true,
            accessToken: accessToken
        })

    } catch (error) {
        return res.status(401).json({
            success: false,
            message: "Invalid refresh token"
        })
    }

}

exports.login = async (req, res) => {

    try {

        const { username, password } = req.body
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }, 
            include: [
                {
                    model: models.DriverProfile, 
                    as: 'profile'
                }
            ]
        })

        if (!existingUser) {

            return res.status(401).json({
                success: false,
                message: 'Invalid username or password'
            });
        }

        // compare password 
        const isPasswordValid = await bcrypt.compare(password, existingUser.password)
        console.log(isPasswordValid)

        if (!isPasswordValid) {
            return res.status(401).json({
                success: false,
                message: 'Invalid username or password'
            })
        }

        // create the access token
        const accessToken = jwt.sign(
            { userId: existingUser.id, roleId: existingUser.roleId },
            process.env.JWT_SECRET_KEY,
            { expiresIn: '15m' }
        )

        // create the refresh token 
        const refreshToken = jwt.sign(
            { userId: existingUser.id, type: 'refresh' },
            process.env.JWT_REFRESH_TOKEN_KEY,
            { expiresIn: '7d' }
        )

        return res.status(200).json({
            success: true,
            message: 'Login successful',
            accessToken,
            refreshToken,
            userId: existingUser.id,
            roleId: existingUser.roleId, 
            isOnline: existingUser.profile?.isOnline ?? null  
        })
    } catch (error) {
        console.log(error)
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

        const { username, password, roleId, make, model, licensePlate, serviceTypeId } = req.body

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
                    licensePlate: licensePlate, 
                    serviceTypeId: serviceTypeId 
                }, { transaction: t })
            }
        })

        return res.status(201).json({ success: true })

    } catch (error) {
        console.log(error)
        return res.status(500).json({ message: 'Internal server error', success: false })
    }

}