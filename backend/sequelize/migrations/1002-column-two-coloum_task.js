/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('task','reminder_time',{
          type: Sequelize.STRING,
          allowNull: true,
          
        },
    );
     await queryInterface.addColumn('task','reminder_date',{
          type: Sequelize.STRING,
          allowNull: true,
        },
      
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('task','reminder_time');
    await queryInterface.removeColumn('task','reminder_date');
  }
};