class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  include CarrierWave::MiniMagick
  #include CarrierWave::ImageOptimizer

  #process :store_dimensions

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  process :set_name
  process :set_md5
  #process :optimize

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def set_name
    model.name = File.basename file.file
  end

  def set_md5
    model.md5 = Digest::MD5.hexdigest File.read(file.file)
  end

  def size_range
    1..5.megabytes
  end
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
     process resize_to_fit: [150, 150]
  end

  version :sample do
     process resize_to_fit: [800, 600], if: :too_big?  
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private



  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

    def too_big?(file)
      width, height = MiniMagick::Image.open(file.file)[:dimensions]
      if width > 800 || height > 600
        model.update(samp: true)
        true
      else
        false
      end
    end
end
