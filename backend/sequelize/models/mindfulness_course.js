'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class mindfulness_course extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.hasMany(models.course_level,{foreignKey:'course_id'})
      this.belongsToMany(models.application_user,{through:'course_user'})
    }
  }
  mindfulness_course.init({
    course_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    title: DataTypes.TEXT,
    description: DataTypes.TEXT,
    skill: DataTypes.TEXT,
    duration: DataTypes.INTEGER,
    ratings: DataTypes.INTEGER,
    image: DataTypes.TEXT,
    course_status:DataTypes.TEXT,
    subscription_type:DataTypes.TEXT,
    course_type:DataTypes.TEXT
  
    
  }, {
    sequelize,
    modelName: 'mindfulness_course',
    underscored:true,
    freezeTableName:true,
  });
  return mindfulness_course;
};