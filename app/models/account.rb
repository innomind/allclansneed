class Account < ActiveRecord::Base

class BitField
      attr_reader :size
      include Enumerable
      
      ELEMENT_WIDTH = 32
      
      def initialize(size)
        @size = size
        @field = Array.new(((size - 1) / ELEMENT_WIDTH) + 1, 0)
      end
      
      # Set a bit (1/0)
      def []=(position, value)
        if value == 1
          @field[position / ELEMENT_WIDTH] |= 1 << (position % ELEMENT_WIDTH)
        elsif (@field[position / ELEMENT_WIDTH]) & (1 << (position % ELEMENT_WIDTH)) != 0
          @field[position / ELEMENT_WIDTH] ^= 1 << (position % ELEMENT_WIDTH)
        end
      end
      
      # Read a bit (1/0)
      def [](position)
        @field[position / ELEMENT_WIDTH] & 1 << (position % ELEMENT_WIDTH) > 0 ? 1 : 0
      end
      
      # Iterate over each bit
      def each(&block)
        @size.times { |position| yield self[position] }
      end
      
      # Returns the field as a string like "0101010100111100," etc.
      def to_s
        inject("") { |a, b| a + b.to_s }
      end
      
      # Returns the total number of bits that are set
      # (The technique used here is about 6 times faster than using each or inject direct on the bitfield)
      def total_set
        @field.inject(0) { |a, byte| a += byte & 1 and byte >>= 1 until byte == 0; a }
      end
    end


    
  has_many :guestbooks
  has_many :news
  
  #attr_accessor :password
  #attr_accessible :password, :nick, :email
  validates_presence_of :nick
  validates_presence_of :password
  validates_presence_of :email
  validates_presence_of :site_id
  
  #validates_confirmation_of :email
  validates_uniqueness_of :nick
  validates_uniqueness_of :email
  
  belongs_to :site
  before_save :encrypt_password
  
  
  def encrypt_password
    self[:password] = encrypt self[:password]
  end
  
  def encrypt str
    (Digest::SHA256.new << str).hexdigest!
  end
  
  def check_pw pw
    (encrypt pw) == (self[:password])
  end
end
