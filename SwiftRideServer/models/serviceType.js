'use strict'
const { Model } = require('sequelize')

module.exports = (sequelize, DataTypes) => {

  class ServiceType extends Model {

    static associate(models) {
      
      models.ServiceType.hasMany(models.DriverProfile, {
        foreignKey: 'serviceTypeId', 
        as: 'driverProfiles'
      })

    }

  }

  ServiceType.init({

    name: {
      type: DataTypes.STRING,
      allowNull: false
    },

    baseFare: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
      get() {
        const value = this.getDataValue('baseFare')
        return value === null ? null : Number(value)
      }
    },

    perMileRate: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
      get() {
        const value = this.getDataValue('perMileRate')
        return value === null ? null : Number(value)
      }
    },

    perMinuteRate: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
      get() {
        const value = this.getDataValue('perMinuteRate')
        return value === null ? null : Number(value)
      }
    },

    maxPassengers: {
      type: DataTypes.INTEGER,
      allowNull: false
    },

    isActive: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    }

  }, {
    sequelize,
    modelName: 'ServiceType'
  })

  return ServiceType
}