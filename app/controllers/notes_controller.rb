class NotesController < ApplicationController
  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @story = current_user.stories.find_by_permalink(params[:story_id])
    @note = @story.notes.create(
      body: "",
      user_id: current_user.id
    )
    @story.items.create(
      ordinal: 99999,
      ref: @note.id,
      story_id: @story.id,
      variation: "note"
    )

    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @note }
      format.js
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @story = Story.find(params[:story_id])
    @note = @story.notes.new(params[:note])
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @story = current_user.stories.find_by_permalink(params[:story_id])
    @note = @story.notes.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { render nothing: true }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @story = Story.find(params[:story_id])
    @note = @story.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
      format.js
    end
  end
end
