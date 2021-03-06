class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    @post = Post.find(params[:post_id])
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = current_user.id
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_comment_path, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: post_path }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def upvote
    @comment= Comment.find(params[:id])
    @comment.upvote_by current_user
    @comments = Comment.all
    redirect_to post_path(@comment.post)
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    @comments = Comment.all
    redirect_to post_path(@comment.post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment

      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :content, :user_id, :id)
    end
end
