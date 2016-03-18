#
# EvoStream Media Server Extensions
# EvoStream, Inc.
# (c) 2016 by EvoStream, Inc. (support@evostream.com)
# Released under the MIT License
#

require "./crems/*"

module Crems
  puts "crems version #{VERSION}"
  send_ems("version")
  send_ems("pullstream uri=#{URIS_LIVE[0]} localstreamname=#{STREAM_NAME}")
  uri = "rtmp://#{EMS_IP}/live/#{STREAM_NAME}"
  check_live(uri)
  play(uri, SEC_PLAY)
  send_ems("liststreams")
  send_ems("shutdownstream localstreamname=#{STREAM_NAME} permanently=1")
  send_ems("liststreams")
end
