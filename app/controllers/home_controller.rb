class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to albums_path
    end
    
    
    if params[:tag]
      @albums = Album.tagged_with(params[:tag])
    else
      @albums = Album.where(published: true)
    end

    
    @q = Album.where(published: true).ransack(params[:q])
    @albums = @q.result.includes(:tags)

    #@albums = Album.where(published: true)
    #@albums = current_user.albums if current_user.present?
  end
end
