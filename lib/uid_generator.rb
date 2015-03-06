class UidGenerator
  def initialize
    @uid = nil
  end

  # ABC-4F-ABC-8D-ABC (where: ABC is random 3-char string, 4F, 8D are random hex numbers)
  def generate
    @uid = "#{ random_chars(3) }-#{ random_hex_numbers(1) }-#{ random_chars(3) }-#{ random_hex_numbers(1) }-#{ random_chars(3) }"
  end

  private

  def random_chars(length)
    value = ''
    length.times { value << (65 + rand(25)).chr }
    value
  end

  def random_hex_numbers(length)
    SecureRandom.hex(length).upcase
  end
end
