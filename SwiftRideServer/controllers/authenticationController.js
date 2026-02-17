
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const models = require('../models')
const { Op } = require('sequelize')

const RIDER_ROLE_ID = 1
const DRIVER_ROLE_ID = 2

exports.register = async (req, res) => {

    try {

        const { username, password, roleId, make, model, licensePlate } = req.body

        // find if the username already exists 
        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })

        if (existingUser) {
            // return back response that user already exists 
            return res.json({ message: 'Username is already taken', success: false })
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
            if (roleId == DRIVER_ROLE_ID) {
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