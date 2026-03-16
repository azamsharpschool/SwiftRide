'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class DriverProfile extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {

      models.DriverProfile.belongsTo(models.User, {
        foreignKey: 'userId', 
        as: 'user'
      })

      models.DriverProfile.belongsTo(models.ServiceType, {
        foreignKey: 'serviceTypeId', 
        as: 'serviceType'
      })

    }
  }
  DriverProfile.init({
    userId: DataTypes.INTEGER,
    serviceTypeId: {
      type: DataTypes.INTEGER, 
      allowNull: false, 
      defaultValue: 1 
    },
    make: DataTypes.STRING,
    model: DataTypes.STRING,
    licensePlate: DataTypes.STRING, 
    isOnline: DataTypes.BOOLEAN 
  }, {
    sequelize,
    modelName: 'DriverProfile',
  });
  return DriverProfile;
};