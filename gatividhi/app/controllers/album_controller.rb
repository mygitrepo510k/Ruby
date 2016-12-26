class AlbumController < ApplicationController
  before_filter :authenticate_user!, :only => [:add_album,:photo_list,:add_photo,:destroy_photo,:album_list,:destroy_album]
  before_filter :check_current_user_member

  def check_current_user_member
    @user_family_member = current_user.family_members(FamilyMember::STATUS[:accepted]) if !current_user.blank?
  end

  def add_album
    @album = Album.find(params[:test_report_id]) if !params[:test_report_id].blank?
    if request.post? || request.put?
      if @album.blank?
        @album = current_user.albums.create(params[:test_reports])  
        flash[:notice] = "Album created successfully."
      else
        @album.update_attributes(params[:test_reports])
        flash[:notice] = "Album updated successfully."
      end
      redirect_to :action => :photo_list ,:test_report_id => @album.id and return
    end
    render :layout => false and return
  end
  
  def destroy_photo
    @album_image = Picture.find(params[:id])
    @album = @album_image.imageable
    @album_image.destroy
    flash[:notice] = "Photo destroy successfully."
    redirect_to :action => :photo_list ,:test_report_id => @album.id and return
  end

  def photo_list
    @album = Album.find(params[:test_report_id]) if !params[:test_report_id].blank?
    @album_images = @album.pictures
  end
  
  def destroy_album
    @album = Album.find(params[:id])
    @album_images = @album.pictures
    @album_images.each do | single | 
      single.destroy
    end
    @album.destroy
    flash[:notice] = "Album destroy successfully."
    redirect_to :action => :album_list  and return
  end

  def album_list
    @albums = current_user.albums
  end
  
  def add_photo
  	@album = Album.find(params[:test_report_id]) 
    if request.post? || request.put?
      @album.pictures.create(params[:test_reports])  
      flash[:notice] = " Photo added successfully "
      redirect_to :action => :photo_list ,:test_report_id => @album.id and return
    end
    render :layout => false and return
  end
end
