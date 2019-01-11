class InfosController < ApplicationController
  layout 'kokuban'
  
  before_action :set_info, only: [:show, :edit, :update, :destroy]
  before_action :user_logged_in?, except: [:index, :show] 

  # GET /infos
  # GET /infos.json
  def index
    logout
    @infos = Info.order("created_at desc")
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
    @info = Info.new(info_params)
    @info.filename = info_params[:filename]
    if !info_params[:filename].present?
      @info.errors[:base] << 'ファイル名を入力してください'

      render 'new'
    elsif info_params[:filename].content_type != "application/image"
      @info.errors[:base] << 'png以外のファイルはアップロードできません'
      render 'new'
    else  
     filename = Date.today.to_time.strftime("%Y%m%d%s%f") + ".png"
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
    respond_to do |format|
      if @info.update(info_params)
        format.html { redirect_to @info, notice: 'Info was successfully updated.' }
        format.json { render :show, status: :ok, location: @info }
      else
        format.html { render :edit }
        format.json { render json: @info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infos/1
  # DELETE /infos/1.json
  def destroy
    @info.destroy
    respond_to do |format|
      format.html { redirect_to infos_url, notice: 'Info was successfully destroyed.' }
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
