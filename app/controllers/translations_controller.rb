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
      @output = "Books, Chapters, and Verses have been reset."
    elsif params[:set] == "kjv"
      @translation = Translation.find_or_create_by_name_and_permalink("King James Version", "kjv")
      
      io = File.open(File.expand_path('../../../public/raw_bibles/kjvgenesis.xml', __FILE__))
      doc = Nokogiri::HTML(io)
      @output = ""
      
      doc.css(".book").each do |b|
        @output += b.content
      end
      
      # doc.css("div[type='book']").each_with_index do |b, i|
      #   book = Book.create(ordinal: i, name: b["osisID"], osis: b["osisID"])
      #   @output += "Added #{b["osisID"]}<br />"
      #   
      #   b.css("chapter").each do |c|
      #     osis = c["osisID"].split(".")
      #     book_osis = osis.first
      #     chapter_number = osis.last
      #     chapter = book.chapters.create(number: chapter_number)
      #     @output += "Added #{c["osisID"]}<br />"
      #     
      #     doc.css("verse").each do |v|
      #       if v["osisID"]
      #         osis = v["osisID"].split(".")
      #         verse_number = osis.last
      #         verse_body = v.content
      #         
      #         verse = @translation.verses.create(
      #           body: verse_body,
      #           chapter_id: chapter.id,
      #           number: verse_number,
      #           ref: v["osisID"]
      #         )
      #   
      #         @output += "Added #{v["osisID"]}<br />"
      #       end
      #     end
      #   end
      #   
      #   book.update_attributes(chapters_count: book.chapters.count)
      # end
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
