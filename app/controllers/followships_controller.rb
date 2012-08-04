class FollowshipsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /followships
  # GET /followships.json
  def index
    @follows = current_user.follows

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @follows }
    end
  end

  # GET /followships/1
  # GET /followships/1.json
  def show
    @followship = Followship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @followship }
    end
  end

  # GET /followships/new
  # GET /followships/new.json
  def new
    @followship = Followship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @followship }
    end
  end

  # GET /followships/1/edit
  def edit
    @followship = Followship.find(params[:id])
  end

  # POST /followships
  # POST /followships.json
  def create
    @followship = current_user.followships.new(
      follow_id: params[:follow_id]
    )

    respond_to do |format|
      if @followship.save
        format.html { redirect_to @followship, notice: 'Followship was successfully created.' }
        format.json { render json: @followship, status: :created, location: @followship }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @followship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /followships/1
  # PUT /followships/1.json
  def update
    @followship = Followship.find(params[:id])

    respond_to do |format|
      if @followship.update_attributes(params[:followship])
        format.html { redirect_to @followship, notice: 'Followship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @followship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followships/1
  # DELETE /followships/1.json
  def destroy
    @followship = Followship.find(params[:id])
    @followship.destroy

    respond_to do |format|
      format.html { redirect_to followships_url }
      format.json { head :no_content }
      format.js
    end
  end
end
