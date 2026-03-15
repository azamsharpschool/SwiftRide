'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('RideRequests', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      riderId: {
        type: Sequelize.INTEGER
      },
      driverId: {
        type: Sequelize.INTEGER,
        allowNull: true
      },
      pickupLatitude: {
        type: Sequelize.FLOAT
      },
      pickupLongitude: {
        type: Sequelize.FLOAT
      },
      pickupAddress: {
        type: Sequelize.STRING
      },
      destinationLatitude: {
        type: Sequelize.FLOAT
      },
      destinationLongitude: {
        type: Sequelize.FLOAT
      },
      destinationAddress: {
        type: Sequelize.STRING
      },
      status: {
        type: Sequelize.ENUM(
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
      serviceType: {
        type: Sequelize.ENUM(
          'SWIFTRIDE_X',
          'SWIFTRIDE_BLACK',
          'SWIFTRIDE_SUV'
        ),
        allowNull: false,
        defaultValue: 'SWIFTRIDE_X'
      },
      estimatedFare: {
        type: Sequelize.DECIMAL,
        allowNull: true
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('RideRequests');
  }
};