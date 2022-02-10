class AlbumsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @albums = current_user.albums if current_user.present?

    @q = @albums.ransack(params[:q])
    @albums = @q.result.includes(:tags)
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    
    if @album.save
      redirect_to @album, notice: "Album was succesfully created"
      
    else
      render :new
    end

  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album, notice: "Album was succesfully updated"
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to albums_path, notice: "Album was succesfully destroyed"
  end

  def purge
     image = ActiveStorage::Attachment.find(params[:id])
     image.purge
     redirect_back fallback_location: root_path, notice: "the image was deleted successfully"
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:id])
    redirect_to new_album_path, notice: "you are not correct user" if @album.nil?
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :user_id, :all_tags, :published, :cover_image, :images => [])
    end
end
