class RoomsController < ApplicationController
  #def index
    #@user = current_user
    #@dm = DirectMessage.find_by(id: @direct_message.id).content
    #@currentEntries = current_user.entries
    #@currentEntriesのルームを配列にする
    #myRoomIds = []
    #@currentEntries.each do |entry|
      #myRoomIds << entry.room.id
    #end
    #@currentEntriesのルーム且つcurrent_userでないEntryを新着順で取ってくる
    #@anotherEntries = Entry.where(room_id: myRoomIds).where.not(user_id: @user.id).order(created_at: :desc)
  #end

  def show
    @room = Room.find(params[:id])
    #present?の戻り値は真偽値。よって、trueの場合、
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create(:name => "DM")
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end

  def destroy
      room = Room.find(params[:id])
      room.destroy
      redirect_to room_path(@room.id)
  end
end
