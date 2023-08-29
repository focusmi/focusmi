'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class course_user extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.mindfulness_course,{foreignKey:'course_id'})
      this.belongsTo(models.application_user,{foreignKey:'user_id'})
    }
  }
  course_user.init({
    course_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
    user_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
  }, {
    sequelize,
    modelName: 'course_user',
    underscored:true,
    freezeTableName:true,
  });
  return course_user;
};