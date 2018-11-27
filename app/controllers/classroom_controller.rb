class ClassroomController < ApplicationController
  def top
    @nen=params[:nen]
    @room=params[:room]
    @croom=Croom.find_by(grade: @nen,room: @room)
    if @croom == nil
      redirect_to '/'
    end
    session[:croom_id] = @croom.id
  end
end
