'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {

    await queryInterface.addColumn('DriverProfiles', 'isOnline', {
      type: Sequelize.BOOLEAN,
      allowNull: false,
      defaultValue: false
    });

  },

  async down(queryInterface, Sequelize) {

    await queryInterface.removeColumn('DriverProfiles', 'isOnline');

  }
};