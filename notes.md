# def new_user_handling # New user bad input handling.
    #   if params["password"] == params["password2"] && @user.save
    #     session[:user_id] = @user.id
    #     redirect "/users/#{current_user.id}"
    #   end
    # end

    # def login_handling # User authentication method.
    #   @user = User.find_by(username: params[:username])
    #   if @user && @user.authenticate(params[:password]) # Authenticate user.
    #     session[:user_id] = @user.id
    #     redirect "/users/#{current_user.id}"
    #   elsif !params[:id]
    #     flash[:message] = "Username or password incorrect. Try again." # Handle incorrect login information
    #     redirect "/login"
    #   elsif session[:user_id] == current_user.id # Handle if user is already logged in.
    #     redirect "/users/#{current_user.id}"
    #   else
    #     redirect "/"
    #   end
    # end