class LexiconsController < ApplicationController
  # GET /lexicons
  # GET /lexicons.json
  def index
    @lexicons = Lexicon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lexicons }
    end
  end

  # GET /lexicons/1
  # GET /lexicons/1.json
  def show
    @lexicon = Lexicon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lexicon }
    end
  end

  # GET /lexicons/new
  # GET /lexicons/new.json
  def new
    @lexicon = Lexicon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lexicon }
    end
  end

  # GET /lexicons/1/edit
  def edit
    @lexicon = Lexicon.find(params[:id])
  end

  # POST /lexicons
  # POST /lexicons.json
  def create
    @lexicon = Lexicon.new(params[:lexicon])

    respond_to do |format|
      if @lexicon.save
        format.html { redirect_to @lexicon, notice: 'Lexicon was successfully created.' }
        format.json { render json: @lexicon, status: :created, location: @lexicon }
      else
        format.html { render action: "new" }
        format.json { render json: @lexicon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lexicons/1
  # PUT /lexicons/1.json
  def update
    @lexicon = Lexicon.find(params[:id])

    respond_to do |format|
      if @lexicon.update_attributes(params[:lexicon])
        format.html { redirect_to @lexicon, notice: 'Lexicon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lexicon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lexicons/1
  # DELETE /lexicons/1.json
  def destroy
    @lexicon = Lexicon.find(params[:id])
    @lexicon.destroy

    respond_to do |format|
      format.html { redirect_to lexicons_url }
      format.json { head :no_content }
    end
  end
end
