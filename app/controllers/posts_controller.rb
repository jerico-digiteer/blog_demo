class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :feed]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: %i[edit update destroy]



  # GET /posts or /posts.json
  def feed 
    published_posts = Post.published 
    @featured_posts = published_posts.where(active: true, featured: true)
    @active_posts = published_posts.where(active: true, featured: false)
    @published_date_posts = published_posts.where("publish_date = ?", Date.today)
  end

  def index
    @posts = current_user.posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.update(views: @post.views + 1)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)
  
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update


        respond_to do |format|
          if @post.update(post_params)
          format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :active, :featured, :publish_date)
    end

    private
    def authorize_user!
      unless @post.user == current_user
        redirect_to feed_path, alert: "You are not authorized to perform this action."
      end
    end
    
end
