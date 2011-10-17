require 'socket'
require 'ipaddr'

class CheckForIceland
  def is_icelandic?(address)
    address = IPAddr.new(address) unless address.class == IPAddr
    address = address.native
    
    Socket.getaddrinfo address.reverse.gsub("in-addr.arpa", "iceland.rix.is"), nil if address.ipv4?
    Socket.getaddrinfo address.reverse.gsub("ip6.arpa",     "iceland.rix.is"), nil if address.ipv6?
    
    true
  rescue SocketError => e
    if e.to_s == "getaddrinfo: Name or service not known"
      false
    elsif e.to_s == "getaddrinfo: Temporary failure in name resolution"
      nil
    else
      raise e
    end
  end
end
