# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use ExceptionNotifier,
  :email_prefix => "[Paradigm Voiceover Exception] ",
  :sender_address => %{"notifier" <support@paradigmagency.com>},
  :exception_recipients => %w{paradigm@agentseo.net}
use Rack::Maintenance,
  :file => Rails.root.join('public', '502.html'),
  :env  => 'MAINTENANCE'
run ParadigmVo::Application
