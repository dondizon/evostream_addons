#
# EvoStream Media Server Extensions
# EvoStream, Inc.
# (c) 2016 by EvoStream, Inc. (support@evostream.com)
# Released under the MIT License
#

require "base64"
require "json"

module Crems
  def self.send_ems(command)
    puts "Send to EMS '#{command}'" if TRACE > 0
    parts = command.split(" ")
    cmd = parts[0]
    parts.delete_at(0)
    par = parts.join(" ")
    params = Base64.encode(par).delete('\n')
    url = "http://#{EMS_IP}:#{EMS_CLI_PORT}/#{cmd}?params=#{params}"
    puts "Sent via HTTP '#{url}'" if TRACE > 1
    text = `curl -s #{url}`
    json = {} of JSON::Any => JSON::Any
    begin
      json = JSON.parse(text)
      puts "Received from EMS:" if TRACE > 0
      puts text if TRACE == 1
      puts json.to_pretty_json if TRACE > 1
    rescue ex
      puts "Error: #{ex.message}" if TRACE > 1
      puts "No response from EMS! Please check if the EMS at #{EMS_IP} is running!"
    end
    json
  end
end
