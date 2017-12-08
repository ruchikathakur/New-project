class Api::UserController < ApiBaseController

    before_action :resource

    def index
        user_detail = []
        response = {:status => false, :message => "No user present."}
        users = User.all
        if users.present?
            users.each do |user|
                companies = user.permissions(:location_access).map(&:resource).map(&:area).map(&:company)
                user_detail << {:user_id=>user.id, :name=>user.first_name+' '+user.last_name, :profile_pic=>user.profile_pic.url, :company_details=>companies.map{|companies|  {:id=>companies.id, :company_name=>companies.name, :started_work=>companies.created_at}}}
            end
            response = {:status => true, :users =>user_detail}
        end
        json_response(response)
    end

end
