class MusicImporter
  attr_reader :path

  def initialize(path) # accepts filepath to directory of MP3 files
    @path = path
  end

  def files # return all imported filenames
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  end

  def import # import all files from the library, instantiating a new Song object for each file
    files.each{ |f| Song.create_from_filename(f) }
  end
end