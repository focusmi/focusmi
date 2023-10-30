'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class task_group extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.hasMany(models.chat,{foreignKey:'group_id'});
      this.hasMany(models.task_plan,{foreignKey:'group_id'});
      this.belongsToMany(models.application_user,{through:models.group_user})
      this.belongsTo(models.application_user,{foreignKey:'creator_id'})

    }
  }
  task_group.init({
    group_id:{
      type:DataTypes.INTEGER,
      primaryKey:true,
      autoIncrement:true
    },
    creator_id:DataTypes.INTEGER,
    group_name: DataTypes.TEXT,
    created_at:DataTypes.DATE,
    description:DataTypes.TEXT,
    status:DataTypes.STRING
  }, {
    sequelize,
    modelName: 'task_group',
    underscored:true,
    freezeTableName: true,
  });
  return task_group;
};