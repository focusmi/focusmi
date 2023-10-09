'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class blog extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.administrative_user,{foreignKey:'user_id'})
    }
  }
  blog.init({
    blog_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    status:DataTypes.TEXT,
    user_id: DataTypes.INTEGER,
    title: DataTypes.TEXT,
    subtitle: DataTypes.TEXT,
    description: DataTypes.TEXT
  }, {
    sequelize,
    modelName: 'blog',
    underscored:true,
    freezeTableName:true,
  });
  return blog;
};