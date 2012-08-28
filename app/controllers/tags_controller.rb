class TagsController < ApplicationController

  before_filter :prepare_session
  http_basic_authenticate_with :name => ENV['ADMIN_USERNAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:show]

  # GET /tags
  # GET /tags.json
  def index
    redirect_to tag_path('all')
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html {

        if authenticated?
          @posts = @tag.posts.order('created_at DESC').page(params[:page]).per(18)
        else
          @posts = @tag.posts.order('created_at DESC').where(:status => :true).page(params[:page]).per(18)
        end
      }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    authenticated

    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /tags/1/edit
  def edit
    authenticated

    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    authenticated

    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    authenticated

    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    authenticated
    
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end
end
