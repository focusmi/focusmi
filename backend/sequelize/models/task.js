'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class task extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.hasMany(models.sub_task,{foreignKey:'task_id'})
      this.belongsTo(models.task_plan,{foreignKey:'plan_id'})
      this.belongsTo(models.timer,{foreignKey:'timer_id'})
      this.belongsToMany(models.application_user,{through:models.user_create_task})
      this.belongsToMany(models.application_user,{through:models.user_task})

    }
  }
  task.init({
    task_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    plan_id: DataTypes.INTEGER,
    task_name:DataTypes.STRING,
    timer_id: DataTypes.INTEGER,
    duration: DataTypes.INTEGER,
    task_status: DataTypes.TEXT,
    priority: DataTypes.INTEGER,
    created_at:DataTypes.DATE
  }, {
    sequelize,
    modelName: 'task',
    underscored:true,
    freezeTableName:true,
  });
  return task;
};