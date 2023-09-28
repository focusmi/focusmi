/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('course_level','content_location',{
          type: Sequelize.STRING,
          allowNull: true,
          
        },
    );
    
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('course_level','content_location');
    
  }
};