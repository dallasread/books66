class StoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  # GET /stories
  # GET /stories.json
  def index
    @stories = current_user.stories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    if params[:username]
      @user = User.find_by_username(params[:username])
      @story = @user.stories.find_by_permalink(params[:permalink])
    else
      @story = Story.find_by_permalink(params[:id])
    end
    
    cookies[:story] = @story.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @story }
      format.js
    end
  end

  # GET /stories/new
  # GET /stories/new.json
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find_by_permalink(params[:id])
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = current_user.stories.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render json: @story, status: :created, location: @story }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.json
  def update
    @story = Story.find_by_permalink(params[:id])
    
    if params[:items]
      @story.items.destroy_all
      
      i = 0
      for item in params[:items]
        type = item[1][0]
        content = item[1][1]
        
        @story.items.create(
          ordinal: i,
          variation: type,
          ref: content
        )
        
        i += 1
      end
    end

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { render nothing: true }
        format.json { head :no_content }
      else
        format.html { render nothing: true }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story = Story.find_by_permalink(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :no_content }
      format.js
    end
  end
end
