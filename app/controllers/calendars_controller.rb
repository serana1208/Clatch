class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]
  before_action :user_logged_in?, except: :index

  layout 'kokuban'



  # GET /calendars
  # GET /calendars.json
  def index
    logout
    @nendo = Date.today.year
    if Date.today.month < 4
      @nendo = @nendo - 1
    end
    if Calendar.find_by(year: @nendo) == nil
      @nendo = 0
    end
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show

  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.find_by(year: calendar_params[:nendo].to_i)
    if @calendar == nil
      @calendar = Calendar.new(calendar_params)
    end
    @calendar.filename = calendar_params[:filename]
    if !calendar_params[:filename].present?
      @calendar.errors[:base] << 'ファイル名を入力してください'
      render 'new'
    elsif calendar_params[:filename].content_type != "application/pdf"
      @calendar.errors[:base] << 'PDF以外のファイルはアップロードできません'
      render 'new'
    else
      File.open("app/assets/images/pdf/calendar/#{@calendar.year}"+".pdf","w+b"){
        |f| f.write(calendar_params[:filename].read)
      } 
      @calendar.filename = @calendar.year.to_s + ".pdf" 



      respond_to do |format|
        if @calendar.save
          format.html { redirect_to @calendar, notice: '成功しました！' }
          format.json { render :show, status: :created, location: @calendar }
        else
          format.html { render :new }
          format.json { render json: @calendar.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:year, :filename)
    end
end
