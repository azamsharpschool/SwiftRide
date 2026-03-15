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

    }
  }
  DriverProfile.init({
    userId: DataTypes.INTEGER,
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