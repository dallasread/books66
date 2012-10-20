class MarginsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /margins
  # GET /margins.json
  def index
    @margins = Margin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @margins }
    end
  end

  # GET /margins/1
  # GET /margins/1.json
  def show
    @margin = Margin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @margin }
    end
  end

  # GET /margins/new
  # GET /margins/new.json
  def new
    @margin = Margin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @margin }
    end
  end

  # GET /margins/1/edit
  def edit
    @margin = Margin.find(params[:id])
  end

  # POST /margins
  # POST /margins.json
  def create
    @margin = Margin.new(params[:margin])

    respond_to do |format|
      if @margin.save
        format.html { redirect_to @margin, notice: 'Margin was successfully created.' }
        format.json { render json: @margin, status: :created, location: @margin }
      else
        format.html { render action: "new" }
        format.json { render json: @margin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /margins/1
  # PUT /margins/1.json
  def update
    @margin = current_user.margins.find(params[:id])

    respond_to do |format|
      if @margin.update_attributes(params[:margin])
        format.html { render nothing: true }
        format.json { head :no_content }
      else
        format.html { render nothing: true }
        format.json { render json: @margin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /margins/1
  # DELETE /margins/1.json
  def destroy
    @margin = Margin.find(params[:id])
    @margin.destroy

    respond_to do |format|
      format.html { redirect_to margins_url }
      format.json { head :no_content }
    end
  end
end
