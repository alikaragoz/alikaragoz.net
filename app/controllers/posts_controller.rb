class PostsController < ApplicationController
  
  before_filter :prepare_session
  http_basic_authenticate_with :name => ENV['ADMIN_USERNAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:index, :feed, :show]

  # GET /posts
  # GET /posts.json
  def index

    # We display the posts be cronological inverted order
    if authenticated?
      @posts = Post.order('created_at DESC').page(params[:page])
    else
      @posts = Post.order('created_at DESC').where(:status => :true).page(params[:page])
    end
  
    respond_to do |format|
      format.html { render html: @posts }
      format.json { render json: @posts }
    end
  end

  def feed
    @posts = Post.order('created_at DESC').where(:status => :true).page(params[:page]).per(25)      

    respond_to do |format|
      format.atom  
      # if you want to permanently redirect to the ATOM feed and do not use the RSS feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end 
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    if !authenticated? && !@post.status
      redirect_to posts_path
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    authenticated

    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    authenticated

    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    authenticated

    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    authenticated

    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authenticated
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
