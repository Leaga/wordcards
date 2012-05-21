class TemposController < ApplicationController
  # GET /tempos
  # GET /tempos.json
  def index
    @tempos = Tempo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tempos }
    end
  end

  # GET /tempos/1
  # GET /tempos/1.json
  def show
    @tempo = Tempo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tempo }
    end
  end

  # GET /tempos/new
  # GET /tempos/new.json
  def new
    @tempo = Tempo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tempo }
    end
  end

  # GET /tempos/1/edit
  def edit
    @tempo = Tempo.find(params[:id])
  end

  # POST /tempos
  # POST /tempos.json
  def create
    @tempo = Tempo.new(params[:tempo])

    respond_to do |format|
      if @tempo.save
        format.html { redirect_to @tempo, notice: 'Tempo was successfully created.' }
        format.json { render json: @tempo, status: :created, location: @tempo }
      else
        format.html { render action: "new" }
        format.json { render json: @tempo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tempos/1
  # PUT /tempos/1.json
  def update
    @tempo = Tempo.find(params[:id])

    respond_to do |format|
      if @tempo.update_attributes(params[:tempo])
        format.html { redirect_to @tempo, notice: 'Tempo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tempo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tempos/1
  # DELETE /tempos/1.json
  def destroy
    @tempo = Tempo.find(params[:id])
    @tempo.destroy

    respond_to do |format|
      format.html { redirect_to tempos_url }
      format.json { head :no_content }
    end
  end
end
