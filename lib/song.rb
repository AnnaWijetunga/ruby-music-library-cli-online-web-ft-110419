class Song 
  
  attr_accessor :name
  attr_reader :artist, :genre 
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil) # songs can be initialized with an optional artist & genre argument
    @name = name 
    self.artist = artist if artist # if initialized is called with an artist, setter method is invoked
    self.genre = genre if genre # if initialized is called with a genre, setter method is invoked
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end 
  
  def genre=(genre)
    @genre = genre 
    genre.songs << self unless genre.songs.include?(self)
  end 
  
  def self.all
    @@all
  end 
  
  def self.destroy_all
    self.all.clear
  end
  
  def save
    @@all << self
  end 
  
  def self.reset_all
    @@all.clear 
  end 
  
  def self.create(name)
    song = new(name)
    song.save
    song 
  end
  
  def self.find_by_name(name)
    @@all.detect{ |s| s.name == name} # detect from all songs, that a song name is set to the name we pass in 
  end
  
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  # def self.new_from_filename(filename)
  #   parts = filename.split(" - ")
  #   artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "") # take out the .mp3, leave a space instead
    

  #   artist = Artist.find_or_create_by_name(artist_name)
  #   genre = Genre.find_or_create_by_name(genre_name)

  #   new(song_name, artist, genre)
  # end
  
  def self.new_from_filename(name)
    artist, song, genre_name = name.split(' - ')
    fixed_name = genre_name.gsub('.mp3', '')
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(fixed_name)
    new(song, artist, genre)
  end 
  
  # def self.create_from_filename(filename)
  #   song = new_from_filename(filename)
  #   song.save
  #   song
  #   # new_from_filename(filename).tap{ |s| s.save } - shortcut
  # end
  
  def self.create_from_filename(name)
    new_from_filename(name).save
  end 
  
end 