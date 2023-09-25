'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class application_user extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.hasMany(models.appointment,{foreignKey:'user_id'})
      this.hasMany(models.payment,{foreignKey:'user_id'})
      this.hasMany(models.task_group,{foreignKey:'creator_id'})
      this.belongsToMany(models.mindfulness_course,{through:models.course_user})
      this.belongsToMany(models.task_group,{through:models.group_user})
      this.belongsToMany(models.course_level,{through:models.level_user})
      this.belongsToMany(models.task,{through:models.user_create_task})
      this.belongsToMany(models.task,{through:models.user_task})
      this.belongsToMany(models.sub_task,{through:models.user_subtask})
    }
  }
  application_user.init({
    user_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    username: DataTypes.TEXT,
    full_name: DataTypes.TEXT,
    email: DataTypes.TEXT,
    phone_number: DataTypes.TEXT,
    account_status: DataTypes.TEXT,
    password: DataTypes.TEXT,
    profile_image: DataTypes.TEXT
  }, {
    sequelize,
    modelName: 'application_user',
    underscored:true,
    freezeTableName: true
  });
  return application_user;
};