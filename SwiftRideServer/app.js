const express = require('express')
const app = express() 
const indexRouter = require('./routes/index')
const driverRoutes = require('./routes/drivers')
const cors = require('cors')
const authenticate = require('./middlewares/authenticate')

// configure the dotenv package 
require('dotenv').config()

app.use(cors())
app.use(express.json())
app.use('/api/auth', indexRouter)

// protecting all routes for drivers
app.use('/api/drivers', authenticate, driverRoutes)

app.listen(8080, () => {
    console.log('Express is running...')
})