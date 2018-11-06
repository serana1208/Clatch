class ClassroomController < ApplicationController
  def top
    @nen=params[:nen]
    @room=params[:room]
  end
end
