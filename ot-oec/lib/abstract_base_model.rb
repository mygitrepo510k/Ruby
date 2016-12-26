class SoftDeletedModel < ActiveRecord::Base
  self.abstract_class = true

  def self.default_scope
    where(deleted: false)
  end

  def delete
    self.update_attribute(:deleted, true)
  end

  def destroy
    self.delete
  end
end

class ModelWithMedia < SoftDeletedModel
  self.abstract_class = true

  IMAGE_FORMATS = ['gif' , 'png' , 'jpg' , 'jpeg']
  VIDEO_FORMATS = ['3g2','3gp','3gp2','3gpp','3gpp2',
    'f4a','f4b','f4v','flv','highwinds','m4a','m4b','m4r','m4v','mkv','mov',
    'mp4','oga','ogv','ogx','ts','webm','wmv']

  def is_image?
    return false unless filepicker_url
    link_extension = filepicker_url.downcase.split('.').last
    IMAGE_FORMATS.include? link_extension
  end

  def is_video?
    return false unless filepicker_url
    link_extension = filepicker_url.downcase.split('.').last
    VIDEO_FORMATS.include? link_extension
  end

  def process_video
    update_attribute(:wistia_id, Wistia.post_video_by_url(filepicker_url)['hashed_id'])
  end

  def get_player
    if wistia_id and !player_embed
      resp = Wistia.get_embed_code(wistia_id)
      if resp.code == '200'
        update_attribute(:player_embed, JSON.parse(resp.body())['html'])
        player_embed.html_safe
      end
    else
      player_embed.html_safe
    end
  end
end
