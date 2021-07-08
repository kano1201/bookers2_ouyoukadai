class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    if user_signed_in?
            #Entry内のuser_idがcurrent_userと同じEntry
            @currentUserEntry = Entry.where(user_id: current_user.id)
            #Entry内のuser_idがMYPAGEのparams.idと同じEntry
            @userEntry = Entry.where(user_id: @user.id)
                #@user.idとcurrent_user.idが同じでなければ
                unless @user.id == current_user.id
                  @currentUserEntry.each do |cu|
                    @userEntry.each do |u|
                      #もしcurrent_user側のルームidと＠user側のルームidが同じであれば存在するルームに飛ぶ
                      if cu.room_id == u.room_id then
                        @isRoom = true
                        @roomId = cu.room_id
                      end
                    end
                  end
                  #ルームが存在していなければルームとエントリーを作成する
                  unless @isRoom
                    @room = Room.new
                    @entry = Entry.new
                  end
                end
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
  user = User.find(params[:id])
  redirect_to user_path(current_user) unless current_user?(user)
  end

  def current_user?(user)
    user == current_user
  end
end