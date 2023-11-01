'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class administrative_user extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.hasMany(models.blog,{foreignKey:'user_id'})
      this.hasMany(models.therapy_session,{foreignKey:'user_id'})
    }
  }
  administrative_user.init({
    user_id: {
      type:DataTypes.INTEGER,
      primaryKey:true,
      autoIncrement:true
    } ,
    username: DataTypes.TEXT,
    full_name: DataTypes.TEXT,
    //nic
    role:DataTypes.STRING,
    email: DataTypes.TEXT,
    phone_number: DataTypes.TEXT,
    about: DataTypes.TEXT,
    account_status: DataTypes.TEXT,
    years_of_experience: DataTypes.TEXT,
    tot_clients: DataTypes.INTEGER,
    password:DataTypes.STRING,
    title:DataTypes.TEXT,
    profile_image:DataTypes.STRING,
    nic:DataTypes.STRING,

  }, {
    sequelize,
    modelName: 'administrative_user',
    underscored:true,
    freezeTableName: true

  });
  return administrative_user;
};