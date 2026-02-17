'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {

    // 1️⃣ Add roleId column
    await queryInterface.addColumn('Users', 'roleId', {
      type: Sequelize.INTEGER,
      allowNull: false,
      references: {
        model: 'Roles',
        key: 'id'
      },
      onUpdate: 'CASCADE',
      onDelete: 'RESTRICT'
    });

    // 2️⃣ Remove old role column
    await queryInterface.removeColumn('Users', 'role');
  },

  async down(queryInterface, Sequelize) {

    // 1️⃣ Add back role column
    await queryInterface.addColumn('Users', 'role', {
      type: Sequelize.STRING,
      allowNull: false
    });

    // 2️⃣ Remove roleId column
    await queryInterface.removeColumn('Users', 'roleId');
  }
};