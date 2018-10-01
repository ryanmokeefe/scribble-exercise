class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end
  def edit    
    @post = Post.find(params[:id])
  end
  def new
    if current_user
    @post = Post.new
    else
      flash[:alert] = "Must be logged in to post"
    end
  end
  def create
    @post = current_user.posts.create!(post_params)
    redirect_to post_path(@post)
  end
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end
  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user
    @post.destroy
    else
      flash[:alert] = "Only the author of the post can delete"
    end
    redirect_to posts_path
  end
  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
