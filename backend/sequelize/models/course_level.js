'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class course_level extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.mindfulness_course,{foreignKey:'course_id'})
      this.belongsToMany(models.application_user,{through:models.level_user})
    }
  }
  course_level.init({
    level_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    course_id: DataTypes.INTEGER,
    level_name: DataTypes.TEXT,
    level_description: DataTypes.TEXT,
    reference: DataTypes.TEXT,
    media_type: DataTypes.TEXT,
    content_location:DataTypes.TEXT
  }, {
    sequelize,
    modelName: 'course_level',
    underscored:true,
    freezeTableName:true,
  });
  return course_level;
};