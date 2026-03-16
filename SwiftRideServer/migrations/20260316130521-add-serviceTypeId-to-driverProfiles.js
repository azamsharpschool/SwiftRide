'use strict'

module.exports = {
  async up(queryInterface, Sequelize) {

    await queryInterface.addColumn(
      'DriverProfiles',
      'serviceTypeId',
      {
        type: Sequelize.INTEGER,
        allowNull: false,
        defaultValue: 1, 
        references: {
          model: 'ServiceTypes',
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'RESTRICT'
      }
    )

  },

  async down(queryInterface, Sequelize) {

    await queryInterface.removeColumn(
      'DriverProfiles',
      'serviceTypeId'
    )

  }
}