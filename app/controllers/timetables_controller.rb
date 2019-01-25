class TimetablesController < ApplicationController
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  before_action :user_logged_in?, except:  [:index]

  layout 'kokuban'
  
  # GET /timetables
  # GET /timetables.json
  def index
    logout
    @nengapi = Date.today
    if Timetable.find_by(date: @nengapi) == nil
      @nengapi = 0
    end
  end

  # GET /timetables/1
  # GET /timetables/1.json
  
    

  # GET /timetables/new
  def new
    
    @timetable = Timetable.new
  end

  # GET /timetables/1/edit
  def edit
    
  end
  
  # POST /timetables
  # POST /timetables.json
  def create
    @timetable = Timetable.find_by(date: timetable_params[:nengapi].to_i)
    if @timetable == nil
      @timetable = Timetable.new(timetable_params)
    end
    @timetable.filename = timetable_params[:filename]
    if !timetable_params[:filename].present?
      @timetable.errors[:base] << 'ファイル名を入力してください'
      render 'new'
    elsif timetable_params[:filename].content_type != "application/pdf"
      @timetable.errors[:base] << 'PDF以外のファイルはアップロードできません'
      render 'new'
    else  
     File.open("app/assets/images/pdf/timetable/#{@timetable.date.strftime("%Y%m%d")}"+".pdf","w+b"){
        |f| f.write(timetable_params[:filename].read)
      } 
      @timetable.filename = @timetable.date.to_s + ".pdf" 

      respond_to do |format|
        if @timetable.save
          format.html { redirect_to @timetable, notice: '成功しました！' }
          format.json { render :show, status: :created, location: @timetable }
        else
          format.html { render :new }
          format.json { render json: @timetable.errors, status: :unprocessable_entity }
        end      
      end
    end   
  end

  # PATCH/PUT /timetables/1
  # PATCH/PUT /timetables/1.json
  def update
    respond_to do |format|
      if @timetable.update(timetable_params)
        format.html { redirect_to @timetable, notice: 'アップデートできました！' }
        format.json { render :show, status: :ok, location: @timetable }
      else
        format.html { render :edit }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timetables/1
  # DELETE /timetables/1.json
  def destroy
    @timetable.destroy
    respond_to do |format|
      format.html { redirect_to timetables_url, notice: 'Timetable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timetable
      @timetable = Timetable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timetable_params
      params.require(:timetable).permit(:date, :filename)
    end
end
