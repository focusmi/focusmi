const {administrative_user} = require("../sequelize/models")

class UserTherapist{
    constructor(user_id, username, full_name, role, email, phone_number, about, account_status, years_of_experience, tot_clients, password, title){
        this.user_id = user_id
        this.username = username
        this.full_name =  full_name
        this.role = role
        this.email = email
        this.phone_number = phone_number
        this.about = about
        this.account_status = account_status
        this.years_of_experience = years_of_experience
        this.tot_clients = tot_clients
        this.password = password
        this.title = title
    }

    static  async createTherapist(user){
        administrative_user.create(
            {
                username:user.username,
                full_name:user.full_name,
                role:user.role,
                email:user.email,
                phone_number:user.phone_number,
                about:user.about,
                account_status:"inactive",
                years_of_experience:user.years_of_experience,
                tot_clients:user.tot_clients,
                password:user.password,
                title:user.title
            }
        )

    }

    static async getTherapist(){
        var result = administrative_user.findAll();
        return result

    }

    static async deleteuser(userid){
        administrative_user.destroy({
            where:{
                user_id:userid
            }
        })
    }

    static async updateuser(userid, user){
        administrative_user.update({
            username:user.username,
            full_name:user.full_name,
            role:user.roler,
            email:user.email,
            phone_number:user.phone_number,
            about:user.about,
            account_status:user.account_status,
            years_of_experience:user.years_of_experience,
            tot_clients:user.tot_client,
            password:user.password,
            title:user.title
        },{
            where:{
                user_id:userid
            }
        })
    }
}

module.exports = UserTherapist