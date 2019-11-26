class Artist 
  extend Concerns::Findable
  
  attr_accessor :name # name is readable and writable
  attr_reader :songs
  
  @@all = [] # class variable, prepped to store saved instances of the class
  
  def initialize(name) #accept a name when initialized
    @name = name 
    @songs = []
  end 
  
  def self.all # class variable is accessible via the class method here 
    @@all
  end 
  
  def self.destroy_all # class empties its array via this method
    self.all.clear
  end
  
  def save 
    @@all << self # adds the instance itself into @@all 
  end 
  
  def self.create(name) #custom constructor
    artist = new(name) # instantiates an instance 
    artist.save # invokes save method, forcing it to persis immediately 
    artist 
  end
  
  def add_song(song) # songs belong to an artist, an artist has many songs
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end
  
  def genres # artists have many genres
    songs.collect{ |s| s.genre }.uniq 
  end 
  
end 
