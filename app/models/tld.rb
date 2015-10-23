class Tld

  @@lines = []
  cattr_accessor :lines

  File.open(Rails.root.join('db', 'data', 'tlds.txt').to_s) do |fd|
    fd.each do |line|
      unless line[0..1] == '//' || line =~ /^\s$/ # neither comment neither blank
        @@lines << case line[0]
        when '*' then /^[\w-]+#{Regexp.escape(line[1..-1].chomp)}$/i # wildcard
        when '!' then /^#{Regexp.escape(line[1..-1].chomp)}$/i       # domain
        else          /^#{Regexp.escape(line[0..-1].chomp)}$/i       # tld
        end
      end
    end
  end

  def self.include?(name)
    for line in @@lines
      return true if name =~ line
    end
    return false
  end

end
