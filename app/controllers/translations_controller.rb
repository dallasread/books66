class TranslationsController < ApplicationController
  # GET /translations
  # GET /translations.json
  def index
    if params[:reset]
      Book.destroy_all
      Chapter.destroy_all
      Verse.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!('books')
      ActiveRecord::Base.connection.reset_pk_sequence!('chapters')
      ActiveRecord::Base.connection.reset_pk_sequence!('verses')
    else
      require "open-uri"
      items = JSON(open("http://mybible.herokuapp.com/assets/kjv_bible#{params[:id]}.json") { |f| f.read })
      @output = items
      b = 1
    
      for item in items
        if item["model"] == "bible.book"
          a = Book.new(
            :name => item["fields"]["name"],
            :permalink => item["fields"]["slug"].parameterize,
            :ordinal => b
          )
          a.id = item["pk"]
          a.save!
        elsif item["model"] == "bible.chapter"
          a = Chapter.new(
            :book_id => item["fields"]["book"],
            :number => item["fields"]["number"]
          )

          a.id = item["pk"]
          a.save!
        elsif item["model"] == "bible.verse"
          a = Verse.new(
            :chapter_id => item["fields"]["chapter"],
            :body => item["fields"]["text"],
            :number => item["fields"]["number"]
          )

          a.id = item["pk"]
          a.save!
        end
      
        b += 1
      end
    end
    
    if params[:id] == 4
      for book in Book.all
        book.chapters_count = book.chapters.count
        book.save
      end
    end

    respond_to do |format|
      format.html { render json: @output }
      format.json { render json: @translations }
    end
  end

  # GET /translations/1
  # GET /translations/1.json
  def show
    @translation = Translation.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @translation }
    end
  end

  # GET /translations/new
  # GET /translations/new.json
  def new
    @translation = Translation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @translation }
    end
  end

  # GET /translations/1/edit
  def edit
    @translation = Translation.find_by_permalink(params[:id])
  end

  # POST /translations
  # POST /translations.json
  def create
    @translation = Translation.new(params[:translation])

    respond_to do |format|
      if @translation.save
        format.html { redirect_to @translation, notice: 'Translation was successfully created.' }
        format.json { render json: @translation, status: :created, location: @translation }
      else
        format.html { render action: "new" }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /translations/1
  # PUT /translations/1.json
  def update
    @translation = Translation.find_by_permalink(params[:id])

    respond_to do |format|
      if @translation.update_attributes(params[:translation])
        format.html { redirect_to @translation, notice: 'Translation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /translations/1
  # DELETE /translations/1.json
  def destroy
    @translation = Translation.find_by_permalink(params[:id])
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to translations_url }
      format.json { head :no_content }
    end
  end
end
