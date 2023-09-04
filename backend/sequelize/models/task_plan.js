'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class task_plan extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.task_group,{foreignKey:'group_id'})
      this.hasMany(models.task,{foreignKey:'group_id'})
    }
  }
  task_plan.init({
    plan_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    group_id: DataTypes.INTEGER,
    plan_name: DataTypes.TEXT,
    location: DataTypes.TEXT,
    scheduled_date: DataTypes.DATE,
    scheduled_time: DataTypes.TIME,
    schedule_type: DataTypes.TEXT,
    reminder_status: DataTypes.TEXT,
    user_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'task_plan',
    underscored:true,
    freezeTableName:true,
  });
  return task_plan;
};