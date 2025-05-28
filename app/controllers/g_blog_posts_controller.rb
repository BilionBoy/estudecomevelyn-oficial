# frozen_string_literal: true
class GBlogPostsController < ApplicationController
  before_action :set_g_blog_post, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GBlogPost.includes(:g_blog_categoria).ransack(params[:q])
    @pagy, @g_blog_posts = pagy(@q.result)
  end

  def new
    @g_blog_post = GBlogPost.new
  end

  def edit
  end

  def create
    @g_blog_post = GBlogPost.new(g_blog_post_params)

    if @g_blog_post.save
      redirect_to g_blog_posts_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_blog_post.update(g_blog_post_params)
      redirect_to g_blog_posts_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_blog_post.destroy
      redirect_to g_blog_posts_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_blog_posts_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_blog_post
    @g_blog_post = GBlogPost.find_by(id: params[:id])
    return redirect_to g_blog_posts_path, alert: t('messages.not_found') unless @g_blog_post
  end

  def g_blog_post_params
    permitted_attributes = GBlogPost.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_blog_post).permit(permitted_attributes.map(&:to_sym), :imagem_blog)
  end

  def handle_not_found
    redirect_to g_blog_posts_path, alert: t('messages.not_found')
  end
end
