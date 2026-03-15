const models = require('../models')

exports.updateOnlineStatus = async (req, res) => {

    const userId = req.userId 
    // get online status 
    const isOnline = req.body.isOnline

    const [updated] = await models.DriverProfile.update(
            { isOnline },
            { where: { userId } }
    )

    if(updated == 0) {
        return res.status(404).json({
            success: false, 
            message: 'Driver profile was not found.'
        })
    }

    return res.status(200).json({
        success: true, 
        message: 'Driver is now updated.'
    })

}