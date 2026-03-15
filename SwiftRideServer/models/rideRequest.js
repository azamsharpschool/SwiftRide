'use strict'
const { Model } = require('sequelize')

module.exports = (sequelize, DataTypes) => {

  class RideRequest extends Model {

    static associate(models) {

      // rider relationship
      RideRequest.belongsTo(models.User, {
        foreignKey: "riderId",
        as: "rider"
      })

      // driver relationship
      RideRequest.belongsTo(models.User, {
        foreignKey: "driverId",
        as: "driver"
      })

    }

  }

  RideRequest.init({

    riderId: {
      type: DataTypes.INTEGER,
      allowNull: false
    },

    driverId: {
      type: DataTypes.INTEGER,
      allowNull: true
    },

    serviceType: {
      type: DataTypes.ENUM(
        'SWIFTRIDE_X',
        'SWIFTRIDE_BLACK',
        'SWIFTRIDE_SUV'
      ),
      allowNull: false,
      defaultValue: 'SWIFTRIDE_X'
    },

    pickupLatitude: {
      type: DataTypes.FLOAT,
      allowNull: false
    },

    pickupLongitude: {
      type: DataTypes.FLOAT,
      allowNull: false
    },

    pickupAddress: {
      type: DataTypes.STRING,
      allowNull: false
    },

    destinationLatitude: {
      type: DataTypes.FLOAT,
      allowNull: false
    },

    destinationLongitude: {
      type: DataTypes.FLOAT,
      allowNull: false
    },

    destinationAddress: {
      type: DataTypes.STRING,
      allowNull: false
    },

    status: {
      type: DataTypes.ENUM(
        'REQUESTED',
        'ACCEPTED',
        'ARRIVING',
        'IN_PROGRESS',
        'COMPLETED',
        'CANCELLED'
      ),
      allowNull: false,
      defaultValue: 'REQUESTED'
    },

    estimatedFare: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: true
    }

  }, {
    sequelize,
    modelName: 'RideRequest'
  })

  return RideRequest
}