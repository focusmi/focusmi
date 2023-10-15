'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class user_otp extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.application_user,{foreignKey:'user_id'})
      
    }
  }
  user_otp.init({
    rec_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    },
    user_id: {
      type:DataTypes.INTEGER,
      
    } ,
    otp:{
      type:DataTypes.TEXT
    },
    created_at:DataTypes.DATE,
    updated_at:DataTypes.DATE

  }, {
    sequelize,
    modelName: 'user_otp',
    underscored:true,
    freezeTableName:true,
  });
  return user_otp;
};