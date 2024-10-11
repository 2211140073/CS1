require "bcrypt"
class TopController < ApplicationController
    def main
        if session[:login_uid] 
            render "main"
        else
            render "login"
        end
    end
    def login
        #if params[:uid]=='kindai'and params[:pass]=='sanriko'
        #if BCrypt::Password.new(user.pass) == params[:pass]
        user=User.find_by(uid:params[:uid])
        if user and BCrypt::Password.new(user.pass) == params[:pass] 
            session[:login_uid]=params[:uid]
            redirect_to top_main_path
        else
            render 'error',status: 422
        end
    end
    def logout
        session.delete(:login_uid)
        redirect_to top_main_path
    end
    def new
       @top=User.new 
    end
    def create
        user_pass = BCrypt::Password.create(params[:pass])
        @top = User.new(uid: params[:uid], pass: user_pass)
        @top.save
        redirect_to top_main_path
    end
end

=begin
    def login
        #if params[:uid]=='kindai'and params[:pass]=='sanriko'
        if User.find_by(uid:params[:uid]) and User.find_by(uid:params[:pass])
            session[:login_uid]=params[:uid]
            redirect_to top_main_path
        else
            render 'error',status: 422
        end
    end
=end