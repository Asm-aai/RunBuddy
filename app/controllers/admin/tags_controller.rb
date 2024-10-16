class Admin::TagsController < ApplicationController

  def create
    @tags = Tag.all
    @tag = Tag.new(tag_params)

    if Tag.exists?(name: @tag.name)
      flash.now[:alert] = 'このタグ名は既に存在します。'
      render :index and return
    end

    if @tag.save
      redirect_to admin_tags_path, notice: '追加しました。'
    else
      flash.now[:alert] = 'タグ名を入力してください。'
      render :index
    end
  end

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find(params[:id])
  end

def update
  @tag = Tag.find(params[:id])
  old_name = @tag.name
  new_name = tag_params[:name]

  if Tag.exists?(name: new_name)
    flash.now[:alert] = 'このタグ名は既に存在します。'
    render :edit and return
  end

  if @tag.update(tag_params)
    redirect_to admin_tags_path, notice: 'タグが更新されました。'
  else
    redirect_to edit_admin_tag_path, alert: 'タグ名を入力してください。'
    # renderだと入力フォームが崩れる
  end
end

  def destroy
    @tag = Tag.find(params[:id])
    tag_name = @tag.name
    @tag.destroy
    redirect_to admin_tags_path, notice: "“#{tag_name}”タグが削除されました。"
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
