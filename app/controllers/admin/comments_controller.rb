class Admin::CommentsController < AdminApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id]), notice: 'コメントを削除しました。'
  end
end
