'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class sub_task extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.task,{foreignKey:'task_id'});
      this.belongsToMany(models.application_user,{through:models.user_subtask})
    }
  }
  sub_task.init({
    stask_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    task_id: DataTypes.INTEGER,
    sub_priority: DataTypes.TEXT,
    sub_label: DataTypes.TEXT,
    sub_status: DataTypes.TEXT,
    created_time: DataTypes.TIME,
    created_at:DataTypes.DATE
  }, {
    sequelize,
    modelName: 'sub_task',
    underscored:true,
    freezeTableName:true,
  });
  return sub_task;
};