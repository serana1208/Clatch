class TalksController < ApplicationController
  layout 'kokuban'
  def index
    d1 = Date.today
    @talks = Talk.where(croom_id: session[:croom_id]).where('created_at > ?', d1 - 14)
    @croom=Croom.find(session[:croom_id])
    #@talks = Talk
  end

  def update
    d1 = Date.today
    @talk = Talk.new
    @talk.content=params[:data][:content]
    @talk.name=params[:data][:name]
    @talk.croom_id=session[:croom_id]
    if @talk.content.blank? || @talk.name.blank?
    else
      @talk.save
    end 
    @talks = Talk.where(croom_id: session[:croom_id]).where('created_at > ?', d1 - 14)
    render partial: 'ajax_partial' , locals: {:results => @talks}
end 
end