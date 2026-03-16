'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('ServiceTypes', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      name: {
        type: Sequelize.STRING
      },
      baseFare: {
        type: Sequelize.DECIMAL
      },
      perMileRate: {
        type: Sequelize.DECIMAL
      },
      perMinuteRate: {
        type: Sequelize.DECIMAL
      },
      maxPassengers: {
        type: Sequelize.INTEGER
      },
      isActive: {
        type: Sequelize.BOOLEAN
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
    await queryInterface.dropTable('ServiceTypes');
  }
};