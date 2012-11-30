class TranslationsController < ApplicationController
  # before_filter :authenticate_admin!
  
  # GET /translations
  # GET /translations.json
  def index
    if params[:reset] == "kjv"
      
      Book.destroy_all
      Chapter.destroy_all
      Verse.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!('books')
      ActiveRecord::Base.connection.reset_pk_sequence!('chapters')
      ActiveRecord::Base.connection.reset_pk_sequence!('verses')
      @output = "Books, Chapters, and Verses have been reset."
    
    elsif params[:reset] == "lexicon"

      Lexicon.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!('lexicons')
      @output = "Lexicons have been reset."
      
    elsif params[:set] == "lexicon"
      
      require "csv"
      @output = ""
      
      %w[greek hebrew].each do |lang|
        
        dictionary = "strong"
      
        io = File.open(File.expand_path("../../../public/raw_lexicons/#{lang}.csv", __FILE__))
      
        CSV.parse(io, :headers => false, :col_sep => "|", :quote_char => "%").each do |line|
          l = Lexicon.create(
            dictionary: "strong",
            code: line[0], 
            orig_word: line[1],
            word_orig: line[2],
            translit: line[3],
            tdnt: line[4],
            phonetic: line[5],
            part_of_speech: line[6],
            st_def: line[7],
            ipd_def: line[8]
          )
          @output += "Added #{line[0]}: #{l.to_json}<br />"
        end
        
      end
      
    elsif params[:set] == "kjv"
      
      @translation = Translation.find_or_create_by_name_and_permalink("King James Version", "kjv")
      
      io = File.open(File.expand_path('../../../public/raw_bibles/kjv.xml', __FILE__))
      doc = Nokogiri::HTML(io)
      @output = ""
      
      doc.css("div[data-type=book]").each_with_index do |b, i|
        book = Book.create(
          ordinal: i, 
          osis: b["data-osisid"].downcase, 
          name: b["data-osisid"], 
          permalink: b["data-osisid"].downcase
        )
        
        @output += "Added #{b["data-osisid"]}<br />"
        
        b.css(".chapter").each do |c|
          osis = c["data-osisid"].split(".")
          book_osis = osis.first
          chapter_number = osis.last
          chapter = book.chapters.create(number: chapter_number)
          @output += "Added #{c["data-osisid"].downcase}<br />"
          
          c.css(".verse").each do |v|
            if v["data-osisid"]
              osis = v["data-osisid"].split(".")
              verse_number = osis.last
              verse_body = v.to_s
              
              verse = @translation.verses.create(
                body: verse_body,
                chapter_id: chapter.id,
                number: verse_number,
                ref: v["data-osisid"].downcase
              )
        
              @output += "Added #{v["data-osisid"].downcase}<br />"
            end
          end
        end
        
        book.update_attributes(chapters_count: book.chapters.count)
      end
    end

    respond_to do |format|
      format.html { render text: @output }
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
