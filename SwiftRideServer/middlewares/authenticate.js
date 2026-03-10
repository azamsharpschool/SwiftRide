
const jwt = require('jsonwebtoken')
const models = require('../models')

async function authenticate(req, res, next) {

    // check the headers 
    const authHeader = req.headers.authorization
    if(!authHeader || !authHeader.startsWith("Bearer ")) {
        return res.status(401).json({
            success: false, 
            message: 'Access token missing.'
        })
    }

    // access the token 
    const accessToken = authHeader.split(' ')[1]
    if(!accessToken) {
         return res.status(401).json({
            success: false, 
            message: 'Authorization header missing.'
        })
    }

    try {
        // verify the token
        const payload = jwt.verify(accessToken, process.env.JWT_SECRET_KEY)
        // check if the user exists in the database 
        const user = await models.User.findByPk(payload.userId)
        
        if(!user) {
            return res.status(401).json({
                success: false, 
                message: 'User does not exist.'
            })
        }

        // set the values in the request 
        req.userId = user.id 
        req.roleId = user.roleId 

        next() 

    } catch(error) {
        return res.status(401).json({
            success: false, 
            message: 'Token is invalid.'
        })
    }
}

module.exports = authenticate 