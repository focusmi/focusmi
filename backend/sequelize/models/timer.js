'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class timer extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.hasMany(models.task,{foreignKey:'timer_id'})
    }
  }
  timer.init({
    timer_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    stopped_time: DataTypes.TEXT,
    break_duration: DataTypes.INTEGER,
    total_duration: DataTypes.INTEGER,
    status: DataTypes.TEXT,
    turns:DataTypes.INTEGER,
    user_id:{
      type:DataTypes.INTEGER,
      references:{
        model:'application_user',
        key:'user_id'
      }
    }
  }, {
    sequelize,
    modelName: 'timer',
    underscored:true,
    freezeTableName:true,
  });
  return timer;
};