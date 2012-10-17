module CASServer; end

require 'active_record'
require 'active_support'
require 'sinatra/base'
require 'builder' # for XML views

$LOG = TorqueBox::Logger.new("CASServer")

require 'casserver/server'

