# rand_datacenter.rb
Facter.add('rand_datacenter') do
  setcode do
    datacenter = '/root/datacenter.txt'
    if File.exists? datacenter
      IO.read(datacenter)
    else
      dc = rand(100) >= 50 ? 'DC1' : 'DC2'
      File.open(datacenter, 'w') { |file| file.write(dc) }
    end
  end
end
