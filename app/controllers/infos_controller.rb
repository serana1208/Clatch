class InfosController < ApplicationController
  layout 'kokuban'
  
  before_action :set_info, only: [:show, :edit, :update, :destroy]
  before_action :user_logged_in?, except: [:index, :show] 

  # GET /infos
  # GET /infos.json
  def index
    logout
    if !session[:croom_id]
        redirect_to '/'
    else
      @croom = Croom.find(session[:croom_id])
      @nen = @croom.grade
      @room = @croom.room
      @infos = Info.where(room_id: session[:croom_id]).order("created_at desc")
    end
  end

  # GET /infos/1
  # GET /infos/1.json
  def show
    logout
  end

  # GET /infos/new
  def new
    @info = Info.new
  end

  # GET /infos/1/edit
  def edit
  end

  # POST /infos
  # POST /infos.json

  
  def create
    filename = ""
    if info_params[:filename].present?
      ext = File.extname(info_params[:filename].original_filename) 
      filename = Date.today.to_time.strftime("%Y%m%d%s%F") + ext
    end
    @info = Info.new(info_params)
    @info.filename = filename
    @info.room_id = session[:croom_id]
    if !info_params[:filename].present?
      respond_to do |format|
        if @info.save
         format.html { redirect_to @info, notice: '成功しました。' }
         format.json { render :show, status: :created, location: @info }
        else
         format.html { render :new }
         format.json { render json: @info.errors, status: :unprocessable_entity }
        end
      end  
    elsif info_params[:filename].content_type != "image/jpeg" &&
          info_params[:filename].content_type != "image/png" &&
          info_params[:filename].content_type != "image/gif"
      logger.debug info_params[:filename].content_type
      @info.errors[:base] << 'jpg,png,gif以外のファイルはアップロードできません'
      render 'new'
    else   
     File.open("app/assets/images/info/" + filename,"w+b"){
        |f| f.write(info_params[:filename].read)
      } 
      @info.filename = filename 
      respond_to do |format|
       if @info.save
        format.html { redirect_to @info, notice: '成功しました。' }
        format.json { render :show, status: :created, location: @info }
       else
        format.html { render :new }
        format.json { render json: @info.errors, status: :unprocessable_entity }
       end
      end    
    end 
  end

  # PATCH/PUT /infos/1
  # PATCH/PUT /infos/1.json
  def update
     filename = ""
     if info_params[:filename].present?
       ext = File.extname(info_params[:filename].original_filename) 
       filename = Date.today.to_time.strftime("%Y%m%d%s%F") + ext
     end    
     @info = Info.new(info_params)
     @info.filename = filename
     @info.room_id = session[:croom_id] 
     if !info_params[:filename].present?       
       respond_to do |format|
        if @info.update(info_params)
           format.html { redirect_to @info, notice: '成功しました。' }
           format.json { render :show, status: :ok, location: @info }
         else
           format.html { render :edit }
           format.json { render json: @info.errors, status: :unprocessable_entity }
         end
       end
     elsif info_params[:filename].content_type != "image/jpeg" &&
           info_params[:filename].content_type != "image/png" &&
           info_params[:filename].content_type != "image/gif"
       logger.debug info_params[:filename].content_type
       @info.errors[:base] << 'jpg,png,gif以外のファイルはアップロードできません'
       render 'new'
     else   
      File.open("app/assets/images/info/" + filename,"w+b"){
         |f| f.write(info_params[:filename].read)
      } 
      @info.filename = filename 
      respond_to do |format|
       if @info.save
        format.html { redirect_to @info, notice: '成功しました。' }
        format.json { render :show, status: :created, location: @info }
       else
        format.html { render :new }
        format.json { render json: @info.errors, status: :unprocessable_entity }
       end
      end    
    end 
  end    

  # DELETE /infos/1
  # DELETE /infos/1.json
  def destroy
    @info.destroy
    respond_to do |format|
      format.html { redirect_to infos_url, notice: '削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_info
      @info = Info.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def info_params
      params.require(:info).permit(:title, :content, :limit, :filename)
    end
end
